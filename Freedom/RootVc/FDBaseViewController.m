//
//  FDBaseViewController.m
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import "FDBaseViewController.h"
#import "AppDelegate.h"

@interface FDBaseViewController ()<MBProgressHUDDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation FDBaseViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AppBackgroundColor;
    self.currentPage = 0;
    [self navigationStyle];
}


//MARK:--------统一的返回
- (void)navigationStyle {
    //状态栏白字
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, 50, 44); //必须设置尺寸大小
        [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        btn.adjustsImageWhenHighlighted = NO;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK:--------导航栏底部线条--------
- (void)showLine {
//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
//    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [navigationBar setShadowImage:[UIImage imageWithColor:RGBA(237.0, 237.0, 237.0, 0.8)]];
}

//  隐藏
- (void)hideLine {
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}


//MARK:--------HUD--------
- (void)showLoading:(UIView *)view text:(NSString *)text {
    if(!_hud){
        self.hud = [[MBProgressHUD alloc] initWithView:view];
        self.hud.delegate = self;
        [view addSubview:self.hud];
    }
    
    [view bringSubviewToFront:self.hud];
    self.hud.labelText = text;
    [self.hud show:YES];
}

- (void)hideLoading {
    
    [self.hud hide:true];
}

//MARK:--MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    self.hud.delegate = nil;
    [self.hud removeFromSuperview];
    self.hud = nil;
}


- (void)showToastText:(NSString *)text {
    if (![text isKindOfClass:[NSString class]] || [text isEqualToString:@""]) return;
    [LCProgressHUD showMessage:text];
}

//网络请求出错
- (void)requestError:(NSError *)error {
    if (!error) return;
    NSString *errorDescription = [error.userInfo objectForKey:@"NSLocalizedDescription"];
    NSString *errorStatus = [error.userInfo objectForKey:@"status"];
    if (errorStatus) { // 接口返回错误
        [self showToastText:errorDescription];
    }
}


- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (id view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
}


@end
