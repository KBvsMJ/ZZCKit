//
//  UIScreen+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (SSToolkitAdditions)

- (CGRect)ss_currentBounds;

- (CGRect)ss_boundsForOrientation:(UIInterfaceOrientation)orientation;

@end
