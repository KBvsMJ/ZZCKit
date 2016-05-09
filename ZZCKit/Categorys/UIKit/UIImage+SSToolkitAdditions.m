//
//  UIImage+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "UIImage+SSToolkitAdditions.h"

@implementation UIImage (SSToolkitAdditions)


#pragma mark - 读取图片

+ (UIImage *)ss_imageNamedNoCache:(NSString *)imageName {
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *filePath = nil;
    
    //判断imageName是否有.png后缀
    if ([imageName hasSuffix:@".png"]) {
        filePath = [NSString stringWithFormat:@"%@/%@", bundlePath, imageName];
    } else {
        filePath = [NSString stringWithFormat:@"%@/%@.png",bundlePath, imageName];
    }
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}


+ (UIImage *)ss_imageNamed:(NSString *)imageName SubBundleName:(NSString *)subBundleName {
    
    UIImage *image = nil;
    if (subBundleName == nil || subBundleName.length == 0) {
        image = [UIImage ss_imageNamedNoCache:imageName];
    } else {
        
        NSString *resourcePath = [[NSBundle mainBundle] bundlePath];
        NSString *bundlePath = [resourcePath stringByAppendingPathComponent:subBundleName];
        NSString *imagePath = [bundlePath stringByAppendingPathComponent:imageName];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    return image;
}


//纯色图片
+ (UIImage *)ss_imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




#pragma mark - 格式

+ (NSString *)ss_contentTypeForImageData:(NSData *)data {
    
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c)
    {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}








- (UIImage *)ss_imageCroppedToRect:(CGRect)rect {
    
    // CGImageCreateWithImageInRect's `rect` parameter is in pixels of the image's coordinates system. Convert from points.
    CGFloat scale = self.scale;
    rect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return cropped;
}


- (UIImage *)ss_squareImage {
    
    CGSize imageSize = self.size;
    CGFloat shortestSide = fminf(imageSize.width, imageSize.height);
    return [self ss_imageCroppedToRect:CGRectMake(0.0f, 0.0f, shortestSide, shortestSide)];
}





+ (UIImage *)ss_grabScreenWithScale:(CGFloat)scale {
    
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    //    UIGraphicsBeginImageContext(screenWindow.frame.size);
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, YES, scale);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)ss_grabImageWithView:(UIView *)view scale:(CGFloat)scale {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}

+ (UIImage *)ss_captureView:(UIView *)view frame:(CGRect)frame {
    
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, frame);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}

+ (UIImage *)ss_mergeWithImage1:(UIImage*)image1 Image2:(UIImage *)image2
                         Frame1:(CGRect)frame1 Frame2:(CGRect)frame2
                           Size:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:frame1 blendMode:kCGBlendModeLuminosity alpha:1.0];
    [image2 drawInRect:frame2 blendMode:kCGBlendModeLuminosity alpha:0.2];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*) ss_maskImage:(UIImage *)image withMask:(UIImage *)mask {
    
    CGImageRef imgRef = [image CGImage];
    CGImageRef maskRef = [mask CGImage];
    CGImageRef actualMask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                              CGImageGetHeight(maskRef),
                                              CGImageGetBitsPerComponent(maskRef),
                                              CGImageGetBitsPerPixel(maskRef),
                                              CGImageGetBytesPerRow(maskRef),
                                              CGImageGetDataProvider(maskRef), NULL, true);
    CGImageRef masked = CGImageCreateWithMask(imgRef, actualMask);
    UIImage *resultImg = [UIImage imageWithCGImage:masked];
    CGImageRelease(actualMask);
    CGImageRelease(masked);
    
    return resultImg;
}

+ (UIImage *)ss_scaleImage:(UIImage *)image toSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+(UIImage *)ss_colorizeImage:(UIImage *)image withColor:(UIColor *)color {
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, image.CGImage);
    [color set];
    CGContextFillRect(ctx, area);
    CGContextRestoreGState(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}





@end
