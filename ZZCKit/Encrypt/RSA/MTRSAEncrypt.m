//
//  MTRSAEncrypt.m
//
//  Created by liukun on 14-3-21.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "MTRSAEncrypt.h"


@interface MTRSAEncrypt ()


//秘钥存储目录
- (NSString *)openSSLRSAKeyDir;

//公钥路径
- (NSString *)rsaPublicKeyFilePath;

//私钥路径
- (NSString *)rsaPrivateKeyFilePath;

@end



@implementation MTRSAEncrypt

//单例
+ (MTRSAEncrypt *)sharedInstance {
    
    static dispatch_once_t once;
    static MTRSAEncrypt * rsaEncryptSingleton;
    dispatch_once( &once, ^{
        rsaEncryptSingleton = [[MTRSAEncrypt alloc] init];
    } );
    return rsaEncryptSingleton;
}


//初始化
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        // mkdir for key dir
        NSFileManager *fm   = [NSFileManager defaultManager];
        NSString *rsaKeyDir = [self openSSLRSAKeyDir];
        if (![fm fileExistsAtPath:rsaKeyDir]) {
            [fm createDirectoryAtPath:rsaKeyDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}



#pragma mark - RSAKeyPath

//秘钥存储目录
- (NSString *)openSSLRSAKeyDir {
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documentPath stringByAppendingPathComponent:@".openssl_rsa"];
}


//公钥路径
- (NSString *)rsaPublicKeyFilePath {
    
    NSString *rsaKeyDir = [self openSSLRSAKeyDir];
    return [rsaKeyDir stringByAppendingPathComponent:@"flow.publicKey.pem"];
}


//私钥路径
- (NSString *)rsaPrivateKeyFilePath {
    
    NSString *rsaKeyDir = [self openSSLRSAKeyDir];
    return [rsaKeyDir stringByAppendingPathComponent:@"flow.privateKey.pem"];
}




//#pragma mark - 生成密钥
//
////生成密钥
//- (BOOL)generateRSAKeyPairWithKeySize:(int)keySize {
//
//    if (NULL != _rsa) {
//
//        RSA_free(_rsa);
//        _rsa = NULL;
//    }
//    _rsa = RSA_generate_key(keySize, RSA_F4, NULL, NULL);
//    assert(_rsa != NULL);
//
//
//    NSString *tempPublicKeyPath    = [self rsaPublicKeyFilePath];
//    NSString *tempPrivateKeyPath   = [self rsaPrivateKeyFilePath];
//
//    const char *publicKeyFilePath  = [tempPublicKeyPath cStringUsingEncoding:NSASCIIStringEncoding];
//    const char *privateKeyFilePath = [tempPrivateKeyPath cStringUsingEncoding:NSASCIIStringEncoding];
//
//    //写入私钥和公钥
//    RSA_blinding_on(_rsa, NULL);
//
//    BIO *priBio = BIO_new_file(privateKeyFilePath, "w");
//    PEM_write_bio_RSAPrivateKey(priBio, _rsa, NULL, NULL, 0, NULL, NULL);
//
//    BIO *pubBio = BIO_new_file(publicKeyFilePath, "w");
//    PEM_write_bio_RSAPublicKey(pubBio, _rsa);
//
//    BIO_free(priBio);
//    BIO_free(pubBio);
//
//    //获取私钥
//    _rsaPrivate = RSAPrivateKey_dup(_rsa);
//    assert(_rsaPrivate != NULL);
//
//
//    //获取公钥
//    _rsaPublic = RSAPublicKey_dup(_rsa);
//    assert(_rsaPublic != NULL);
//
//    if (_rsa && _rsaPublic && _rsaPrivate) {
//        return YES;
//    } else {
//        return NO;
//    }
//}


#pragma mark - 导入密钥



- (BOOL)importRSAPublicKeyBase64:(NSString *)publicKey {
    
    //1 格式化公钥
    NSMutableString *result = [NSMutableString string];
    [result appendString:@"-----BEGIN PUBLIC KEY-----\n"];
    
    int count = 0;
    for (int i = 0; i < [publicKey length]; ++i) {
        
        unichar c = [publicKey characterAtIndex:i];
        if (c == '\n' || c == '\r') {
            continue;
        }
        
        [result appendFormat:@"%c", c];
        
        if (++count == 64) {
            [result appendString:@"\n"];
            count = 0;
        }
    }

    [result appendString:@"\n-----END PUBLIC KEY-----"];
    
    //2 写入文件
    NSString *publicKeyFilePath = [self rsaPublicKeyFilePath];
    [result writeToFile:publicKeyFilePath
             atomically:YES
               encoding:NSASCIIStringEncoding
                  error:NULL];
    
    
    //3 从文件中读取公钥
    FILE *publicKeyFile;
    const char *publicKeyFileName = [publicKeyFilePath cStringUsingEncoding:NSASCIIStringEncoding];
    publicKeyFile = fopen(publicKeyFileName,"rb");
    if (NULL != publicKeyFile) {
        
        BIO *bpubkey = NULL;
        bpubkey = BIO_new(BIO_s_file());
        BIO_read_filename(bpubkey, publicKeyFileName);
        
        _rsaPublic = PEM_read_bio_RSA_PUBKEY(bpubkey, NULL, NULL, NULL);
        assert(_rsaPublic != NULL);
        BIO_free_all(bpubkey);
    }
    
    return YES;
}


- (BOOL)importRSAPrivateKeyBase64:(NSString *)privateKey {
    
    //1 格式化私钥
    const char *pstr = [privateKey UTF8String];
    int len = (int)[privateKey length];
    NSMutableString *result = [NSMutableString string];
    [result appendString:@"-----BEGIN RSA PRIVATE KEY-----\n"];
    
    int index = 0;
    int count = 0;
    while (index < len) {
        char ch = pstr[index];
        if (ch == '\r' || ch == '\n') {
            ++index;
            continue;
        }
        [result appendFormat:@"%c", ch];
        if (++count == 64)
        {
            [result appendString:@"\n"];
            count = 0;
        }
        index++;
    }
    
    [result appendString:@"\n-----END RSA PRIVATE KEY-----"];
    
    
    //2 写入文件
    NSString *privateKeyFilePath = [self rsaPrivateKeyFilePath];
    [result writeToFile:privateKeyFilePath
             atomically:YES
               encoding:NSASCIIStringEncoding
                  error:NULL];
    
    
    
    
    //3 从文件中读取私钥
    FILE *privateKeyFile;
    const char *privateKeyFileName = [privateKeyFilePath cStringUsingEncoding:NSASCIIStringEncoding];
    privateKeyFile = fopen(privateKeyFileName,"rb");
    
    if (NULL != privateKeyFile)
    {
        BIO *bpubkey = NULL;
        bpubkey = BIO_new(BIO_s_file());
        BIO_read_filename(bpubkey, privateKeyFileName);
        
        _rsaPrivate = PEM_read_bio_RSAPrivateKey(bpubkey, NULL, NULL, NULL);
        assert(_rsaPrivate != NULL);
        BIO_free_all(bpubkey);
    }
    
    return YES;
}





- (NSString *)base64EncodedPublicKey {
    
    NSString *publicKeyFilePath = [self rsaPublicKeyFilePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:publicKeyFilePath]) {
        
        NSString *str = [NSString stringWithContentsOfFile:publicKeyFilePath encoding:NSUTF8StringEncoding error:nil];
        NSString *string = [[str componentsSeparatedByString:@"-----"] objectAtIndex:2];
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        return string;
    }
    return nil;
}

- (NSString *)base64EncodedPrivateKey {
    
    NSString *privateKeyFilePath = [self rsaPrivateKeyFilePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:privateKeyFilePath]) {
        
        NSString *str = [NSString stringWithContentsOfFile:privateKeyFilePath encoding:NSUTF8StringEncoding error:nil];
        NSString *string = [[str componentsSeparatedByString:@"-----"] objectAtIndex:2];
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        return string;
    }
    return nil;
}


#pragma mark - 加密解密

//公钥加密
- (NSData *)encryptWithPublicKeyUsingPadding:(MTRSA_PADDING_TYPE)padding plainData:(NSData *)plainData {
    
    NSAssert(_rsaPublic != NULL, @"You should import public key first");
    
    if ([plainData length]) {
        
        int len = (int)[plainData length];
        unsigned char *plainBuffer = (unsigned char *)[plainData bytes];
        
        //result len
        int clen = RSA_size(_rsaPublic);
        unsigned char *cipherBuffer = calloc(clen, sizeof(unsigned char));
        
        RSA_public_encrypt(len,plainBuffer,cipherBuffer, _rsaPublic,  padding);
        
        NSData *cipherData = [[NSData alloc] initWithBytes:cipherBuffer length:clen];
        
        free(cipherBuffer);
        
        return cipherData;
    }
    
    return nil;
}


//私钥加密
- (NSData *)encryptWithPrivateKeyUsingPadding:(MTRSA_PADDING_TYPE)padding plainData:(NSData *)plainData {
    
    
    NSAssert(_rsaPrivate != NULL, @"You should import private key first");
    
    if ([plainData length]) {
        
        int len = (int)[plainData length];
        unsigned char *plainBuffer = (unsigned char *)[plainData bytes];
        
        //result len
        int clen = RSA_size(_rsaPrivate);
        unsigned char *cipherBuffer = calloc(clen, sizeof(unsigned char));
        
        RSA_private_encrypt(len,plainBuffer,cipherBuffer, _rsaPrivate,  padding);
        
        NSData *cipherData = [[NSData alloc] initWithBytes:cipherBuffer length:clen];
        
        free(cipherBuffer);
        
        return cipherData;
    }
    
    return nil;
}


//私钥解密
- (NSData *)decryptWithPrivateKeyUsingPadding:(MTRSA_PADDING_TYPE)padding cipherData:(NSData *)cipherData {
    
    NSAssert(_rsaPrivate != NULL, @"You should import private key first");
    
    if ([cipherData length]) {
        
        int len = (int)[cipherData length];
        unsigned char *cipherBuffer = (unsigned char *)[cipherData bytes];
        
        //result len
        int mlen = RSA_size(_rsaPrivate);
        unsigned char *plainBuffer = calloc(mlen, sizeof(unsigned char));
        
        RSA_private_decrypt(len, cipherBuffer, plainBuffer, _rsaPrivate, padding);
        
        NSData *plainData = [[NSData alloc] initWithBytes:plainBuffer length:mlen];
        
        free(plainBuffer);
        
        return [self trimNullWithData:plainData];
    }
    
    return nil;
}


//公钥解密
- (NSData *)decryptWithPublicKeyUsingPadding:(MTRSA_PADDING_TYPE)padding cipherData:(NSData *)cipherData {
    
    NSAssert(_rsaPublic != NULL, @"You should import public key first");
    
    if ([cipherData length]) {
        
        int len = (int)[cipherData length];
        unsigned char *cipherBuffer = (unsigned char *)[cipherData bytes];
        
        //result len
        int mlen = RSA_size(_rsaPublic);
        unsigned char *plainBuffer = calloc(mlen, sizeof(unsigned char));
        
        RSA_public_decrypt(len, cipherBuffer, plainBuffer, _rsaPublic, padding);
        
        NSData *plainData = [[NSData alloc] initWithBytes:plainBuffer length:mlen];
        
        free(plainBuffer);
        
        return [self trimNullWithData:plainData];
    }
    
    return nil;
}





#pragma mark - Private

//去掉data末尾的0x0
- (NSData *)trimNullWithData:(NSData *)data {
    
    NSInteger pos = [data length];
    const char *dataPtr = (const char *)[data bytes];
    for (NSInteger i = [data length] - 1; i >= 0; --i) {
        char ch = dataPtr[i];
        if (ch == 0x0) {
            pos = i;
        } else {
            break;
        }
    }
    return [data subdataWithRange:NSMakeRange(0, pos)];
}



@end
