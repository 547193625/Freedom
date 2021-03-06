//
//  FDSideMenuViewController.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDSideMenuViewController.h"
#import "FDSideMenuTitleView.h"

@interface FDSideMenuViewController ()<UITableViewDelegate,UITableViewDataSource,FDSideMenuTitleViewDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FDSideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSideMenuUI];
}

-(void)configSideMenuUI{
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = Color_EBEEF3;
    [self.view addSubview:self.tableView];
}

#pragma mark ----UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell className]];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"设备 %zd",indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        FDSideMenuTitleView *view = [[FDSideMenuTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 75, 44) Title:@"设备列表" IsHidden:NO];
        view.delegate = self;
        return view;
    }else{
        FDSideMenuTitleView *view = [[FDSideMenuTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 75, 44) Title:@"未配对" IsHidden:YES];
        return view;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  44.0f;
}

#pragma mark - 设备开关
-(void)menuTitleView:(FDSideMenuTitleView *)menuTitleView openSwitch:(UISwitch *)openSwitch{
    
}




#pragma mark - lazy load
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kTopBarSafeHeight, kScreenWidth, kScreenHeight - kTopBarSafeHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = Color_FFFFFF;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerReuseCellClass:[UITableViewCell class]];
        if (@available(iOS 11.0, *)) {
              _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
          } else {
              self.automaticallyAdjustsScrollViewInsets = NO;
          }
    }
    return _tableView;
}

@end
