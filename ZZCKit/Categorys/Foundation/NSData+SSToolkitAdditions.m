//
//  NSData+SSToolkitAdditions.m
//  DDFinance
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "NSData+SSToolkitAdditions.h"
#import "NSString+SSToolkitAdditions.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>



@implementation NSData (SSToolkitAdditions)



//返回十六进制字符串
- (NSString *)ss_hexString {
    
    const unsigned char *dataBuffer = [self bytes];
    
    NSMutableString *strBuffer = [NSMutableString string];
    [strBuffer ss_appendNSDataBytes:dataBuffer Len:self.length];
    return strBuffer;
}


#pragma mark - MD2,4,5加密


//MD2加密
- (NSString *)ss_MD2Sum {
    
    unsigned char digest[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    [strBuffer ss_appendNSDataBytes:digest Len:CC_MD2_DIGEST_LENGTH];
    return strBuffer;
}



//MD4加密
- (NSString *)ss_MD4Sum {
    
    unsigned char digest[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    [strBuffer ss_appendNSDataBytes:digest Len:CC_MD4_DIGEST_LENGTH];
    return strBuffer;
}



//MD5加密
- (NSString *)ss_MD5Sum {

    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    [strBuffer ss_appendNSDataBytes:digest Len:CC_MD5_DIGEST_LENGTH];
    return strBuffer;

}





//MD2加密
- (NSData *)ss_MD2Data {
    
    unsigned char digest[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_MD2_DIGEST_LENGTH];

}



//MD4加密
- (NSData *)ss_MD4Data {
    
    unsigned char digest[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_MD4_DIGEST_LENGTH];
}



//MD5加密
- (NSData *)ss_MD5Data {
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    
}







#pragma mark - SHA1, 224, 256, 384, 512加密


//SHA1加密
- (NSString *)ss_SHA1Sum {
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, digest);

    NSMutableString *strBuffer = [NSMutableString string];
    [strBuffer ss_appendNSDataBytes:digest Len:CC_SHA1_DIGEST_LENGTH];
    return strBuffer;
    
}

//SHA224加密
- (NSString *)ss_SHA224Sum {
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    [strBuffer ss_appendNSDataBytes:digest Len:CC_SHA224_DIGEST_LENGTH];
    return strBuffer;
    
}


//SHA256加密
- (NSString *)ss_SHA256Sum {
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([self bytes], (CC_LONG)[self length], digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    [strBuffer ss_appendNSDataBytes:digest Len:CC_SHA256_DIGEST_LENGTH];
    return strBuffer;
}


//SHA384加密
- (NSString *)ss_SHA384Sum {
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    [strBuffer ss_appendNSDataBytes:digest Len:CC_SHA384_DIGEST_LENGTH];
    return strBuffer;
    
}

//SHA512加密
- (NSString *)ss_SHA512Sum {
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512([self bytes], (CC_LONG)[self length], digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    [strBuffer ss_appendNSDataBytes:digest Len:CC_SHA512_DIGEST_LENGTH];
    return strBuffer;

}



//SHA1加密
- (NSData *)ss_SHA1Data {
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    
}

//SHA224加密
- (NSData *)ss_SHA224Data {
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA224_DIGEST_LENGTH];
    
}


//SHA256加密
- (NSData *)ss_SHA256Data {
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([self bytes], (CC_LONG)[self length], digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
}


//SHA384加密
- (NSData *)ss_SHA384Data {
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA384_DIGEST_LENGTH];
    
}

//SHA512加密
- (NSData *)ss_SHA512Data {
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512([self bytes], (CC_LONG)[self length], digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    
}






#pragma mark - BASE64(to字符串, to NSData)


//BASE64编码
- (NSString *)ss_Base64EncodedString {
    
    return [self base64EncodedStringWithOptions:0];
}

//BASE64反编码
+ (NSString *)ss_Base64DecodedString:(NSString *)base64String {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}



//BASE64编码
- (NSData *)ss_Base64Encoded {
    
    return [self base64EncodedDataWithOptions:0];
}

//BASE64反编码
- (NSData *)ss_Base64Decoded {
    
    return [[NSData alloc] initWithBase64EncodedData:self options:0];
}






#pragma mark - AES256加密


- (NSData *)ss_AES256EncryptWithKey:(NSString *)key {
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes],
                                          dataLength, /* input */
                                          buffer,
                                          bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData *)ss_AES256DecryptWithKey: (NSString *)key {
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes],
                                          dataLength, /* input */
                                          buffer,
                                          bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}





//
///**
// Returns an encrypted NSData using AES.
// 
// @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
// 
// @param iv    An initialization vector length of 16(128bits).
// Pass nil when you don't want to use iv.
// 
// @return      An NSData encrypted, or nil if an error occurs.
// */
//- (NSData *)ss_AES256EncryptWithKey:(NSData *)key iv:(NSData *)iv {
//    
//    //key
//    if (key.length != 16 && key.length != 24 && key.length != 32) {
//        return nil;
//    }
//    
//    //向量
//    if (iv.length != 16 && iv.length != 0) {
//        return nil;
//    }
//    
//    NSData *result = nil;
//    size_t bufferSize = self.length + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    if (!buffer) return nil;
//    size_t encryptedSize = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
//                                          kCCAlgorithmAES128,
//                                          kCCOptionPKCS7Padding,
//                                          key.bytes,
//                                          key.length,
//                                          iv.bytes,
//                                          self.bytes,
//                                          self.length,
//                                          buffer,
//                                          bufferSize,
//                                          &encryptedSize);
//    if (cryptStatus == kCCSuccess) {
//        result = [[NSData alloc]initWithBytes:buffer length:encryptedSize];
//        free(buffer);
//        return result;
//    } else {
//        free(buffer);
//        return nil;
//    }
//}
//
//
//
///**
// Returns an decrypted NSData using AES.
// 
// @param key   A key length of 16, 24 or 32 (128, 192 or 256bits).
// 
// @param iv    An initialization vector length of 16(128bits).
// Pass nil when you don't want to use iv.
// 
// @return      An NSData decrypted, or nil if an error occurs.
// */
//- (NSData *)ss_AES256DecryptWithkey:(NSData *)key iv:(NSData *)iv {
//    
//    if (key.length != 16 && key.length != 24 && key.length != 32) {
//        return nil;
//    }
//    if (iv.length != 16 && iv.length != 0) {
//        return nil;
//    }
//    
//    NSData *result = nil;
//    size_t bufferSize = self.length + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    if (!buffer) return nil;
//    size_t encryptedSize = 0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
//                                          kCCAlgorithmAES128,
//                                          kCCOptionPKCS7Padding,
//                                          key.bytes,
//                                          key.length,
//                                          iv.bytes,
//                                          self.bytes,
//                                          self.length,
//                                          buffer,
//                                          bufferSize,
//                                          &encryptedSize);
//    
//    if (cryptStatus == kCCSuccess) {
//        result = [[NSData alloc]initWithBytes:buffer length:encryptedSize];
//        free(buffer);
//        return result;
//    } else {
//        free(buffer);
//        return nil;
//    }
//}



@end
