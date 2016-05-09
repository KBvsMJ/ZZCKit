//
//  MTTaskQueue.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "MTTaskQueue.h"

@implementation MTTaskQueue


+ (MTTaskQueue *)sharedInstance
{
    static dispatch_once_t once;
    static MTTaskQueue * taskQueueSingleton;
    dispatch_once( &once, ^{
        taskQueueSingleton = [[MTTaskQueue alloc] init];
    } );
    return taskQueueSingleton;
}


- (id)init
{
    self = [super init];
    if (self) {
        _foreQueue = dispatch_get_main_queue();                                     //主线程
        _backQueue = dispatch_queue_create( "com.MT.taskQueue", nil);              //私有串行队列
    }
    
    return self;
}

- (dispatch_queue_t)foreQueue
{
    return _foreQueue;
}

- (dispatch_queue_t)backQueue
{
    return _backQueue;
}


- (void)enqueueForeground:(dispatch_block_t)block
{
    dispatch_async( _foreQueue, block );
}

- (void)enqueueBackground:(dispatch_block_t)block
{
    dispatch_async( _backQueue, block );
}

//延迟ms执行
- (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
    dispatch_after( time, _foreQueue, block );
}

//延迟ms执行
- (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block
{
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
    dispatch_after( time, _backQueue, block );
}

@end