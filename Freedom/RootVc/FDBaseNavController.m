//
//  FDBaseNavController.m
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import "FDBaseNavController.h"

@interface FDBaseNavController ()


@end

@implementation FDBaseNavController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNavigationMethod];
}

- (void)setNavigationMethod{
    self.navigationBar.translucent = NO;
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = Color_649CF0;
      /** 设置导航栏标题文字颜色 */
      NSDictionary *dict = @{
                             NSForegroundColorAttributeName : Color_FFFFFF,
                             NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                             };
      [navBar setTitleTextAttributes:dict];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
