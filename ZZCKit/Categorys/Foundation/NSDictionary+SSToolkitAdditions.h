//
//  NSDictionary+SSToolkitAdditions.h
//  
//
//  Created by fdd_zzc on 15/4/28.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SSToolkitAdditions)



+ (NSDictionary *)ss_dictionaryWithJsonString:(NSString*)json;


- (NSArray *)ss_allKeysSorted;

- (NSArray *)ss_allValuesSortedByKeys;

- (BOOL)ss_containsObjectForKey:(id)key;

- (NSDictionary *)ss_objectsForKeys:(NSArray *)keys;

@end



@interface NSMutableDictionary (SSToolkitAdditions)

- (void)ss_setValue:(id)value forKey:(NSString *)key;
- (void)ss_setObject:(id)value forKey:(NSString *)key;

@end
