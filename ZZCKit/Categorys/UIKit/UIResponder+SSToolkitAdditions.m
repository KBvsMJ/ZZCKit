//
//  UIResponder+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "UIResponder+SSToolkitAdditions.h"

@implementation UIResponder (SSToolkitAdditions)

- (void)ss_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] ss_routerEventWithName:eventName userInfo:userInfo];
}

@end
