//
//  UIButton+SSToolkitAdditions.m
//  DDFinanceLibrary
//
//  Created by fdd_zzc on 15/11/3.
//  Copyright © 2015年 fdd. All rights reserved.
//

#import "UIButton+SSToolkitAdditions.h"

@implementation UIButton (SSToolkitAdditions)


- (void)ss_setTarget:(id)target Selector:(SEL)selector {
    
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}


- (void)ss_setTitle:(NSString *)title
           TitleFont:(UIFont  *)font
    NormalTitleColor:(UIColor *)normalTitleColor
 HighLightTitleColor:(UIColor *)highLightTitleColor {
    
    
    if (title != nil) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    
    if (font != nil) {
        [self.titleLabel setFont:font];
    }
    
    if (normalTitleColor != nil) {
        [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    }
    
    if (highLightTitleColor != nil) {
        [self setTitleColor:highLightTitleColor forState:UIControlStateHighlighted];
    }

}


- (void)ss_setTitle:(NSString *)title
          TitleFont:(UIFont  *)font
   NormalTitleColor:(UIColor *)normalTitleColor
 SelectedTitleColor:(UIColor *)selectedTitleColor {
    
    
    if (title != nil) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    
    if (font != nil) {
        [self.titleLabel setFont:font];
    }
    
    if (normalTitleColor != nil) {
        [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    }
    
    if (selectedTitleColor != nil) {
        [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
    
}




#pragma mark - 设置图标

- (void)ss_setNormalImage:(UIImage *)normalImage
           HighlightImage:(UIImage *)clickIamge {
    
    if (normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    
    if (clickIamge != nil) {
        [self setImage:clickIamge forState:UIControlStateHighlighted];
    }
}



- (void)ss_setNormalImage:(UIImage *)normalImage
            SelectedImage:(UIImage *)selectedImage {
    
    if (normalImage != nil) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
        
    
    if (selectedImage != nil) {
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
}


#pragma mark - 设置背景图

- (void)ss_setNormalBGImage:(UIImage *)normalBGImage
           HighlightBGImage:(UIImage *)clickBGIamge {
    
    if (normalBGImage != nil) {
        [self setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    }
    
    if (clickBGIamge != nil) {
        [self setBackgroundImage:clickBGIamge forState:UIControlStateHighlighted];
    }
}




- (void)ss_setNormalBGImage:(UIImage *)normalBGImage
           SelectedBGImage:(UIImage *)selectedBGIamge {
    
    if (normalBGImage != nil) {
        [self setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    }

    if (selectedBGIamge != nil) {
        [self setBackgroundImage:selectedBGIamge forState:UIControlStateSelected];
    }
}





@end
