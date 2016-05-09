//
//  MTTaskQueue.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTTaskQueue : NSObject
{
    dispatch_queue_t _foreQueue;    //前台队列
    dispatch_queue_t _backQueue;    //后台队列
}

+ (MTTaskQueue *)sharedInstance;


- (dispatch_queue_t)foreQueue;
- (dispatch_queue_t)backQueue;

//
- (void)enqueueForeground:(dispatch_block_t)block;
- (void)enqueueBackground:(dispatch_block_t)block;

//延迟执行
- (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;
- (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block;

@end
