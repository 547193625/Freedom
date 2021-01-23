//
//  FDSpeedViewController.m
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import "FDSpeedViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "FDSpeedTopView.h"
#import "FDSpeedShowView.h"


@interface FDSpeedViewController ()
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
        NSLog(@"加速度 == x:%f, y:%f, z:%f", acceleration.x, acceleration.y, acceleration.z);
        self.topView.accelerationX = acceleration.x;
        self.showView.accelerationX = acceleration.x;
    }];
}


#pragma mark - lazy
-(FDSpeedTopView *)topView{
    if (!_topView) {
        _topView = [[FDSpeedTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170+kTopBarSafeHeight)];
    }
    return _topView;
}

-(FDSpeedShowView *)showView{
    if (!_showView) {
        _showView = [[FDSpeedShowView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kScreenWidth - 100, kScreenWidth, kScreenWidth)];
    }
    return _showView;
}
@end
