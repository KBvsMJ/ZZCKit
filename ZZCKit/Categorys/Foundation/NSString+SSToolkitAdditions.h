//
//  NSString+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableString (SSToolkitAdditions)

- (void)ss_appendNSDataBytes:(const unsigned char *)bytes Len:(NSUInteger)len;

@end


@interface NSString (SSToolkitAdditions)


- (NSData *)ss_data;

- (NSUInteger)ss_hexValue;                              //16进制字符串转换为整数

- (NSUInteger)ss_numberOfLines;                         //行数

- (NSString *)ss_trim;                                  //剔除空白符和换行符

- (BOOL)ss_containsString:(NSString *)string;           //是否包含子字符串


#pragma mark - HTML转义

- (NSString *)ss_escapeHTML;
- (NSString *)ss_unescapeHTML;


#pragma mark - URL的UTF8编码解码
-(NSString *)ss_urlUTF8Encode;
-(NSString *)ss_urlUTF8Decode;



#pragma mark - 字符串校验


//判断是否未中文字符串
- (BOOL)ss_isChinese;


//判断是否为有效的email地址
- (BOOL)ss_isValidateEmailAddr;

//判断是否未有效的手机号码
- (BOOL)ss_isValidateMobileNum;


//校验用户固话号码
- (BOOL)ss_isValidatePhoneNum;

//判断是否为有效的车牌号
- (BOOL)ss_isValidateCarNo;

//判断是否为有效的身份证号码
- (BOOL)ss_isValidateIDCardNumber;


@end






