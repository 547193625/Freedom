//
//  UITableView+SJRegisterCellClass.h
//  ShanJu
//
//  Created by O*O on 2018/3/19.
//  Copyright © 2018年 lane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SJRegisterCellClass)

- (void)registerReuseCellClass:(Class)cellClass;

@end

@interface UICollectionView (SJRegisterCellClass)

- (void)registerReuseCellClass:(Class)cellClass;

@end
