//
//  FDSpeedViewController.m
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import "FDSpeedViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "FDChooseColorViewController.h"
#import "FDAddColorViewController.h"
#import "FDSpeedTopView.h"
#import "FDSpeedShowView.h"


@interface FDSpeedViewController ()<FDSpeedTopViewDelegate,FDSpeedShowViewDelegate>
@property(nonatomic, strong) FDSpeedTopView *topView;
@property(nonatomic, strong) FDSpeedShowView *showView;
@property(nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation FDSpeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSpeedViewUI];
    [self accelerometerPush];
}


-(void)configSpeedViewUI{
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.showView];
}


- (void)accelerometerPush{
    // 1.初始化运动管理对象
    self.motionManager = [[CMMotionManager alloc] init];
    // 2.判断加速计是否可用
    if (![self.motionManager isAccelerometerAvailable]) {
        NSLog(@"加速计不可用");
        return;
    }
    // 3.设置加速计更新频率，以秒为单位
    self.motionManager.accelerometerUpdateInterval = 0.1;
    // 4.开始实时获取
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        //获取加速度
        CMAcceleration acceleration = accelerometerData.acceleration;
//        DebugLog(@"加速度 == x:%f, y:%f, z:%f", acceleration.x, acceleration.y, acceleration.z);
        self.topView.accelerationX = acceleration.x;
        self.showView.accelerationX = acceleration.x;
    }];
}


-(void)topView:(FDSpeedTopView *)topView menuBtn:(UIButton *)menuBtn{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}


#pragma mark - FDSpeedShowViewDelegate
-(void)showView:(FDSpeedShowView *)showView addBtn:(UIButton *)addBtn{
//    FDChooseColorViewController *vc = [[FDChooseColorViewController alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
    FDAddColorViewController *vc = [[FDAddColorViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - lazy
-(FDSpeedTopView *)topView{
    if (!_topView) {
        _topView = [[FDSpeedTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170+kTopBarSafeHeight)];
        _topView.delegate = self;
    }
    return _topView;
}

-(FDSpeedShowView *)showView{
    if (!_showView) {
        _showView = [[FDSpeedShowView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kScreenWidth - kTabBarHeight, kScreenWidth, kScreenWidth)];
        _showView.delegate = self;
    }
    return _showView;
}
@end
