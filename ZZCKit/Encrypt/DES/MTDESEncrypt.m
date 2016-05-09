//
//  MTDESEncrypt.m
//  EncryptDemo
//
//  Created by meitu on 16/4/18.
//  Copyright © 2016年 meitu. All rights reserved.
//



#import "MTDESEncrypt.h"
#import "NSData+SSToolkitAdditions.h"

#import <stdio.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>




@interface MTDESEncrypt ()

+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;

+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;


@end



@implementation MTDESEncrypt

/**
 *  DES加密
 *
 *  @param plainText 明文
 *  @param key       密钥
 *
 *  @return 返回加密后base64的密文
 */
+ (NSString *)DESEncryptWithPlainText:(NSString *)plainText Key:(NSString *)key {

    NSString *cipherText = nil;
    NSData *plainData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *cipherData = [self DESEncrypt:plainData WithKey:key];

    if (cipherData) {

        //base64
        cipherText = [cipherData ss_Base64EncodedString];
    }
    
    return cipherText;
}


/**
 *  DES解密
 *
 *  @param cipherText base64的密文
 *  @param key        密钥
 *
 *  @return 返回明文
 */
+ (NSString *)DESDecryptWithCipherText:(NSString *)cipherText Key:(NSString *)key {
    
    NSString *plainText = nil;
    
    //反base64
    NSData *baseData = [cipherText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *cipherData = [baseData ss_Base64Decoded];
    
    NSData *plainData = [self DESDecrypt:cipherData WithKey:key];
    if (plainData) {
        plainText = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    }
    return plainText;
}





#pragma mark - 3DES加解密

/**
 *  3DES加密
 *
 *  @param plainText 明文
 *  @param key       密钥
 *
 *  @return 返回加密后base64的密文
 */
+ (NSString*)TripleDESEncryptWithPlainText:(NSString *)plainText Key:(NSString *)key {

    //http://blog.csdn.net/justinjing0612/article/details/8482689
    
    const void *vPlainText     = NULL;
    size_t plainTextBufferSize = 0;
    
    //加密
    NSData* data        = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    plainTextBufferSize = [data length];
    vPlainText          = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr   = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes    = 0;
    
    bufferPtrSize = 1024; //(cipherTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    const void *vkey = (const void *)[key UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vPlainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    
    if (ccStatus != kCCSuccess) {
        return nil;
    }

    NSData *cipherData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return [cipherData ss_Base64EncodedString];
}




/**
 *  3DES解密
 *
 *  @param cipherText base64的密文
 *  @param key        密钥
 *
 *  @return 返回明文
 */
+ (NSString*)TripleDESDecryptWithCipherText:(NSString *)cipherText Key:(NSString *)key {
    
    
    //http://blog.csdn.net/justinjing0612/article/details/8482689
    
    const void *vcipherText     = NULL;
    size_t cipherTextBufferSize = 0;
    
    //反Base64
    NSData *encryptData  = [[cipherText dataUsingEncoding:NSUTF8StringEncoding] ss_Base64Decoded];
    cipherTextBufferSize = [encryptData length];
    vcipherText          = (const void *)[encryptData bytes];
    
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr   = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes    = 0;
    
    bufferPtrSize = 1024; //(cipherTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
 
    
    bufferPtr     = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    const void *vkey = (const void *)[key UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vcipherText,
                       cipherTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    

    if (ccStatus != kCCSuccess) {
        return nil;
    }
    
    NSData *plainData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
}




#pragma mark - Private

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/

+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key {

    const void *vkey = (const void *)[key UTF8String];
    
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = 1024; //dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          vkey,
                                          kCCBlockSizeDES,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}




/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/

+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key {
    
    const void *vkey = (const void *)[key UTF8String];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = 1024; //dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          vkey,
                                          kCCBlockSizeDES,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}


@end
