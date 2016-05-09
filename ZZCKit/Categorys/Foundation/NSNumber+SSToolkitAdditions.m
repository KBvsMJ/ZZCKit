//
//  NSNumber+SSToolkitAdditions.m
//  
//
//  Created by fdd_zzc on 15/4/28.
//
//

#import "NSNumber+SSToolkitAdditions.h"

@implementation NSNumber (SSToolkitAdditions)

- (NSDate *)ss_dateValue {
    NSTimeInterval timestamp = [self doubleValue];
    if (!timestamp) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

@end
