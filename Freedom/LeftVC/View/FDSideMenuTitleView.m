//
//  FDSideMenuTitleView.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDSideMenuTitleView.h"

@interface FDSideMenuTitleView ()
@property(nonatomic,strong) UILabel *nameLabel; // 名字
@property(nonatomic, strong) UISwitch *openSwitch;//开关
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) BOOL isHidden;
@end

@implementation FDSideMenuTitleView

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title IsHidden:(BOOL)isHidden{
    self = [super initWithFrame:frame];
    if (self){
        self.title = title;
        self.isHidden = isHidden;
        [self configSideMenuTitleView];
    }
    return self;
}


-(void)configSideMenuTitleView{
    self.backgroundColor = Color_EBEEF3;
    [self addSubview:self.nameLabel];
    [self addSubview:self.openSwitch];
    self.nameLabel.text = self.title;
    self.openSwitch.hidden = self.isHidden;
}

-(void)layoutSubviews{
     [super layoutSubviews];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_offset(20);
    }];
    
    [self.openSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-95);
        make.size.mas_offset(CGSizeMake(50, 30));
    }];
    
}


- (void)switchClickHandle:(UISwitch *)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(menuTitleView:openSwitch:)]){
        [self.delegate menuTitleView:self openSwitch:sender];
    }
}


#pragma mark - lazy
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = Color_333333;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = Font_17;
        _nameLabel.text = @"";
    }
    return _nameLabel;
}

-(UISwitch *)openSwitch{
    if (!_openSwitch) {
        _openSwitch = [[UISwitch alloc] init];
        _openSwitch.onTintColor = Color_649CF0;
        [_openSwitch setOnImage:[UIImage imageNamed:@"switch_open"]];
        [_openSwitch setOffImage:[UIImage imageNamed:@"switch_close"]];
        [_openSwitch addTarget:self action:@selector(switchClickHandle:) forControlEvents:UIControlEventValueChanged];
    }
    return _openSwitch;
}
@end
