//
//  UIView+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "UIView+SSToolkitAdditions.h"

#define kTransitionTime 0.55
#define kFlipTime       0.85
#define DEGREES_TO_RADIANS(d)   (d * M_PI / 180)

@implementation UIView (SSToolkitAdditions)

// Retrieve and set the origin
- (CGPoint) origin {
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint {
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size {
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize {
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}



- (UIColor *)ss_colorAtPixel:(CGPoint)point {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}




- (void)ss_setCornerRadius:(CGFloat)cornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}




#pragma mark - 截图

- (UIImage *)ss_snapshotImage {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}


- (NSData *)ss_snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) {
        return nil;
    }
    
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}


#pragma mark - 调试


//所有父视图
- (NSArray *)ss_superviews {
    
    NSMutableArray *superviews = [[NSMutableArray alloc] init];
    
    UIView *view = self;
    UIView *superview = nil;
    while (view) {
        superview = [view superview];
        if (!superview) {
            break;
        }
        
        [superviews addObject:superview];
        view = superview;
    }
    
    return superviews;
}


//所有属于superviewClass的父试图
- (id)ss_firstSuperviewOfClass:(Class)superviewClass {
    for (UIView *view = [self superview]; view != nil; view = [view superview]) {
        if ([view isKindOfClass:superviewClass]) {
            return view;
        }
    }
    return nil;
}


//打印subview
- (void)ss_printSubviews {
    [self ss_printSubviewsWithIndentString:nil];
}


- (void)ss_printSubviewsWithIndentString:(NSString *)indentString {
    if (indentString == nil) indentString = @"";
    
    NSString *viewDescription = NSStringFromClass([self class]);
    
    printf("%s+-%s\n", [indentString UTF8String],
           [viewDescription UTF8String]);
    
    if (self.subviews) {
        NSArray *siblings = self.superview.subviews;
        if ([siblings count] > 1 &&
            ([siblings indexOfObject:self] < [siblings count]-1)) {
            indentString = [indentString stringByAppendingString:@"| "];
        } else {
            indentString = [indentString stringByAppendingString:@"  "];
        }
        
        for (UIView *subview in self.subviews) {
            [subview ss_printSubviewsWithIndentString:indentString];
        }
    }
}



- (void)ss_populateSubviewsMatchingClass:(Class)aClass
                                 inArray:(NSMutableArray *)array
                              exactMatch:(BOOL)exactMatch {
    
    /**
    isKindOfClass和isMemberOfClass之间的区别是：
    我们可以使用isKindOfClass来确定一个对象是否是一个类的实例，或者是该类祖先类的实例。
    isMemberOfClass只能用来判断前者，不能用来判断后者。
     */

    //是否精确匹配
    if (exactMatch) {
        if ([self isMemberOfClass:aClass]) {
            [array addObject:self];
        }
    } else {
        if ([self isKindOfClass:aClass]) {
            [array addObject:self];
        }
    }
    for (UIView *subview in self.subviews) {
        
        [subview ss_populateSubviewsMatchingClass:aClass
                                          inArray:array
                                       exactMatch:exactMatch];
    }
}


//精确匹配某类的subviews
- (NSArray *)ss_subviewsMatchingClass:(Class)aClass {
    
    NSMutableArray *array = [NSMutableArray array];
    [self ss_populateSubviewsMatchingClass:aClass
                                   inArray:array
                                exactMatch:YES];
    return array;
}



//匹配或者继承于某类的所有subviews
- (NSArray *)ss_subviewsMatchingOrInheritingClass:(Class)aClass {
    
    NSMutableArray *array = [NSMutableArray array];
    [self ss_populateSubviewsMatchingClass:aClass
                                   inArray:array
                                exactMatch:NO];
    return array;
}





#pragma mark - 动画

//显示
- (void)ss_show {
    self.alpha = 1.0f;
}


//隐藏
- (void)ss_hide {
    self.alpha = 0.0f;
}


//淡入
- (void)ss_fadeIn {
    UIView *view = self;
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
        view.alpha = 1.0f;
    } completion:nil];
}


//淡出
- (void)ss_fadeOut {
    UIView *view = self;
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction animations:^{
        view.alpha = 0.0f;
    } completion:nil];
}


//淡出并移除
- (void)ss_fadeOutAndRemoveFromSuperview {
    UIView *view = self;
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}




//旋转动画
- (void)ss_startRotationAnimatingWithDuration:(CGFloat)duration {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = duration;
    
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALL;
    
    [self.layer setShouldRasterize:YES];//抗锯齿
    [self.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
    [self.layer addAnimation:animation forKey:nil];
    
    //如果暂停了，则恢复动画运行
    if (self.layer.speed == 0.0)
    {
        [self ss_resumeAnimating];
    }
}

//停止动画
- (void)ss_stopRotationAnimating {
    
    [self.layer removeAllAnimations];
}

//暂停动画
- (void)ss_pauseAnimating {
    
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

//恢复动画
- (void)ss_resumeAnimating {
    
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}




#pragma mark - 特效动画

+ (void)ss_animationReveal:(UIView *)view direction:(NSString *)direction {
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:direction];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationFade:(UIView *)view {
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationRotateAndScaleDownUp:(UIView *)view {
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    rotationAnimation.duration = 0.750f;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.duration = 0.75f;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.75f;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = 1;//HUGE_VALF;
    [animationGroup setAnimations:[NSArray arrayWithObjects:rotationAnimation, scaleAnimation, nil]];
    
    [view.layer addAnimation:animationGroup forKey:@"animationGroup"];
}


+ (void)ss_animationFlip:(UIView *)view direction:(NSString *)direction {
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:kFlipTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"oglFlip"];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationPush:(UIView *)view direction:(NSString *)direction {
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationCurl:(UIView *)view direction:(NSString *)direction {
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"pageCurl"];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationUnCurl:(UIView *)view direction:(NSString *)direction {
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"pageUnCurl"];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+(void)ss_animationRotateAndScaleEffects:(UIView *)view {
    
    [UIView animateWithDuration:0.75
                     animations:^ {
                         view.transform = CGAffineTransformMakeScale(0.001, 0.001);
                         
                         CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
                         animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.70, 0.40, 0.80) ];//旋转形成一道闪电。
                         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.0, 1.0, 0.0) ];//y轴居中对折番。
                         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 1.0, 0.0, 0.0) ];//沿X轴对折翻转。
                         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.50, -0.50, 0.50) ];
                         //animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0.1, 0.2, 0.2) ];
                         
                         animation.duration = 0.45;
                         animation.repeatCount = 1;
                         [view.layer addAnimation:animation forKey:nil];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.75 animations:^{
                             view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         }];
                         
                     }];
}


+ (void)ss_animationMove:(UIView *)view direction:(NSString *)direction {
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationCube:(UIView *)view direction:(NSString *)direction {
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"cube"];
    [animation setSubtype:direction];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationRippleEffect:(UIView *)view {
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"rippleEffect"];
    [animation setSubtype:kCATransitionFromRight];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationCameraEffect:(UIView *)view type:(NSString *)type {
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:type];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationSuckEffect:(UIView *)view {
    CATransition *animation = [CATransition animation];
    [animation setDuration:kTransitionTime];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [animation setType:@"suckEffect"];
    [animation setSubtype:kCATransitionFromRight];
    
    [view.layer addAnimation:animation forKey:nil];
}

+ (void)ss_animationBounceIn:(UIView *)view {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.0001];
    [view setAlpha:0.8];
    [view setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)];
    [UIView commitAnimations];
}

+ (void)ss_animationBounceOut:(UIView *)view {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.73];
    //    [UIView setAnimationDelay:0.2];
    [view setAlpha:1.0];
    [view setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
    [UIView commitAnimations];
}

+ (void)ss_animationBounce:(UIView *)view {
    CGRect rect = view.bounds;
    CGPoint center = view.center;
    [view setCenter:CGPointMake(160, 240)];
    [view setFrame:CGRectZero];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [view setAlpha:1.0];
    [view setBounds:rect];
    [view setCenter:center];
    [UIView commitAnimations];
}





@end
