//
//
//  Created by dyn on 13-6-5.
//  Copyright (c) 2013年 dyn. All rights reserved.
//

#import "MTRC4Encrypt.h"

//#import "NSData+SSToolkitAdditions.h"

#import <stdio.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>



@implementation MTRC4Encrypt



+ (NSString *)RC4EncryptWithPlainText:(NSString *)plainText Key:(NSString *)key {

    NSData *plainData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
 
    const void *vkey = (const void *)[key UTF8String];
    NSUInteger dataLength = [plainData length];
    
    size_t bufferSize = 1024;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmRC4,
                                          kCCOptionPKCS7Padding,
                                          vkey,
                                          kCCBlockSizeRC2,
                                          NULL,
                                          [plainData bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    
  
    if (cryptStatus != kCCSuccess) {
        return nil;
    }
    
    NSData *cipherData  = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    return [cipherData ss_Base64EncodedString];
}




+ (NSString *)RC4DecryptWithCipherText:(NSString *)cipherText Key:(NSString *)key {

    //反base64
    NSData *baseData = [cipherText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *cipherData = [baseData ss_Base64Decoded];
    
    
    const void *vkey = (const void *)[key UTF8String];
    NSUInteger dataLength = [cipherData length];
    
    size_t bufferSize = 1024; //dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmRC4,
                                          kCCOptionPKCS7Padding,
                                          vkey,
                                          kCCBlockSizeRC2,
                                          NULL,
                                          [cipherData bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    
    
    if (cryptStatus != kCCSuccess) {
        return nil;
    }
    
    NSData *plainData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    return [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];

}


@end




