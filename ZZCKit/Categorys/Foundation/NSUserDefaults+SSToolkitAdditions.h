//
//  NSUserDefaults+SSToolkitAdditions.h
//    
//
//  Created by zzc on 15/8/2.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (SSToolkitAdditions)


//保存Object
+ (id)ss_objectForKey:(NSString *)defaultName;
+ (void)ss_saveObject:(id)value forKey:(NSString *)defaultName;

//保存Model
+ (id<NSCoding>)ss_modelForKey:(NSString *)defaultName;
+ (void)ss_saveModel:(id<NSCoding>)value forKey:(NSString *)defaultName;

@end
