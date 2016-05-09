//
//  NSData+SSToolkitAdditions.h
//  DDFinance
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSData (SSToolkitAdditions)


//返回十六进制字符串
- (NSString *)ss_hexString;


#pragma mark - MD2,4,5加密

- (NSString *)ss_MD2Sum;            //MD2加密
- (NSString *)ss_MD4Sum;            //MD4加密
- (NSString *)ss_MD5Sum;            //MD5加密

- (NSData *)ss_MD2Data;             //MD2加密
- (NSData *)ss_MD4Data;             //MD4加密
- (NSData *)ss_MD5Data;             //MD5加密



#pragma mark - SHA1, 224, 256, 384, 512加密

- (NSString *)ss_SHA1Sum;           //SHA1加密
- (NSString *)ss_SHA224Sum;         //SHA224加密
- (NSString *)ss_SHA256Sum;         //SHA256加密
- (NSString *)ss_SHA384Sum;         //SHA384加密
- (NSString *)ss_SHA512Sum;         //SHA512加密

- (NSData *)ss_SHA1Data;            //SHA1加密
- (NSData *)ss_SHA224Data;          //SHA224加密
- (NSData *)ss_SHA256Data;          //SHA256加密
- (NSData *)ss_SHA384Data;          //SHA384加密
- (NSData *)ss_SHA512Data;          //SHA512加密




#pragma mark - BASE64(to字符串, to NSData)

- (NSString *)ss_Base64EncodedString;                           //BASE64编码
+ (NSString *)ss_Base64DecodedString:(NSString *)base64String;  //BASE64反编码

- (NSData *)ss_Base64Encoded;                                   //BASE64编码
- (NSData *)ss_Base64Decoded;                                   //BASE64反编码




#pragma mark - AES256加密


// 'key' should be 32 bytes for AES256, will be null-padded otherwise
- (NSData *)ss_AES256EncryptWithKey:(NSString *)key;            //AES256加密

// 'key' should be 32 bytes for AES256, will be null-padded otherwise
- (NSData *)ss_AES256DecryptWithKey: (NSString *)key;           //AES256解密

@end
