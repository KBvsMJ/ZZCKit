//
//  UIColor+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SSToolkitAdditions)



@property (nonatomic, assign, readonly) CGFloat red;
@property (nonatomic, assign, readonly) CGFloat green;
@property (nonatomic, assign, readonly) CGFloat blue;
@property (nonatomic, assign, readonly) CGFloat alpha;



+ (UIColor *)ss_colorWithHex:(NSString *)hex;


- (NSString *)ss_hexValue;


- (NSString *)ss_hexValueWithAlpha:(BOOL)includeAlpha;




@end
