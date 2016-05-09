//
//  UILabel+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SSToolkitAdditions)

#pragma mark - 设置标题
-(void)ss_setText:(NSString *)text
             Font:(UIFont *)font
        TextColor:(UIColor *)textColor
  BackgroundColor:(UIColor *)backgroundColor;


#pragma mark - 计算frame
- (CGSize)ss_suggestedSizeForWidth:(CGFloat)width;
- (CGSize)ss_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width;
- (CGSize)ss_suggestSizeForString:(NSString *)string width:(CGFloat)width;

@end
