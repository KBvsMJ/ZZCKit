//
//  NSDateFormatter+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (SSToolkitAdditions)

+ (id)ss_dateFormatter;
+ (id)ss_dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)ss_defaultDateFormatter;  /*yyyy-MM-dd HH:mm:ss*/

@end
