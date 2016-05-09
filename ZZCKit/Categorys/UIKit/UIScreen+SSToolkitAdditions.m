//
//  UIScreen+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "UIScreen+SSToolkitAdditions.h"

@implementation UIScreen (SSToolkitAdditions)

- (CGRect)ss_currentBounds {
    return [self ss_boundsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}


- (CGRect)ss_boundsForOrientation:(UIInterfaceOrientation)orientation {
    
    CGRect bounds = [self bounds];
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        CGFloat buffer = bounds.size.width;
        
        bounds.size.width = bounds.size.height;
        bounds.size.height = buffer;
    }
    return bounds;
}

@end
