//
//  FDThemeViewController.m
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import "FDThemeViewController.h"
#import "FDThemeListTableViewCell.h"
#import "FDThemeModel.h"
#import "FDThemeColorModel.h"

@interface FDThemeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <FDThemeModel *>*themeArray;

@end

@implementation FDThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"主题";
    [self configItemUI];
    [self loadColorData];
}

-(void)configItemUI{
    UIBarButtonItem *left = [UIBarButtonItem itemWithImage:FDImage(@"theme_color_add")  highImage:FDImage(@"theme_color_add") target:self action:@selector(addThemeClick)];
    self.navigationItem.leftBarButtonItem = left;
    UIBarButtonItem *right = [UIBarButtonItem itemWithImage:FDImage(@"menu_right")  highImage:FDImage(@"menu_right") target:self action:@selector(menuClick)];
    self.navigationItem.rightBarButtonItem = right;
    [self.view addSubview:self.tableView];
}


-(void)addThemeClick{
    DebugLog(@"增加主题+++");
}

-(void)menuClick{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.themeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FDThemeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FDThemeListTableViewCell className]];
       if (!cell) {
           cell = [[FDThemeListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FDThemeListTableViewCell className]];
       }
    FDThemeModel *themeModel = self.themeArray[indexPath.row];
    cell.themeModel = themeModel;
    return cell;
}



-(void)loadColorData{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:1];
    {
        FDThemeModel *model = [FDThemeModel new];
        model.name = @"Valentine";
        model.hartType = AAChartTypeSpline;
        
        FDThemeColorModel *colorModel = [FDThemeColorModel new];
        colorModel.x = 0.00;
        colorModel.color = @"#febc0f";
        [colorArray addObject:colorModel];
        
        FDThemeColorModel *colorModel1 = [FDThemeColorModel new];
        colorModel1.x = 0.25;
        colorModel1.color = @"#FF14d4";
        [colorArray addObject:colorModel1];
        
        FDThemeColorModel *colorModel2 = [FDThemeColorModel new];
        colorModel2.x = 0.5;
        colorModel2.color = @"#0bf8f5";
        [colorArray addObject:colorModel2];
        
        FDThemeColorModel *colorModel3 = [FDThemeColorModel new];
        colorModel3.x = 0.75;
        colorModel3.color = @"#F33c52";
        [colorArray addObject:colorModel3];
        
        model.colorArray = colorArray;
        [array addObject:model];
    }
    {
        FDThemeModel *model = [FDThemeModel new];
        model.name = @"Passion Heat";
        model.hartType = AAChartTypeLine;
        
        FDThemeColorModel *colorModel = [FDThemeColorModel new];
        colorModel.x = 0.00;
        colorModel.color = @"#febc0f";
        [colorArray addObject:colorModel];
    
        
        FDThemeColorModel *colorModel1 = [FDThemeColorModel new];
        colorModel1.x = 0.25;
        colorModel1.color = @"#FF14d4";
        [colorArray addObject:colorModel1];
        
        FDThemeColorModel *colorModel2 = [FDThemeColorModel new];
        colorModel2.x = 0.5;
        colorModel2.color = @"#0bf8f5";
        [colorArray addObject:colorModel2];
        
        FDThemeColorModel *colorModel3 = [FDThemeColorModel new];
        colorModel3.x = 0.75;
        colorModel3.color = @"#F33c52";
        [colorArray addObject:colorModel3];
        
        FDThemeColorModel *colorModel4 = [FDThemeColorModel new];
        colorModel4.x = 1.00;
        colorModel4.color = @"#1904dd";
        [colorArray addObject:colorModel4];
        
        model.colorArray = colorArray;
        [array addObject:model];
    }
    self.themeArray = array;
}




#pragma mark - lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = Color_162940;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerReuseCellClass:[FDThemeListTableViewCell class]];
    }
    return _tableView;
}




@end
