//
//  UIButton+SSToolkitAdditions.h
//  DDFinanceLibrary
//
//  Created by fdd_zzc on 15/11/3.
//  Copyright © 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SSToolkitAdditions)


- (void)ss_setTarget:(id)target Selector:(SEL)selector;


#pragma mark - 设置标题

- (void)ss_setTitle:(NSString *)title
          TitleFont:(UIFont  *)font
   NormalTitleColor:(UIColor *)normalTitleColor
HighLightTitleColor:(UIColor *)highLightTitleColor;

- (void)ss_setTitle:(NSString *)title
          TitleFont:(UIFont  *)font
   NormalTitleColor:(UIColor *)normalTitleColor
 SelectedTitleColor:(UIColor *)selectedTitleColor;


#pragma mark - 设置图标

- (void)ss_setNormalImage:(UIImage *)normalImage
           HighlightImage:(UIImage *)clickIamge;

- (void)ss_setNormalImage:(UIImage *)normalImage
            SelectedImage:(UIImage *)selectedImage;


#pragma mark - 设置背景图

- (void)ss_setNormalBGImage:(UIImage *)normalBGImage
           HighlightBGImage:(UIImage *)clickBGIamge;

- (void)ss_setNormalBGImage:(UIImage *)normalBGImage
            SelectedBGImage:(UIImage *)selectedBGIamge;

@end
