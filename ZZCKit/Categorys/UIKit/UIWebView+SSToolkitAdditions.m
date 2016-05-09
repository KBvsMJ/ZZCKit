//
//  UIWebView+SSToolkitAdditions.m
//    
//
//  Created by zzc on 15/8/2.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "UIWebView+SSToolkitAdditions.h"

@implementation UIWebView (SSToolkitAdditions)


- (void)ss_defaultConfig {
    self.scalesPageToFit = YES;
    self.mediaPlaybackRequiresUserAction = NO;
    self.opaque = NO;
    self.dataDetectorTypes = UIDataDetectorTypeAll;
}


- (void)ss_clean:(BOOL)clean {
    [self loadHTMLString:@"" baseURL:nil];
    [self stopLoading];
}


- (NSString*)ss_innerHTML {
    return [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
}

- (NSString*)ss_htmlTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (NSString*)ss_userAgent {
    return [self stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];;
}




@end
