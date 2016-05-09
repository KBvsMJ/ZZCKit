//
//  CALayer+SSToolkitAdditions.h
//  TestApp
//
//  Created by zzc on 15/12/4.
//  Copyright © 2015年 zzc. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface CALayer (SSToolkitAdditions)



@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGPoint center;      ///< Shortcut for center.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic, getter=frameSize, setter=setFrameSize:) CGSize  size; ///< Shortcut for frame.size.

//旋转(Rotation)
@property (nonatomic) CGFloat transformRotation;     ///< key path "tranform.rotation"
@property (nonatomic) CGFloat transformRotationX;    ///< key path "tranform.rotation.x"
@property (nonatomic) CGFloat transformRotationY;    ///< key path "tranform.rotation.y"
@property (nonatomic) CGFloat transformRotationZ;    ///< key path "tranform.rotation.z"


//缩放(Scale)
@property (nonatomic) CGFloat transformScale;        ///< key path "tranform.scale"
@property (nonatomic) CGFloat transformScaleX;       ///< key path "tranform.scale.x"
@property (nonatomic) CGFloat transformScaleY;       ///< key path "tranform.scale.y"
@property (nonatomic) CGFloat transformScaleZ;       ///< key path "tranform.scale.z"


//平移(Translation)
@property (nonatomic) CGFloat transformTranslationX; ///< key path "tranform.translation.x"
@property (nonatomic) CGFloat transformTranslationY; ///< key path "tranform.translation.y"
@property (nonatomic) CGFloat transformTranslationZ; ///< key path "tranform.translation.z"

/**
 Shortcut for transform.m34, -1/1000 is a good value.
 It should be set before other transform shortcut.
 */
@property (nonatomic, assign) CGFloat transformDepth;

/**
 Wrapper for `contentsGravity` property.
 */
@property (nonatomic, assign) UIViewContentMode contentMode;






/**
 Take snapshot without transform, image's size equals to bounds.
 */
- (UIImage *)ss_snapshotImage;

/**
 Take snapshot without transform, PDF's page size equals to bounds.
 */
- (NSData *)ss_snapshotPDF;

/**
 Shortcut to set the layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)ss_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 Remove all sublayers.
 */
- (void)ss_removeAllSublayers;



/**
 Add a fade animation to layer's contents when the contents is changed.
 
 @param duration Animation duration
 @param curve    Animation curve.
 */
- (void)ss_addFadeAnimationWithDuration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve;

/**
 Cancel fade animation which is added with "-addFadeAnimationWithDuration:curve:".
 */
- (void)ss_removePreviousFadeAnimation;

@end
