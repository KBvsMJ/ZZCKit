//
//  NSDictionary+SSToolkitAdditions.m
//  
//
//  Created by fdd_zzc on 15/4/28.
//
//

#import "NSDictionary+SSToolkitAdditions.h"



#pragma mark - NSDictionary


@implementation NSDictionary (SSToolkitAdditions)


#pragma mark -



+ (NSDictionary *)ss_dictionaryWithJsonString:(NSString*)json {
    
    NSData* infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* info = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:nil];
    return info;
}


#pragma mark -


- (NSArray *)ss_allKeysSorted {
    
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)ss_allValuesSortedByKeys {
    
    NSArray *sortedKeys = [self ss_allKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return arr;
}


#pragma mark -


- (BOOL)ss_containsObjectForKey:(id)key {
    
    if (!key) return NO;
    return self[key] != nil;
}

- (NSDictionary *)ss_objectsForKeys:(NSArray *)keys {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) dic[key] = value;
    }
    return dic;
}



@end




#pragma mark - NSMutableDictionary



@implementation NSMutableDictionary (SSToolkitAdditions)


- (void)ss_setValue:(id)value forKey:(NSString *)key {
    
    if (value && key) {
        [self setValue:value forKey:key];
    }
}


- (void)ss_setObject:(id)value forKey:(NSString *)key {
    
    if (value && key) {
        [self setObject:value forKey:key];
    }
}


@end

