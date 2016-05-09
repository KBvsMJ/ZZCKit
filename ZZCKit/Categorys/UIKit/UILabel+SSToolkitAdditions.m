//
//  UILabel+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "UILabel+SSToolkitAdditions.h"

@implementation UILabel (SSToolkitAdditions)


-(void)ss_setText:(NSString *)text
             Font:(UIFont *)font
        TextColor:(UIColor *)textColor
  BackgroundColor:(UIColor *)backgroundColor {

    self.text = text;
    
    if (font) {
        self.font = font;
    } else {
        self.font = [UIFont systemFontOfSize:15];
    }

    //文本默认黑色
    if (textColor) {
        self.textColor = textColor;
    } else {
        self.textColor = [UIColor blackColor];
    }
    
    //背景色默认为clearColor
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}



//计算size
- (CGSize)ss_suggestedSizeForWidth:(CGFloat)width {
    
    CGSize size = CGSizeZero;
    if (self.attributedText) {
        size = [self ss_suggestSizeForAttributedString:self.attributedText width:width];
    } else {
        size = [self ss_suggestSizeForString:self.text width:width];
    }
    
    return size;
    
}


//根据属性文本计算所需size
- (CGSize)ss_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width {
    
    CGSize size = CGSizeZero;
    if (string) {
        
        //NSStringDrawingUsesLineFragmentOrigin:这个参数是计算多行文本时用的参数
        //NSStringDrawingUsesFontLeading:这个参数是要求根据字形来计算行高
        size = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    context:nil].size;
    }
    
    return size;
    
}


//根据文本计算所需size
- (CGSize)ss_suggestSizeForString:(NSString *)string width:(CGFloat)width {
    CGSize size = CGSizeZero;
    if (string) {
        
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string
                                                                      attributes:@{NSFontAttributeName: self.font}];
        size = [self ss_suggestSizeForAttributedString:attrStr width:width];
    }
    
    return size;
}


@end
