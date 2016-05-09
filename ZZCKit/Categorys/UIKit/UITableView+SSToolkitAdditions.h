//
//  UITableView+SSToolkitAdditions.h
//    
//
//  Created by fdd_zzc on 15/4/28.
//  Copyright (c) 2015年 fdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SSToolkitAdditions)


//设置数据源和委托
- (void)ss_setDataSourceDelegate:(id<UITableViewDataSource,UITableViewDelegate>)dataSourceDelegate;

//隐藏多余的空cell
- (void)ss_hideEmptyCell;

//隐藏分隔线
- (void)ss_hideSeparatorLine;

//获取view所在的cell的indexPath
- (NSIndexPath *)ss_indexPathForRowContainingView:(UIView *)view;





#pragma mark - cell


- (void)ss_updateWithBlock:(void (^)(UITableView *tableView))block;

- (void)ss_scrollToRow:(NSUInteger)row
             inSection:(NSUInteger)section
      atScrollPosition:(UITableViewScrollPosition)scrollPosition
              animated:(BOOL)animated;


#pragma mark - row(插入，删除，reload)

- (void)ss_insertRowAtIndexPath:(NSIndexPath *)indexPath
               withRowAnimation:(UITableViewRowAnimation)animation;

- (void)ss_insertRow:(NSUInteger)row
           inSection:(NSUInteger)section
    withRowAnimation:(UITableViewRowAnimation)animation;

- (void)ss_reloadRowAtIndexPath:(NSIndexPath *)indexPath
               withRowAnimation:(UITableViewRowAnimation)animation;

- (void)ss_reloadRow:(NSUInteger)row
           inSection:(NSUInteger)section
    withRowAnimation:(UITableViewRowAnimation)animation;

- (void)ss_deleteRowAtIndexPath:(NSIndexPath *)indexPath
               withRowAnimation:(UITableViewRowAnimation)animation;

- (void)ss_deleteRow:(NSUInteger)row
           inSection:(NSUInteger)section
    withRowAnimation:(UITableViewRowAnimation)animation;


#pragma mark - section(插入，删除，reload)

- (void)ss_insertSection:(NSUInteger)section
        withRowAnimation:(UITableViewRowAnimation)animation;

- (void)ss_deleteSection:(NSUInteger)section
        withRowAnimation:(UITableViewRowAnimation)animation;

- (void)ss_reloadSection:(NSUInteger)section
        withRowAnimation:(UITableViewRowAnimation)animation;

- (void)ss_clearSelectedRowsAnimated:(BOOL)animated;


@end
