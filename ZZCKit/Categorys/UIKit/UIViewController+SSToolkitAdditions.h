//
//  UIViewController+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/6/12.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SSToolkitAdditions)



#pragma mark - 添加childVC


/// Add a childVC to another controller, deals with the normal
/// View Controller containment methods.

- (void)ss_addChildViewController:(UIViewController *)controller atFrame:(CGRect)frame;

/// Allows you to add a childViewController inside a view in your hierarchy and will deal
/// the normal view controller containment methods.

- (void)ss_addChildViewController:(UIViewController *)controller inView:(UIView *)view atFrame:(CGRect)frame;


/// Remove a child View Controller and removes from superview
- (void)ss_removeChildViewController:(UIViewController *)controller;

@end
