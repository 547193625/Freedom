//
//  FDThemeViewController.m
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import "FDThemeViewController.h"

@interface FDThemeViewController ()
@property(nonatomic, strong) AAChartView *aaChartView;
@end

@implementation FDThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Theme";
    [self conifgThemeUI];
    
}

-(void)conifgThemeUI{
    CGFloat chartViewWidth  = self.view.frame.size.width;
    CGFloat chartViewHeight = 100;
    _aaChartView = [[AAChartView alloc] init];
    _aaChartView.frame = CGRectMake(0, 60, chartViewWidth, chartViewHeight);
    ////禁用 AAChartView 滚动效果(默认不禁用)
    //self.aaChartView.scrollEnabled = NO;
    ////设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
    //_aaChartView.contentHeight = chartViewHeight;
    [self.view addSubview:_aaChartView];

    
    NSArray *stopsArr = @[
        @[@0.00, @"#febc0f"],//颜色字符串设置支持十六进制类型和 rgba 类型
        @[@0.25, @"#FF14d4"],
        @[@0.50, @"#0bf8f5"],
        @[@0.75, @"#F33c52"],
    ];
    
    NSDictionary *gradientColorDic1 =
    [AAGradientColor gradientColorWithDirection:AALinearGradientDirectionToRight
                                     stopsArray:stopsArr];
    
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    
    
    .chartTypeSet(AAChartTypeSpline)
//    .categoriesSet(@[
//        @"一月", @"二月", @"三月", @"四月", @"五月", @"六月",
//        @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"
//                   ])
    .markerRadiusSet(@0)
    .yAxisVisibleSet(false)
    .xAxisVisibleSet(false)
//    .yAxisLineWidthSet(@0)
//    .yAxisGridLineStyleSet([AALineStyle styleWithWidth:@0])
    .legendEnabledSet(false)
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Tokyo Hot")
        .lineWidthSet(@6)
        .colorSet((id)gradientColorDic1)
        .dataSet(@[@7.0, @10, @7.0, @10, @7.0, @10, @7.0, @10]),
               ]);
    /*图表视图对象调用图表模型对象,绘制最终图形*/
    [_aaChartView aa_drawChartWithChartModel:aaChartModel];
}


@end
