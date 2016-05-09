//
//  MTDESEncrypt.h
//  EncryptDemo
//
//  Created by meitu on 16/4/18.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MTDESEncrypt : NSObject


/**
 *  DES加密
 *
 *  @param plainText 明文
 *  @param key       密钥
 *
 *  @return 返回加密后base64的密文
 */
+ (NSString *)DESEncryptWithPlainText:(NSString *)plainText Key:(NSString *)key;




/**
 *  DES解密
 *
 *  @param cipherText base64的密文
 *  @param key        密钥
 *
 *  @return 返回明文
 */
+ (NSString *)DESDecryptWithCipherText:(NSString *)cipherText Key:(NSString *)key;


#pragma mark - 3DES加解密

/**
 *  3DES加密
 *
 *  @param plainText 明文
 *  @param key       密钥
 *
 *  @return 返回加密后base64的密文
 */
+ (NSString*)TripleDESEncryptWithPlainText:(NSString *)plainText Key:(NSString *)key;



/**
 *  3DES解密
 *
 *  @param cipherText base64的密文
 *  @param key        密钥
 *
 *  @return 返回明文
 */
+ (NSString*)TripleDESDecryptWithCipherText:(NSString *)cipherText Key:(NSString *)key;




@end
