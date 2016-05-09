//
//  UIView+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SSToolkitAdditions)

#pragma mark - 属性

@property(nonatomic) CGSize  size;      
@property(nonatomic) CGPoint origin;
@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;


//点的颜色
- (UIColor *)ss_colorAtPixel:(CGPoint)point;

//设置圆角
- (void)ss_setCornerRadius:(CGFloat)cornerRadius;


#pragma mark - 截图

- (UIImage *)ss_snapshotImage;

- (NSData *)ss_snapshotPDF;


#pragma mark - 调试


- (NSArray *)ss_superviews;

- (id)ss_firstSuperviewOfClass:(Class)superviewClass;


- (void)ss_printSubviews;
- (void)ss_printSubviewsWithIndentString:(NSString *)indentString;

- (NSArray *)ss_subviewsMatchingClass:(Class)aClass;
- (NSArray *)ss_subviewsMatchingOrInheritingClass:(Class)aClass;

- (void)ss_populateSubviewsMatchingClass:(Class)aClass
                                 inArray:(NSMutableArray *)array
                              exactMatch:(BOOL)exactMatch;



#pragma mark - 显示，隐藏

- (void)ss_show;            //显示
- (void)ss_hide;            //隐藏
- (void)ss_fadeIn;          //淡入
- (void)ss_fadeOut;         //淡出
- (void)ss_fadeOutAndRemoveFromSuperview; //淡出并从父view中移除



#pragma mark - 开始，结束，暂停，恢复

- (void)ss_startRotationAnimatingWithDuration:(CGFloat)duration;                   //开始旋转动画
- (void)ss_stopRotationAnimating;                                                  //停止旋转动画
- (void)ss_pauseAnimating;                                                         //暂停动画
- (void)ss_resumeAnimating;                                                        //恢复动画




#pragma mark - 特效动画
+ (void)ss_animationReveal:(UIView *)view direction:(NSString *)direction;         //揭开
+ (void)ss_animationFade:(UIView *)view;                                           //渐隐渐消
+ (void)ss_animationFlip:(UIView *)view direction:(NSString *)direction;           //翻转
+ (void)ss_animationRotateAndScaleEffects:(UIView *)view;                          //各种旋转缩放效果
+ (void)ss_animationRotateAndScaleDownUp:(UIView *)view;                           //旋转同时缩小放大效果
+ (void)ss_animationPush:(UIView *)view direction:(NSString *)direction;           //push
+ (void)ss_animationCurl:(UIView *)view direction:(NSString *)direction;           //Curl
+ (void)ss_animationUnCurl:(UIView *)view direction:(NSString *)direction;         //UnCurl
+ (void)ss_animationMove:(UIView *)view direction:(NSString *)direction;           //Move
+ (void)ss_animationCube:(UIView *)view direction:(NSString *)direction;           //立方体
+ (void)ss_animationRippleEffect:(UIView *)view;                                   //水波纹
+ (void)ss_animationCameraEffect:(UIView *)view type:(NSString *)type;             //相机开合
+ (void)ss_animationSuckEffect:(UIView *)view;                                     //吸收
+ (void)ss_animationBounceOut:(UIView *)view;
+ (void)ss_animationBounceIn:(UIView *)view;
+ (void)ss_animationBounce:(UIView *)view;


@end
