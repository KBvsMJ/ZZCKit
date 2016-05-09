//
//  DDLUtilHelper.m
//    
//
//  Created by zzc on 15/7/11.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "MTUtilHelper.h"

#import <pthread.h>
#import <sys/time.h>
#import <sys/sysctl.h>
#import <arpa/inet.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation MTUtilHelper


#pragma mark benchMark

+ (void)benchmarkTask:(void (^)(void))taskBlock Complete:(void (^)(double ms))complete {
    
    // <QuartzCore/QuartzCore.h> 版本
    
    CFTimeInterval begin, end, ms;
    begin = CACurrentMediaTime();
    taskBlock();
    end = CACurrentMediaTime();
    
    ms = (end - begin) * 1000.0;
    complete(ms);
    
    //    // <sys/time.h> 版本
    //    struct timeval t0, t1;
    //    gettimeofday(&t0, NULL);
    //    taskBlock();
    //    gettimeofday(&t1, NULL);
    //
    //    double ms = (double)(t1.tv_sec - t0.tv_sec) * 1e3 + (double)(t1.tv_usec - t0.tv_usec) * 1e-3;
    //    complete(ms);
}





#pragma mark - Bundle


+ (UINib *)nibWithName:(NSString *)nibName {
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    return [UINib nibWithNibName:nibName bundle:mainBundle];
}

+ (UINib *)nibWithName:(NSString *)nibName FromBundle:(NSBundle *)bundle {
    UINib *nib = nil;
    if (bundle) {
        nib = [UINib nibWithNibName:nibName bundle:bundle];
    } else {
        nib = [self nibWithName:nibName];
    }
    return nib;
    
}

+ (NSBundle *)bundleWithName:(NSString *)bundleName {
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    return [NSBundle bundleWithPath:bundlePath];
}




#pragma mark - Common Function


+ (BOOL)isValidIPAddress:(NSString *)address {
    
    if ([address length] < 1)
        return NO;
    
    struct in_addr addr;
    return (inet_aton([address UTF8String], &addr) == 1);
}

+ (BOOL)isValidPortAddress:(NSString *)address {
    
    
    if ([address length] < 1)
        return NO;
    
    NSScanner * scanner = [NSScanner scannerWithString:address];
    if ([scanner scanInt:nil] && [scanner isAtEnd]) {
        return (1 <= [address integerValue]) && ([address integerValue] <= 255);
    }
    
    return NO;
    
}


#pragma mark  Common utilities


+(NSString *)getDeviceTokenFromData:(NSData *)deviceToken {
    
    //获取APNS设备令牌
    NSMutableString * deviceTokenStr = [NSMutableString stringWithFormat:@"%@",deviceToken];
    NSRange allRang;
    allRang.location    = 0;
    allRang.length      = deviceTokenStr.length;
    
    [deviceTokenStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:allRang];
    
    NSRange begin   = [deviceTokenStr rangeOfString:@"<"];
    NSRange end     = [deviceTokenStr rangeOfString:@">"];
    
    NSRange deviceRange;
    deviceRange.location    = begin.location + 1;
    deviceRange.length      = end.location - begin.location -1;
    
    return [deviceTokenStr substringWithRange:deviceRange];
}


+(void)invokeVibration {
    
    //TODO: 振动调用
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}



+ (void)call:(NSString *)telephoneNum {
    
    NSString *str = [NSString stringWithFormat:@"tel://%@", telephoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+ (void)sendSMS:(NSString *)telephoneNum {
    
    NSString *str = [NSString stringWithFormat:@"sms://%@", telephoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+ (void)sendEmail:(NSString *)emailAddr {
    
    NSString *str = [NSString stringWithFormat:@"mailto://%@", emailAddr];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+ (void)openUrl:(NSString *)url {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+(NSStringEncoding)getGBKEncoding {
    
    //获得中文gbk编码
    return CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
}



@end
