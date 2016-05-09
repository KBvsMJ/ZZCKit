//
//  NSArray+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "NSArray+SSToolkitAdditions.h"


#pragma mark - NSArray

@implementation NSArray (SSToolkitAdditions)





#pragma mark -

//指定某个对象
- (id)ss_objectAtIndex:(NSUInteger)index {
    
    return index < self.count ? self[index] : nil;
}


//随机一个对象
- (id)ss_randomObject {
    
    if (self.count) {
        return [self objectAtIndex:arc4random_uniform((uint32_t)self.count)];
    }
    return nil;
}


#pragma mark -


//返回数组前count个元素
- (NSArray *)ss_head:(NSUInteger)count {
    
    NSRange range;
    if (self.count < count) {
        range = NSMakeRange(0, self.count);
    } else {
        range = NSMakeRange(0, count);
    }
    return [self subarrayWithRange:range];
    
}

//返回数组后count个元素
- (NSArray *)ss_tail:(NSUInteger)count {
    
    NSRange range;
    if (self.count < count) {
        range = NSMakeRange(0, self.count);
    } else {
        range = NSMakeRange(self.count - count, count);
    }
    return [self subarrayWithRange:range];
}



@end




#pragma mark - NSMutableArray

@implementation NSMutableArray (SSToolkitAdditions)


#pragma mark - 排序

//乱序洗牌
- (void)ss_shuffle {
    
    for (NSInteger i = [self count] - 1; i > 0; i--) {
        [self exchangeObjectAtIndex:arc4random_uniform((u_int32_t)i + 1)
                  withObjectAtIndex:i];
    }
}



//反转数组
- (void)ss_reverse {
    
    NSUInteger mid = self.count/2;
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(self.count - (i + 1))];
    }
}



#pragma mark - 插入删除操作


//往数组头部插入一个元素
- (void)ss_pushHead:(NSObject *)obj {
    
    if (obj){
        [self insertObject:obj atIndex:0];
    }
}

//往数组头部插入一个数组
- (void)ss_pushHeadN:(NSArray *)arr {
    
    if (arr.count){
        for ( NSInteger i = arr.count -1; i >= 0; --i ){
            [self insertObject:arr[i] atIndex:0];
        }
    }
}



//插入一个元素到数组尾部
- (void)ss_pushTail:(NSObject *)obj {
    
    if (obj){
        [self addObject:obj];
    }
}

//插入一个数组到数组尾部
- (void)ss_pushTailN:(NSArray *)arr {
    
    if (arr.count){
        [self addObjectsFromArray:arr];
    }
}






//删除数组的第一个元素
- (void)ss_popHead {
    
    if (self.count){
        [self removeObjectAtIndex:0];
    }
}

//删除数组的前N个元素
- (void)ss_popHeadN:(NSUInteger)n {
    
    if ( self.count ){
        if ( n >= self.count){
            [self removeAllObjects];
        } else {
            NSRange range;
            range.location = 0;
            range.length = n;
            [self removeObjectsInRange:range];
        }
    }
}




//从数组尾部删除一个元素
- (void)ss_popTail {
    
    if (self.count){
        [self removeObjectAtIndex:self.count - 1];
    }
}

//从数组尾部删除N个元素
- (void)ss_popTailN:(NSUInteger)n {
    
    if (self.count){
        if ( n >= self.count ){
            [self removeAllObjects];
        } else {
            
            NSRange range;
            range.location = self.count - n;
            range.length = n;
            [self removeObjectsInRange:range];
        }
    }
}


//保留数组头部的前N个元素
- (void)ss_keepHead:(NSUInteger)n {
    
    if (self.count > n){
        NSRange range;
        range.location = n;
        range.length = self.count - n;
        [self removeObjectsInRange:range];
    }
}

//保留数组尾部的前N个元素
- (void)ss_keepTail:(NSUInteger)n {
    
    if ( self.count > n ){
        NSRange range;
        range.location = 0;
        range.length = self.count - n;
        [self removeObjectsInRange:range];
    }
}



@end
