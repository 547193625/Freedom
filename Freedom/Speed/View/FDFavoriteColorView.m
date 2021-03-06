//
//  FDFavoriteColorView.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDFavoriteColorView.h"

#define MAX_COLOR  8

@interface FDFavoriteColorView ()

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIButton *delBtn; // 删除

@property (nonatomic, strong) NSMutableArray<UIColor *> *preSelectColorArray;

@end

@implementation FDFavoriteColorView

-(instancetype)initWithFrame:(CGRect)frame preSelectColorArray:(NSMutableArray *)preSelectColorArray{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_FFFFFF;
        [self addSubview:self.topView];
        [self addSubview:self.delBtn];
        self.preSelectColorArray = preSelectColorArray;
        [self configColorArray:preSelectColorArray];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self);
       make.top.equalTo(self.topView.mas_bottom).offset(0);
       make.size.mas_offset(CGSizeMake(120, 60));
    }];
}


-(void)configColorArray:(NSMutableArray *)preSelectColorArray{
    CGFloat buttonHeight = 50;
    CGFloat buttonWidth = 0;
    NSInteger count = 0;
    if (preSelectColorArray.count == MAX_COLOR) {
       buttonWidth = self.width/(preSelectColorArray.count);
        count = preSelectColorArray.count;
    }else{
        buttonWidth = self.width/(preSelectColorArray.count + 1);
        count = preSelectColorArray.count + 1;
    }
    
    for (int i = 0; i < count; i++) {
        UIButton *colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        colorButton.tag = i;
        colorButton.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, buttonHeight);
        if (preSelectColorArray.count == MAX_COLOR) { // 最大数
            colorButton.backgroundColor = preSelectColorArray[i];
            [colorButton addTarget:self action:@selector(selectColorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            if (i == preSelectColorArray.count) {
                [colorButton setImage:[UIImage imageNamed:@"select_add"] forState:UIControlStateNormal];
                [colorButton addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                colorButton.backgroundColor = preSelectColorArray[i];
                [colorButton addTarget:self action:@selector(selectColorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }

        [self.topView addSubview:colorButton];
    }
}


-(void)selectColorBtnClick:(UIButton *)btn{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(favoriteColorView:addBtn:)]) {
//        [self.delegate favoriteColorView:self addBtn:btn];
//       }
}


-(void)addBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(favoriteColorView:addBtn:)]) {
        [self.delegate favoriteColorView:self addBtn:btn];
       }
}

// 删除
-(void)delBtnClick:(UIButton *)btn{
    if (self.preSelectColorArray.count == MAX_COLOR) {
        [self.preSelectColorArray removeLastObject];
        [self updateSelectedColor:self.preSelectColorArray];
        [self.delBtn setTitleColor:self.preSelectColorArray[self.preSelectColorArray.count] forState:UIControlStateNormal];
    }else{
        [self.preSelectColorArray removeObjectAtIndex:self.preSelectColorArray.count - 1];
        [self updateSelectedColor:self.preSelectColorArray];
        // 删除按钮颜色改变
        [self.delBtn setTitleColor:self.preSelectColorArray[self.preSelectColorArray.count - 1] forState:UIControlStateNormal];
//        UIImage *theImage = FDImage(@"slect_rem");
//        theImage = [UIImage imageWithColor:self.preSelectColorArray[self.preSelectColorArray.count - 1]];
//        [_delBtn setImage:theImage forState:UIControlStateNormal];
    }
   
}


// 更新数组
-(void)updateSelectedColor:(NSMutableArray *)preSelectColorArray{
    _preSelectColorArray = preSelectColorArray;
    // 移除全部按钮
    for( UIButton *btn in self.topView.subviews ){
        if( [btn isKindOfClass:[UIButton class]] ){
            [btn removeFromSuperview];
        }
    }
    [self configColorArray:preSelectColorArray];
    self.delBtn.hidden = preSelectColorArray.count == 0 ? YES : NO;
}



#pragma mark - lazy
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
        _topView.backgroundColor = Color_F3F5F8;
    }
    return _topView;
}
- (UIButton *)delBtn{
    if (!_delBtn) {
        _delBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        [_delBtn setTitleColor:Color_649CF0 forState:UIControlStateNormal];
        _delBtn.titleLabel.font = Font_16;
        _delBtn.tintColor = Color_649CF0;
        [_delBtn setTitle:@"删除颜色" forState:UIControlStateNormal];
        [_delBtn setImage:FDImage(@"slect_rem") forState:UIControlStateNormal];
        [_delBtn setImage:FDImage(@"slect_rem") forState:UIControlStateSelected];
        [_delBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_delBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    }
    return _delBtn;
}
@end
