//
//  CTabbarController.m
//  CustomTabbarController
//
//  Created by Liu Jiang on 2017/9/26.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import "CTabbarController.h"
#import "ExtraViewController.h"
@interface CTabbarController ()<CTabBarControllerDelegate>
@property (nonatomic, strong)ExtraViewController * extraVC;
@end

@implementation CTabbarController

- (ExtraViewController *)extraVC {
    if (!_extraVC) {
        _extraVC = [ExtraViewController new];
        _extraVC.view.backgroundColor = [UIColor whiteColor];
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:_extraVC];
        na.navigationBar.translucent = YES;
       
    }
    return _extraVC;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!_cTabBar) {
            _cTabBar = [[CTabBar alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
            _cTabBar.delegete = self;
            [self.tabBar addSubview:_cTabBar];
        }

    }
    return self;
}
- (void)setCTabBarHeight:(CGFloat)cTabBarHeight {
    _cTabBarHeight = cTabBarHeight;
    if (_cTabBar) {
        CGRect rect = _cTabBar.frame;
        rect.size.height = cTabBarHeight;
        _cTabBar.frame = rect;
    }
}
- (void)setCTabBarOffset:(UIOffset)cTabBarOffset {
    _cTabBarOffset = cTabBarOffset;
    if (_cTabBar) {
        _cTabBar.offset = cTabBarOffset;
    }
}

- (void)setCViewControllers:(NSMutableArray *)cViewControllers {
    _cViewControllers = cViewControllers;
    if (cViewControllers.count > 5) {
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < 5; i++) {
            [temp addObject:cViewControllers[i]];
        }
        [temp replaceObjectAtIndex:temp.count-1 withObject:self.extraVC.navigationController];
        self.viewControllers = temp;
    }else {
        self.viewControllers = cViewControllers;
    }
    
    NSMutableArray<NSString *> *titles = [NSMutableArray array];
    for (int i = 0; i < cViewControllers.count; i++) {
        [titles addObject:@"标签"];
    }
    _cTabBar.tabBarItemsArray = [titles copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    if (_cTabBar) {
        if (_cTabBar.tabBarItemsArray.count < 1) {
            [_cTabBar removeFromSuperview];
        }
    }

}
- (void)cAddChildViewController:(__kindof UIViewController *)childViewController {
    if (!_cViewControllers) {
        _cViewControllers = [NSMutableArray arrayWithCapacity:0];
    }
    [_cViewControllers addObject:childViewController];
    if (_cViewControllers.count < 6) {///最大标签 数
        self.viewControllers = _cViewControllers;
    }else {
        if (_cViewControllers.count == 6) {
            NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
            for (int i = 0; i < 5; i++) {
                [temp addObject:_cViewControllers[i]];
            }
            [temp replaceObjectAtIndex:temp.count-1 withObject:self.extraVC.navigationController];
            self.viewControllers = temp;
        }

    }
    [self.cTabBar addChildItemWithTitle:@"标签" image:nil selectedImage:nil];
    if (_cViewControllers.count > 5) {
        [self refreshExtraData];
    }
    
}
#pragma mark - CTabBarControllerDelegate
- (void)tabBar:(CTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {
    [self setSelectedIndex:index];
}
- (void)switchToExtraViewControllers {
    NSLog(@"点击了 更多");
}
- (void)isSetBarBackgroundColorOrImage {
    ///透明自带的tabbar
    self.tabBar.backgroundImage = [self createImageWithcolor:[UIColor clearColor] size:CGSizeMake(1, 1)];
    self.tabBar.shadowImage = [UIImage new];
}
- (void)beyondMaxItemsNumLimit:(NSArray<NSString *> *)beyondItemsTitle {
    [self.extraVC.extraTitles removeAllObjects];
    [self.extraVC.extraTitles addObjectsFromArray:beyondItemsTitle];
}

- (UIImage *)createImageWithcolor:(UIColor *)color size:(CGSize)size {
    if(!(size.width > 0 && size.height > 0)){
        size = CGSizeMake(1, 1);
    }
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)refreshExtraData {
    if (self.cViewControllers.count > 5) {
        if (self.cViewControllers.count == 6) {
            [_extraVC.extraViewControllers addObject:self.cViewControllers[self.cViewControllers.count-2]];
            [_extraVC.extraViewControllers addObject:self.cViewControllers[self.cViewControllers.count-1]];
            
            [_extraVC.extraTitles addObject:self.cTabBar.tabBarItemsArray[self.cTabBar.tabBarItemsArray.count-2]];
            [_extraVC.extraTitles addObject:self.cTabBar.tabBarItemsArray[self.cTabBar.tabBarItemsArray.count-1]];

        }else {
            [_extraVC.extraViewControllers addObject:_cViewControllers.lastObject];
            [_extraVC.extraTitles addObject:self.cTabBar.tabBarItemsArray.lastObject];
        }
//        NSMutableArray *allVC = [NSMutableArray arrayWithCapacity:0];
//        for (int i = 4; i < _cViewControllers.count; i++) {
//            [allVC addObject:_cViewControllers[i]];
//        }
//    }
//    if (self.cTabBar.tabBarItemsArray.count > 5) {
//        NSMutableArray *extraItems = [NSMutableArray arrayWithCapacity:0];
//        for (int i = 4; i < _cViewControllers.count; i++) {
//            [extraItems addObject:self.cTabBar.tabBarItemsArray[i]];
//        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
