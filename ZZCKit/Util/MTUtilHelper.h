//
//  DDLUtilHelper.h
//    
//
//  Created by zzc on 15/7/11.
//  Copyright (c) 2015年 fdd. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MTUtilHelper : NSObject



#pragma mark - benchMark

+ (void)benchmarkTask:(void (^)(void))taskBlock Complete:(void (^)(double ms))complete;


#pragma mark - Bundle


+ (UINib *)nibWithName:(NSString *)nibName;

+ (UINib *)nibWithName:(NSString *)nibName FromBundle:(NSBundle *)bundle;

+ (NSBundle *)bundleWithName:(NSString *)bundleName;


#pragma mark - Common Function

+ (BOOL)isValidIPAddress:(NSString *)address;                   //校验IP
+ (BOOL)isValidPortAddress:(NSString *)address;                 //校验Port

+ (void)invokeVibration;                                        //震动
+ (void)call:(NSString *)telephoneNum;                          //拨打电话
+ (void)sendSMS:(NSString *)telephoneNum;                       //发送短信
+ (void)sendEmail:(NSString *)emailAddr;                        //发送邮件
+ (void)openUrl:(NSString *)url;                                //打开网页

+ (NSStringEncoding)getGBKEncoding;                             //获得中文gbk编码

+ (NSString *)getDeviceTokenFromData:(NSData *)deviceToken;     //获取APNS设备令牌

@end
