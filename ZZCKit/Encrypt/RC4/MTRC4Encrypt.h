//
//
//  Created by dyn on 13-6-5.
//  Copyright (c) 2013年 dyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTRC4Encrypt : NSObject


/**
 *  RC4加密
 *
 *  @param plainText 明文
 *  @param key       密钥
 *
 *  @return base64的密文
 */
+ (NSString *)RC4EncryptWithPlainText:(NSString *)plainText Key:(NSString *)key;


/**
 *  RC4解密
 *
 *  @param cipherText base64的密文
 *  @param key        密钥
 *
 *  @return 明文
 */
+ (NSString *)RC4DecryptWithCipherText:(NSString *)cipherText Key:(NSString *)key;


@end
