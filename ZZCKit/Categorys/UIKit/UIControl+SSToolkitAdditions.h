//
//  UIControl+SSToolkitAdditions.h
//  
//
//  Created by fdd_zzc on 15/4/28.
//
//

#import <UIKit/UIKit.h>

@interface UIControl (SSToolkitAdditions)

- (void)ss_removeAllTargets;

- (void)ss_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
