//
//  UIImage+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SSToolkitAdditions)

//读取图片
+ (UIImage *)ss_imageNamedNoCache:(NSString *)imageName;
+ (UIImage *)ss_imageNamed:(NSString *)imageName SubBundleName:(NSString *)subBundleName;
+ (UIImage *)ss_imageWithColor:(UIColor *)color size:(CGSize)size;  //纯色图片


//图片格式
+ (NSString *)ss_contentTypeForImageData:(NSData *)data;





- (UIImage *)ss_imageCroppedToRect:(CGRect)rect;
- (UIImage *)ss_squareImage;

/**
 *  抓取屏幕。
 *  @param  scale:屏幕放大倍数，1为原尺寸。
 *  return  屏幕后的Image。
 */
+ (UIImage *)ss_grabScreenWithScale:(CGFloat)scale;

/**
 *  抓取UIView及其子类。
 *  @param  view: UIView及其子类。
 *  @param  scale:屏幕放大倍数，1为原尺寸。
 *  return  抓取图片后的Image。
 */
+ (UIImage *)ss_grabImageWithView:(UIView *)view scale:(CGFloat)scale;

/**
 *  合并两个Image。
 *  @param  image1、image2: 两张图片。
 *  @param  frame1、frame2:两张图片放置的位置。
 *  @param  size:返回图片的尺寸。
 *  return  合并后的两个图片的Image。
 */
+ (UIImage *)ss_mergeWithImage1:(UIImage*)image1
                         Image2:(UIImage *)image2
                         Frame1:(CGRect)frame1
                         Frame2:(CGRect)frame2
                           Size:(CGSize)size;


/**
 *  把一个Image盖在另一个Image上面。
 *  @param  image: 底图。
 *  @param  mask:盖在上面的图。
 *  return  Image。
 */
+ (UIImage *)ss_maskImage:(UIImage *)image withMask:(UIImage *)mask;

/**
 *  把一个Image尺寸缩放到另一个尺寸。
 *  @param  view: UIView及其子类。
 *  @param  scale:屏幕放大倍数，1为原尺寸。
 *  return  尺寸更改后的Image。
 */
+ (UIImage *)ss_scaleImage:(UIImage *)image toSize:(CGSize)size;

/**
 *  改变一个Image的色彩。
 *  @param  image: 被改变的Image。
 *  @param  color: 要改变的目标色彩。
 *  return  色彩更改后的Image。
 */
+(UIImage *)ss_colorizeImage:(UIImage *)image withColor:(UIColor *)color;

//按frame裁减图片
+ (UIImage *)ss_captureView:(UIView *)view frame:(CGRect)frame;











@end
