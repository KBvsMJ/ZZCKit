//
//  NSTimer+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SSToolkitAdditions)

-(void)ss_pauseTimer;          //暂停定时器
-(void)ss_resumeTimer;         //唤醒定时器

//多久后唤醒
- (void)ss_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;


@end
