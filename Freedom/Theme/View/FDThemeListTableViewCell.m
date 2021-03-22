//
//  FDThemeListTableViewCell.m
//  Freedom
//
//  Created by Andrew on 2021/3/22.
//

#import "FDThemeListTableViewCell.h"
#import "FDThemeColorModel.h"

@interface FDThemeListTableViewCell ()
@property(nonatomic,strong) AAChartView *aaChartView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UIButton *tipBtn;
@property(nonatomic,strong) UIView *lineView;
@end

@implementation FDThemeListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = Color_162940;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addThemeListSubUI];
    }
    return self;
}



-(void)addThemeListSubUI{
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.tipBtn];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.aaChartView];
    
        
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(17);
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.height.mas_offset(22);
    }];
    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.top.equalTo(self.contentView.mas_top).offset(14);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.size.mas_offset(CGSizeMake(self.width - 30, 0.5));
    }];
    
    [self.aaChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.size.mas_offset(CGSizeMake(self.width - 80, 60));
    }];
    
}


-(void)setColorArray:(NSArray *)colorArray{
    _colorArray = colorArray;

}

-(void)setThemeModel:(FDThemeModel *)themeModel{
    _themeModel = themeModel;
    self.nameLabel.text = themeModel.name;
    NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:0];
    for (FDThemeColorModel *colorModel in themeModel.colorArray) {
        NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:1];
        [itemArray addObject:[NSNumber numberWithFloat:colorModel.x]];
        [itemArray addObject:colorModel.color];
        [colorArray addObject:itemArray];
    }
    DebugLog(@"");

    if (colorArray.count == 0) {
        return;
    }
    
    NSDictionary *gradientColorDic1 =
    [AAGradientColor gradientColorWithDirection:AALinearGradientDirectionToRight
                                     stopsArray:colorArray];

    AAChartModel *aaChartModel= AAObject(AAChartModel)


    .chartTypeSet(themeModel.hartType)
    .markerRadiusSet(@0)
    .yAxisVisibleSet(false)
    .xAxisVisibleSet(false)
    .backgroundColorSet(@"#162940")
    .legendEnabledSet(false)
    .dataLabelsEnabledSet(false)//是否显示值
//    .seriesSet(@[
//        AASeriesElement.new
//        .lineWidthSet(@6)
//        .colorSet((id)gradientColorDic1)
//        .dataSet(@[@7.0, @10, @7.0, @10, @7.0, @10]),
//               ]);

    .seriesSet(@[
        AASeriesElement.new
        .lineWidthSet(@6)
        .colorSet((id)gradientColorDic1)
        .dataSet(@[@7.0, @10, @7.0, @10, @7.0, @10])
        .stepSet(@"right"), //折线连接点靠右👉
               ]);

    [_aaChartView aa_drawChartWithChartModel:aaChartModel];
}

-(void)tipBtnClick:(UIButton *)btn{
    DebugLog(@"小提示");
}



#pragma mark - lazy load
-(AAChartView *)aaChartView{
    if (!_aaChartView) {
        _aaChartView = [[AAChartView alloc]init];
        _aaChartView.backgroundColor = Color_162940;
        _aaChartView.scrollEnabled = NO;
        _aaChartView.contentHeight = 60;
    }
    return _aaChartView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"Patriotic";
        _nameLabel.textColor = Color_FFFFFF;
        _nameLabel.font = Font_16;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UIButton *)tipBtn{
    if (!_tipBtn) {
        _tipBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        [_tipBtn setImage:FDImage(@"theme_tip") forState:UIControlStateNormal];
        [_tipBtn setImage:FDImage(@"theme_tip") forState:UIControlStateSelected];
        [_tipBtn addTarget:self action:@selector(tipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tipBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    }
    return _tipBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = Color_666666;
    }
    return _lineView;
}


@end
