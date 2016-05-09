//
//  UIScrollView+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SSToolkitAdditions)


@property(nonatomic) CGFloat contentWidth;
@property(nonatomic) CGFloat contentHeight;
@property(nonatomic) CGFloat contentOffsetX;
@property(nonatomic) CGFloat contentOffsetY;



#pragma mark - content偏移

- (CGPoint)ss_topContentOffset;
- (CGPoint)ss_bottomContentOffset;
- (CGPoint)ss_leftContentOffset;
- (CGPoint)ss_rightContentOffset;


#pragma mark - 是否已滚动到(上下左右)边

- (BOOL)ss_isScrolledToTop;
- (BOOL)ss_isScrolledToBottom;
- (BOOL)ss_isScrolledToLeft;
- (BOOL)ss_isScrolledToRight;

#pragma mark - 滚动到(上下左右)边

- (void)ss_scrollToTopAnimated:(BOOL)animated;
- (void)ss_scrollToBottomAnimated:(BOOL)animated;
- (void)ss_scrollToLeftAnimated:(BOOL)animated;
- (void)ss_scrollToRightAnimated:(BOOL)animated;



#pragma mark -
- (NSUInteger)ss_verticalPageIndex;
- (NSUInteger)ss_horizontalPageIndex;
- (void)ss_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)ss_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;


#pragma mark - Pages

- (CGFloat)ss_pagesY;
- (CGFloat)ss_pagesX;
- (CGFloat)ss_currentPageY;
- (CGFloat)ss_currentPageX;
- (void) ss_setPageY:(CGFloat)page;
- (void) ss_setPageX:(CGFloat)page;
- (void) ss_setPageY:(CGFloat)page animated:(BOOL)animated;
- (void) ss_setPageX:(CGFloat)page animated:(BOOL)animated;


@end
