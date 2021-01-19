//
//  CTabbarController.h
//  CustomTabbarController
//
//  Created by Liu Jiang on 2017/9/26.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTabBar.h"
@interface CTabbarController : UITabBarController
@property (nonatomic, readonly, strong)CTabBar *cTabBar;
@property (nonatomic, assign)CGFloat cTabBarHeight;
@property (nonatomic, assign)UIOffset cTabBarOffset;
@property (nonatomic, strong)NSMutableArray *cViewControllers;
- (void)cAddChildViewController:(__kindof UIViewController *)childViewController;
@end
