//
//  UITextField+SSToolkitAdditions.h
//  DDFinanceLibrary
//
//  Created by fdd_zzc on 15/11/3.
//  Copyright © 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SSToolkitAdditions)

- (void)ss_setFont:(UIFont *)font
             Color:(UIColor *)color
       Placeholder:(NSString *)placeholder;


- (void)ss_setKeyboardType:(UIKeyboardType)keyboardType
                    Secure:(BOOL)secure
                  Delegate:(id)delegate;



- (void)ss_selectAllText;

- (void)ss_setSelectedRange:(NSRange)range;

@end
