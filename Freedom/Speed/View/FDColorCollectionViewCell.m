//
//  FDColorCollectionViewCell.m
//  Freedom
//
//  Created by Andrew on 2021/3/8.
//

#import "FDColorCollectionViewCell.h"

@interface FDColorCollectionViewCell()
@property(nonatomic, strong) UIView *colorView;
@property(nonatomic, strong) UIImageView *addImageView;
@end


@implementation FDColorCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_FFFFFF;
        [self configColorCollectionViewCellUI];
    }
    return self;
}


-(void)configColorCollectionViewCellUI{
    [self.contentView addSubview:self.colorView];
    [self.contentView addSubview:self.addImageView];
    
    self.addImageView.hidden = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];

     [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.centerX.equalTo(self.contentView);
         make.left.right.equalTo(self.contentView);
         make.height.mas_offset(self.height);
     }];

    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(24, 24));
    }];
    
}

-(void)setColorModel:(FDColorModel *)colorModel{
    _colorModel = colorModel;
    if (colorModel.color == nil) {
        self.addImageView.hidden = NO;
        self.colorView.backgroundColor = Color_F3F5F8;
        self.backgroundColor = Color_F3F5F8;
    }else{
        self.colorView.backgroundColor = colorModel.color;
        self.addImageView.hidden = YES;
    }

}


#pragma mark --- lazy load
- (UIView *)colorView{
    if (!_colorView) {
        _colorView = [[UIView alloc] init];
        _colorView.backgroundColor = Color_FFFFFF;
    }
    return _colorView;
}


-(UIImageView *)addImageView{
    if (!_addImageView) {
        _addImageView = [[UIImageView alloc] init];
        [_addImageView setImage:FDImage(@"select_add")];
    }
    return _addImageView;
}
@end
