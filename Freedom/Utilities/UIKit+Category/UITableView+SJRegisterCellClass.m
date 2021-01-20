//
//  UITableView+SJRegisterCellClass.m
//  ShanJu
//
//  Created by O*O on 2018/3/19.
//  Copyright © 2018年 lane. All rights reserved.
//

#import "UITableView+SJRegisterCellClass.h"

@implementation UITableView (SJRegisterCellClass)

- (void)registerReuseCellClass:(Class)cellClass
{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

@end

@implementation UICollectionView (SJRegisterCellClass)

- (void)registerReuseCellClass:(Class)cellClass
{
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

@end
