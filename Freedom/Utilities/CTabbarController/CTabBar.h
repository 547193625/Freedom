//
//  CTabBar.h
//  CustomTabbarController
//
//  Created by Liu Jiang on 2017/9/27.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTabBar;
@protocol CTabBarControllerDelegate <NSObject>
@required
- (void)tabBar:(CTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;
@optional
- (void)gotoExtraViewControllers;
- (void)isSetBarBackgroundColorOrImage;
- (void)beyondMaxItemsNumLimit:(NSArray<NSString *> *)beyondItemsTitle;
@end

@interface CTabBar : UIView
//如果某个Item 只显示图片  或某个Item 只显示文字, 请在相应数组对应位置 转入@""; 务必保证button数组 和 image数组长度一致
@property (nonatomic, strong)NSArray<NSString *> *tabBarItemsArray; //item 标题
@property (nonatomic, strong)NSArray<NSString *> *tabBarItemsImageArray;
@property (nonatomic, strong)NSArray<NSString *> *tabBarItemsImageSelectedArray;
@property (nonatomic, readonly, assign)BOOL isBeyondLimit; //item 是否超过 5
@property (nonatomic, assign)UIOffset offset;
@property (nonatomic, strong)UIColor *barTintColor;
@property (nonatomic, strong)UIImage *backgroundImage;

@property (nonatomic, weak)id<CTabBarControllerDelegate> delegete;
- (void)setTextAttributes:(NSDictionary *)attributes state:(UIControlState)state;
- (void)addChildItemWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;
@end
