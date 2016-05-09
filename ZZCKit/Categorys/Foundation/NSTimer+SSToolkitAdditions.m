//
//  NSTimer+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "NSTimer+SSToolkitAdditions.h"

@implementation NSTimer (SSToolkitAdditions)

-(void)ss_pauseTimer {
    
    if (![self isValid]) {
        return;
    }
    
    [self setFireDate:[NSDate distantFuture]];  //将来某个时间
}


-(void)ss_resumeTimer {
    
    if (![self isValid]) {
        return;
    }
    
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [self setFireDate:[NSDate date]];
}


- (void)ss_resumeTimerAfterTimeInterval:(NSTimeInterval)interval {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}


@end
