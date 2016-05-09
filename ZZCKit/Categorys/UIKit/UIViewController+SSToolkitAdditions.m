//
//  UIViewController+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/6/12.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "UIViewController+SSToolkitAdditions.h"

@implementation UIViewController (SSToolkitAdditions)

- (void)ss_addChildViewController:(UIViewController *)controller atFrame:(CGRect)frame {
    [self ss_addChildViewController:controller inView:self.view atFrame:frame];
}

- (void)ss_addChildViewController:(UIViewController *)controller inView:(UIView *)view atFrame:(CGRect)frame {
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    
    controller.view.frame = frame;
    [view addSubview:controller.view];
    
    [controller didMoveToParentViewController:self];
}

- (void)ss_removeChildViewController:(UIViewController *)controller {
    [controller willMoveToParentViewController:nil];
    [controller removeFromParentViewController];
    [controller.view removeFromSuperview];
}

@end
