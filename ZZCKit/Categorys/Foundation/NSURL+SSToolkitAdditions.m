//
//  NSURL+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "NSURL+SSToolkitAdditions.h"

@implementation NSURL (SSToolkitAdditions)

- (NSDictionary *)ss_queryParameters {
    
    NSMutableDictionary * parametersDictionary = [NSMutableDictionary dictionary];
    NSArray * queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString * queryComponent in queryComponents) {
        
        NSString * key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString * value = [queryComponent substringFromIndex:(key.length + 1)];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}


- (id)ss_valueForParameter:(NSString *)parameterKey
{
    return [[self ss_queryParameters] objectForKey:parameterKey];
}





//添加query参数,传入参数示例: "name=aaa&age=10"
- (NSString *)ss_addQueryParamStr:(NSString *)queryParamStr {
    
    
    NSString *queryStr = self.query;
    NSString *resultQueryStr = nil;
    
    NSString *resultUrlStr = nil;
    NSString *absoluteUrlStr = self.absoluteString;
    NSRange hashRange = [absoluteUrlStr rangeOfString:@"#"];
    
    
    //判断原始url是否包含query部分
    if (queryStr && queryStr.length > 0) {

        //包含query
        resultQueryStr = [NSString stringWithFormat:@"%@&%@", queryStr, queryParamStr];
        resultUrlStr = [absoluteUrlStr stringByReplacingOccurrencesOfString:queryStr withString:resultQueryStr];
        
    } else {
    
        //未包含query
        resultQueryStr = [NSString stringWithFormat:@"?%@", queryParamStr];

        if (hashRange.location != NSNotFound) {
            
            //发现hash
            //先截取hash部分，再拼接query
            NSString *hashStr = [absoluteUrlStr substringFromIndex:hashRange.location];
            NSString *subUrl = [NSString stringWithFormat:@"%@%@", resultQueryStr, hashStr];
            resultUrlStr = [absoluteUrlStr stringByReplacingOccurrencesOfString:hashStr withString:subUrl];
            
        } else {
            
            //未发现hash
            resultUrlStr = [NSString stringWithFormat:@"%@/?%@",absoluteUrlStr, queryParamStr];
        }
    }
    
    return resultUrlStr;
    
}


@end
