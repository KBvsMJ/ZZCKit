//
//  NSUserDefaults+SSToolkitAdditions.m
//    
//
//  Created by zzc on 15/8/2.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "NSUserDefaults+SSToolkitAdditions.h"

@implementation NSUserDefaults (SSToolkitAdditions)


//保存Object
+ (id)ss_objectForKey:(NSString *)defaultName {
    
   return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)ss_saveObject:(id)value forKey:(NSString *)defaultName {
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



//保存Model
+ (id<NSCoding>)ss_modelForKey:(NSString *)defaultName {
    
    id<NSCoding> model = nil;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
    if (data) {
        model = (id<NSCoding>)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return model;
}


+ (void)ss_saveModel:(id<NSCoding>)value forKey:(NSString *)defaultName {
    
    if (value) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:defaultName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
