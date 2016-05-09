//
//  UITableView+SSToolkitAdditions.m
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import "UITableView+SSToolkitAdditions.h"

@implementation UITableView (SSToolkitAdditions)



- (void)ss_setDataSourceDelegate:(id<UITableViewDataSource,UITableViewDelegate>)dataSourceDelegate {
    
    self.dataSource = dataSourceDelegate;
    self.delegate = dataSourceDelegate;
}

- (void)ss_hideEmptyCell {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableFooterView = footerView;
}


- (void)ss_hideSeparatorLine {
    
    [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


- (NSIndexPath *)ss_indexPathForRowContainingView:(UIView *)view {
    
    CGPoint correctedPoint = [view convertPoint:view.bounds.origin toView:self];
    return [self indexPathForRowAtPoint:correctedPoint];
}




#pragma mark - cell


//beginUpdates方法和endUpdates, 配合起来使用的，标记了一个tableView的动画块。
//分别代表动画的开始开始和结束。
//两者成对出现，可以嵌套使用。
//一般，在添加，删除，选择 tableView中使用，并实现动画效果。


- (void)ss_updateWithBlock:(void (^)(UITableView *tableView))block {
    
    [self beginUpdates];
    block(self);
    [self endUpdates];
}

- (void)ss_scrollToRow:(NSUInteger)row
             inSection:(NSUInteger)section
      atScrollPosition:(UITableViewScrollPosition)scrollPosition
              animated:(BOOL)animated {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}


#pragma mark - row(插入，删除，reload)

//UITableViewRowAnimationFade,   //淡入淡出
//UITableViewRowAnimationRight,  //从右滑入         // slide in from right (or out to right)
//UITableViewRowAnimationLeft,   //从左滑入
//UITableViewRowAnimationTop,     //从上滑入
//UITableViewRowAnimationBottom,  //从下滑入


- (void)ss_insertRowAtIndexPath:(NSIndexPath *)indexPath
               withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)ss_insertRow:(NSUInteger)row
           inSection:(NSUInteger)section
    withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSIndexPath *toInsert = [NSIndexPath indexPathForRow:row inSection:section];
    [self ss_insertRowAtIndexPath:toInsert withRowAnimation:animation];
}


- (void)ss_reloadRowAtIndexPath:(NSIndexPath *)indexPath
               withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)ss_reloadRow:(NSUInteger)row
           inSection:(NSUInteger)section
    withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSIndexPath *toReload = [NSIndexPath indexPathForRow:row inSection:section];
    [self ss_reloadRowAtIndexPath:toReload withRowAnimation:animation];
}


- (void)ss_deleteRowAtIndexPath:(NSIndexPath *)indexPath
               withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)ss_deleteRow:(NSUInteger)row
           inSection:(NSUInteger)section
    withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSIndexPath *toDelete = [NSIndexPath indexPathForRow:row inSection:section];
    [self ss_deleteRowAtIndexPath:toDelete withRowAnimation:animation];
}


#pragma mark - section(插入，删除，reload)

- (void)ss_insertSection:(NSUInteger)section
        withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self insertSections:sections withRowAnimation:animation];
}

- (void)ss_deleteSection:(NSUInteger)section
        withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];
    [self deleteSections:sections withRowAnimation:animation];
}

- (void)ss_reloadSection:(NSUInteger)section
        withRowAnimation:(UITableViewRowAnimation)animation {
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self reloadSections:indexSet withRowAnimation:animation];
}

- (void)ss_clearSelectedRowsAnimated:(BOOL)animated {
    
    NSArray *indexs = [self indexPathsForSelectedRows];
    [indexs enumerateObjectsUsingBlock:^(NSIndexPath* path, NSUInteger idx, BOOL *stop) {
        [self deselectRowAtIndexPath:path animated:animated];
    }];
}

@end
