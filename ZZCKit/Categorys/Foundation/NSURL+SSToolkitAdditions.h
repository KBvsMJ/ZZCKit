//
//  NSURL+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (SSToolkitAdditions)

- (NSDictionary *)ss_queryParameters;
- (id)ss_valueForParameter:(NSString *)parameterKey;

- (NSString *)ss_addQueryParamStr:(NSString *)queryParamStr;

@end
