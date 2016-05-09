//
//  NSObject+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "NSObject+SSToolkitAdditions.h"

#import <pthread.h>
#import <sys/time.h>
#import <objc/runtime.h>




@implementation NSObject (SSToolkitAdditions)


#pragma mark - info


+ (NSString *)ss_className {
    
    return NSStringFromClass([self class]);
}


+ (NSArray *)ss_allProperty {

    NSMutableArray *resArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    //获取属性列表,属性个数
    unsigned int propertiesCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class],&propertiesCount);
    
    for(int i=0; i<propertiesCount; i++)
    {
        // 分别取每一个属性的名字
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        NSString *keyName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        [resArr addObject:keyName];
    }
    
    return [resArr copy];
}



+ (NSArray *)ss_allVar {
    
    NSMutableArray *resArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    //获取成员变量列表,成员变量个数
    unsigned int ivarCount = 0;
    Ivar *ivarList = class_copyIvarList([self class], &ivarCount);

    for(int i=0; i<ivarCount; i++)
    {
        // 分别取每一个属性的名字
        Ivar tempVar = ivarList[i];
        const char *ivarName = ivar_getName(tempVar);
        NSString *keyName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        [resArr addObject:keyName];
    }
    
    return [resArr copy];
}




+ (NSArray *)ss_allMethod {
    
    NSMutableArray *resArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    //获取成员变量列表,成员变量个数
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList([self class], &methodCount);
    
    for(int i=0; i<methodCount; i++)
    {
        // 分别取每一个属性的名字
        Method tempMethod = methodList[i];
        SEL methodName = method_getName(tempMethod);
        NSString *keyName = NSStringFromSelector(methodName);
        [resArr addObject:keyName];
    }
    
    return [resArr copy];
}





#pragma mark -

//转换为json
- (NSString *)ss_jsonString {
    
    NSString *jsonStr = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
        if (data != nil) {
            jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    return jsonStr;
}





#pragma mark - GCDTime


/**
 Returns a dispatch_time delay from now.
 */
+ (dispatch_time_t)ss_dispatchTimeDelay:(NSTimeInterval)second {
    
    return dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}

/**
 Returns a dispatch_wall_time delay from now.
 */
+ (dispatch_time_t)ss_dispatchWalltimeDelay:(NSTimeInterval)second {
    
    return dispatch_walltime(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}



#pragma mark - GCD

/**
 Whether in main queue/thread.
 */
+(BOOL)is_dispatchMainQueue {
    
    return pthread_main_np() != 0;
}


//主线程同步执行block
- (void)ss_syncDispatchOnMainThread:(void(^)(void))block {

    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

//主线程异步执行block
- (void)ss_asyncDispatchOnMainThread:(void(^)(void))block {
    
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
        
    }
}


//后台异步执行block
- (void)ss_asyncDispatchOnGlobalQueue:(void(^)(void))block {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}


//几秒后执行block
- (void)ss_asyncDispatchBlock:(void(^)(void))block
                      OnQueue:(dispatch_queue_t)queue
                   afterDelay:(NSTimeInterval)delay {
    
    dispatch_after([self.class ss_dispatchTimeDelay:delay], queue, block);
}





#pragma mark - 主线程执行可取消的block

- (id)ss_dispatchOnMainThreadWithBlock:(void (^)(void))block
                            afterDelay:(NSTimeInterval)delay {
    
    
    if (!block) return nil;
    
    __block BOOL cancelled = NO;
    
    void (^wrappingBlock)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block();
    };
    
    wrappingBlock = [wrappingBlock copy];
    
    dispatch_after([self.class ss_dispatchTimeDelay:delay], dispatch_get_main_queue(), ^{
        wrappingBlock(NO);
    });
    
    return wrappingBlock;
}

- (id)ss_dispatchOnMainThreadWithBlock:(void (^)(id arg))block
                            withObject:(id)anObject
                            afterDelay:(NSTimeInterval)delay {
    
    if (!block) return nil;
    
    __block BOOL cancelled = NO;
    
    void (^wrappingBlock)(BOOL, id) = ^(BOOL cancel, id arg) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block(arg);
    };
    
    wrappingBlock = [wrappingBlock copy];
    
    dispatch_after([self.class ss_dispatchTimeDelay:delay], dispatch_get_main_queue(), ^{
        wrappingBlock(NO, anObject);
    });
    
    return wrappingBlock;
}



- (void)ss_cancelWrappingBlock:(id)wrappingBlock {
    
    if (!wrappingBlock) return;
    void (^aWrappingBlock)(BOOL) = (void(^)(BOOL))wrappingBlock;
    aWrappingBlock(YES);
}


@end
