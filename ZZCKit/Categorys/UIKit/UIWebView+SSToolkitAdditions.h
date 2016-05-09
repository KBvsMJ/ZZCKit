//
//  UIWebView+SSToolkitAdditions.h
//    
//
//  Created by zzc on 15/8/2.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (SSToolkitAdditions)

//默认配置
- (void)ss_defaultConfig;

//清理网页
- (void)ss_clean:(BOOL)clean;

//获取当前页面的html
- (NSString*)ss_innerHTML;

//获取当前页面的Title
- (NSString*)ss_htmlTitle;


//获取userAgent
- (NSString*)ss_userAgent;




@end
