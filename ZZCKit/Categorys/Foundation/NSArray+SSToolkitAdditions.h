//
//  NSArray+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SSToolkitAdditions)


- (id)ss_objectAtIndex:(NSUInteger)index;       //获取某个对象
- (id)ss_randomObject;                          //随机一个对象

- (NSArray *)ss_head:(NSUInteger)count;         //返回数组前count个元素
- (NSArray *)ss_tail:(NSUInteger)count;         //返回数组后count个元素

@end



@interface NSMutableArray (SSToolkitAdditions)


- (void)ss_shuffle;                             //乱序洗牌
- (void)ss_reverse;                             //反转数组

- (void)ss_pushHead:(NSObject *)obj;            //往数组头部插入一个元素
- (void)ss_pushHeadN:(NSArray *)arr;            //往数组头部插入一个数组

- (void)ss_pushTail:(NSObject *)obj;            //插入一个元素到数组尾部
- (void)ss_pushTailN:(NSArray *)arr;            //插入一个数组到数组尾部


- (void)ss_popHead;                             //删除数组的第一个元素
- (void)ss_popHeadN:(NSUInteger)n;              //删除数组的前N个元素

- (void)ss_popTail;                             //从数组尾部删除一个元素
- (void)ss_popTailN:(NSUInteger)n;              //从数组尾部删除N个元素


- (void)ss_keepHead:(NSUInteger)n;              //保留数组头部的前N个元素
- (void)ss_keepTail:(NSUInteger)n;              //保留数组尾部的前N个元素

@end