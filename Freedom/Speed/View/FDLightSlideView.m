//
//  FDLightSlideView.m
//  Freedom
//
//  Created by Andrew on 2021/3/9.
//

#import "FDLightSlideView.h"

@interface FDLightSlideView ()
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *minImageView;
@property (nonatomic, strong) UIImageView *maxImageView;
@property (nonatomic, strong) UISlider *slider;
@end

@implementation FDLightSlideView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_F7F9FA;
        [self addLightSlideView];
        
    }
    return self;
}

- (void)addLightSlideView{
    [self addSubview:self.descLabel];
    [self addSubview:self.minImageView];
    [self addSubview:self.maxImageView];
    [self addSubview:self.slider];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(16);
        make.height.mas_offset(16);
    }];
    
    [self.minImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(self.descLabel.mas_bottom).offset(25);
        make.size.mas_offset(CGSizeMake(23,10));
    }];
    
    [self.maxImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self.minImageView);
        make.size.mas_offset(CGSizeMake(23,14));
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.minImageView);
        make.size.mas_offset(CGSizeMake(kScreenWidth - 96, 20));
    }];
}

-(void)sliderValueDidChanged:(UISlider *)slider{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lightSlideView:slider:)]) {
        [self.delegate lightSlideView:self slider:slider];
       }
}

#pragma mark --- lazy
- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.text = @"亮度变化幅度";
        _descLabel.textColor = Color_333333;
        _descLabel.font = Font_16;
        _descLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _descLabel;
}

-(UIImageView *)minImageView{
    if (!_minImageView) {
        _minImageView = [[UIImageView alloc] init];
        [_minImageView setImage:FDImage(@"light_min")];
    }
    return _minImageView;
}

-(UIImageView *)maxImageView{
    if (!_maxImageView) {
        _maxImageView = [[UIImageView alloc] init];
        [_maxImageView setImage:FDImage(@"light_max")];
    }
    return _maxImageView;
}

-(UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]init];
        _slider.minimumValue = 0.0;
        _slider.maximumValue = 100.0;
        _slider.value = 50;
        _slider.minimumTrackTintColor = Color_649CF0;
        _slider.maximumTrackTintColor = Color_EBEEF3;
        _slider.thumbTintColor = Color_3699ff;
        // 通常状态下
        [_slider setThumbImage:[UIImage imageNamed:@"slider_yuan"] forState:UIControlStateNormal];

        // 滑动状态下
        [_slider setThumbImage:[UIImage imageNamed:@"slider_yuan"] forState:UIControlStateHighlighted];
        [_slider addTarget:self action:@selector(sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];

    }
    return _slider;
}
@end
