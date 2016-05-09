//
//  NSDateFormatter+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "NSDateFormatter+SSToolkitAdditions.h"

@implementation NSDateFormatter (SSToolkitAdditions)

+ (id)ss_dateFormatter {
    
    return [[self alloc] init];
}

+ (id)ss_dateFormatterWithFormat:(NSString *)dateFormat {
    
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)ss_defaultDateFormatter {
    
    return [self ss_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
