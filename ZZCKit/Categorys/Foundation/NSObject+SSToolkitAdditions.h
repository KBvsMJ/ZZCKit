//
//  NSObject+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SSToolkitAdditions)


#pragma mark - 类信息

+ (NSString *)ss_className;     //类名
+ (NSArray *)ss_allProperty;    //属性名数组
+ (NSArray *)ss_allVar;         //成员变量名数组
+ (NSArray *)ss_allMethod;      //方法名数组


#pragma mark - JSON

- (NSString *)ss_jsonString;



#pragma mark - GCDTime


/**
 Returns a dispatch_time delay from now.
 */
+ (dispatch_time_t)ss_dispatchTimeDelay:(NSTimeInterval)second;

/**
 Returns a dispatch_wall_time delay from now.
 */
+ (dispatch_time_t)ss_dispatchWalltimeDelay:(NSTimeInterval)second;


#pragma mark - GCD

/**
 Whether in main queue/thread.
 */
+(BOOL)is_dispatchMainQueue;

//主线程同步执行block
- (void)ss_syncDispatchOnMainThread:(void(^)(void))block;

//主线程异步执行block
- (void)ss_asyncDispatchOnMainThread:(void(^)(void))block;

//后台异步执行block
- (void)ss_asyncDispatchOnGlobalQueue:(void(^)(void))block;

//几秒后执行block
- (void)ss_asyncDispatchBlock:(void(^)(void))block
                      OnQueue:(dispatch_queue_t)queue
                   afterDelay:(NSTimeInterval)delay;




#pragma mark - 主线程执行可取消的block

- (id)ss_dispatchOnMainThreadWithBlock:(void (^)(void))block
                            afterDelay:(NSTimeInterval)delay;

- (id)ss_dispatchOnMainThreadWithBlock:(void (^)(id arg))block
                            withObject:(id)anObject
                            afterDelay:(NSTimeInterval)delay;

- (void)ss_cancelWrappingBlock:(id)wrappingBlock;

@end
