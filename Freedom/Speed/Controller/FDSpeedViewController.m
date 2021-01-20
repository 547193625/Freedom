//
//  FDSpeedViewController.m
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import "FDSpeedViewController.h"
#import "FDSpeedTopView.h"

@interface FDSpeedViewController ()
@property(nonatomic, strong) FDSpeedTopView *topView;

@end

@implementation FDSpeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSpeedViewUI];
}



-(void)configSpeedViewUI{
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.topView];
}



#pragma mark - lazy
-(FDSpeedTopView *)topView{
    if (!_topView) {
        _topView = [[FDSpeedTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    }
    return _topView;
}

@end
