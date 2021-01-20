//
//  FDSpeedTopView.m
//  Freedom
//
//  Created by Andrew on 2021/1/20.
//

#import "FDSpeedTopView.h"
#import "SPPageMenu.h"


@interface FDSpeedTopView()<SPPageMenuDelegate>
@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic, strong) UIImageView *speedBgImageView;
@property(nonatomic, strong) UIButton *menuBtn;
@property(nonatomic, strong) UIButton *speedBtn; //速度
@property(nonatomic, strong) UIButton *accellerBtn;//加速度
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) SPPageMenu *pageMenu;
@end

@implementation FDSpeedTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AppBackgroundColor;
        [self setUpSpeedTopViewUI];
    }
    return self;
}

-(void)setUpSpeedTopViewUI{
    [self addSubview:self.bgImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.menuBtn];
    [self addSubview:self.speedBtn];
    [self addSubview:self.accellerBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.pageMenu];
    [self addSubview:self.speedBgImageView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(0);
        make.size.mas_offset(CGSizeMake(self.width, 160+kTopBarSafeHeight));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(kTopBarDifHeight + 10);
        make.height.mas_offset(18);
    }];
    
    [self.menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.titleLabel);
       make.right.equalTo(self.mas_right).offset(-16);
       make.size.mas_offset(CGSizeMake(22, 22));
    }];
    
    [self.speedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.titleLabel);
       make.left.equalTo(self.mas_left).offset(16);
       make.size.mas_offset(CGSizeMake(22, 22));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.left.equalTo(self.speedBtn.mas_right).offset(4);
        make.size.mas_offset(CGSizeMake(1, 18));
    }];

    [self.accellerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(self.titleLabel);
       make.left.equalTo(self.lineView.mas_right).offset(4);
       make.size.mas_offset(CGSizeMake(22, 22));
    }];
    
    
    [self.pageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(22);
        make.size.mas_offset(CGSizeMake(110, 26));
    }];
    
    [self.speedBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.pageMenu.mas_bottom).offset(13);
        make.size.mas_offset(CGSizeMake(self.width - 12, 104));
    }];
    
}

// 侧边栏
-(void)menuBtnClick:(UIButton *)btn{
    
}
// 速度
-(void)speedBtnClick:(UIButton *)btn{
    
}

// 加速度
-(void)accellerBtnClick:(UIButton *)btn{
    
}

-(void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index{
    DebugLog(@"index__%zd",index);
}


#pragma make ---- lazy load
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        [_bgImageView setImage:FDImage(@"speed_bg_icon")];
    }
    return _bgImageView;
}
-(UIImageView *)speedBgImageView{
    if (!_speedBgImageView) {
        _speedBgImageView = [[UIImageView alloc]init];
        [_speedBgImageView setImage:FDImage(@"speed_topBg")];
    }
    return _speedBgImageView;
}

- (UIButton *)accellerBtn{
    if (!_accellerBtn) {
        _accellerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_accellerBtn setImage:FDImage(@"speed_acceler_noselect")forState:UIControlStateNormal];
        [_accellerBtn setImage:FDImage(@"speed_acceler_select") forState:UIControlStateSelected];
        [_accellerBtn addTarget:self action:@selector(accellerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accellerBtn;
}
- (UIButton *)speedBtn{
    if (!_speedBtn) {
        _speedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_speedBtn setImage:FDImage(@"speed_speed_noselect")forState:UIControlStateNormal];
        [_speedBtn setImage:FDImage(@"speed_speed_select") forState:UIControlStateSelected];
        [_speedBtn addTarget:self action:@selector(speedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _speedBtn;
}


- (UIButton *)menuBtn{
    if (!_menuBtn) {
        _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_menuBtn setImage:FDImage(@"menu_right")forState:UIControlStateNormal];
        [_menuBtn setImage:FDImage(@"menu_right") forState:UIControlStateSelected];
        [_menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"速度";
        _titleLabel.textColor = Color_FFFFFF;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = Bold_Font(16);
    }
    return _titleLabel;
}

-(UIView  *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = Color_D8D8D8;
        [NSObject addCornerRadiu:_lineView cornerWith:0.5 borderWidth:0.5 color:Color_FFFFFF];
    }
    return _lineView;
}

- (SPPageMenu *)pageMenu {
     if (!_pageMenu) {
         _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectZero trackerStyle:SPPageMenuTrackerStyleRoundedRect];
         [_pageMenu setItems:@[@"单色",@"多色"] selectedItemIndex:0];
         _pageMenu.delegate = self;
         _pageMenu.backgroundColor = RGBA(254, 255, 255, 0.1);
         _pageMenu.tracker.backgroundColor = Color_FFFFFF;
         _pageMenu.itemTitleFont = Font_13;
         _pageMenu.unSelectedItemTitleFont = Font_13;
         _pageMenu.selectedItemTitleColor = Color_4D88E0;
         _pageMenu.unSelectedItemTitleColor = Color_FFFFFF;
         _pageMenu.dividingLine.hidden = YES;
         [_pageMenu setTrackerHeight:26 cornerRadius:13];
         _pageMenu.layer.borderWidth = 0;
         _pageMenu.layer.borderColor = RGBA(254, 255, 255, 0.1).CGColor;
         _pageMenu.layer.cornerRadius = 13;
         _pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
     }
     return _pageMenu;
}
  
@end
