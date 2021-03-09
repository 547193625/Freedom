//
//  FDFavoriteColorView.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDFavoriteColorView.h"
#import "FDColorCollectionViewCell.h"


#define MAX_COLOR  8

@interface FDFavoriteColorView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *delBtn; // 删除

@property (nonatomic, assign) NSInteger  item;

@property (nonatomic, assign) BOOL isMax; // 是否最大

@property (nonatomic, strong) NSMutableArray<FDColorModel *> *preSelectColorArray;

@end

@implementation FDFavoriteColorView

-(instancetype)initWithFrame:(CGRect)frame preSelectColorArray:(NSMutableArray *)preSelectColorArray{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_FFFFFF;
        [self addSubview:self.collectionView];
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
       make.top.equalTo(self.collectionView.mas_bottom).offset(0);
       make.size.mas_offset(CGSizeMake(120, 60));
    }];
}



-(void)configColorArray:(NSMutableArray *)preSelectColorArray{
    
    self.isMax = preSelectColorArray.count == MAX_COLOR ? YES : NO;
    
    [self.collectionView reloadData];

}


#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.preSelectColorArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FDColorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FDColorCollectionViewCell className] forIndexPath:indexPath];
    FDColorModel *colorModel =  self.preSelectColorArray[indexPath.item];
    cell.colorModel = colorModel;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FDColorModel *colorModel =  self.preSelectColorArray[indexPath.item];
    if (colorModel.color == nil) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(favoriteColorView:item:)]) {
            [self.delegate favoriteColorView:self item:indexPath.item];
           }
    }else{
        self.item = indexPath.item;
        if (self.delegate && [self.delegate respondsToSelector:@selector(favoriteColorView:colorModel:item:array:)]) {
              [self.delegate favoriteColorView:self colorModel:colorModel item:indexPath.item array:self.preSelectColorArray];
           }
    }

}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        return CGSizeMake(self.width/self.preSelectColorArray.count, 50);

}


// 删除
-(void)delBtnClick:(UIButton *)btn{
    if (self.preSelectColorArray.count == MAX_COLOR && self.isMax == YES) {
        FDColorModel *model = [[FDColorModel alloc] init];
        [self.preSelectColorArray replaceObjectAtIndex:self.preSelectColorArray.count - 1 withObject:model];
        [self updateSelectedColor:self.preSelectColorArray];
        self.item = MAX_COLOR - 1;
        self.item = self.item  == 0 ? 0 : self.item - 1;
        if (self.delegate && [self.delegate respondsToSelector:@selector(favoriteColorView:array:item:)]) {
            [self.delegate favoriteColorView:self array:self.preSelectColorArray item:self.item];
           }
    }else{
        DebugLog(@"count__%zd",self.preSelectColorArray.count);
        DebugLog(@"item__%zd",self.item);
        if (self.item >= 0) {
            [self.preSelectColorArray removeObjectAtIndex:self.item];
            self.item = self.item  == 0 ? 0 : self.item - 1;
        }else{
            [self.preSelectColorArray removeObjectAtIndex:self.preSelectColorArray.count - 2];
        }
        [self updateSelectedColor:self.preSelectColorArray];
        if (self.delegate && [self.delegate respondsToSelector:@selector(favoriteColorView:array:item:)]) {
            [self.delegate favoriteColorView:self array:self.preSelectColorArray item:self.item];
           }
    }
   
}


// 更新数组
-(void)updateSelectedColor:(NSMutableArray *)preSelectColorArray{
    _preSelectColorArray = preSelectColorArray;
    if (preSelectColorArray.count  == MAX_COLOR + 1) {
        self.isMax = YES;
        [self.preSelectColorArray removeLastObject];
    }else{
        self.isMax = NO;
    }
    [self.collectionView reloadData];
    
    self.delBtn.hidden = preSelectColorArray.count == 1 ? YES : NO;
}


// 更新单个颜色
-(void)updateSelectedColorModel:(FDColorModel *)colorModel{
    [self.collectionView  reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.item inSection:0], nil]];

}


#pragma mark - lazy
- (UICollectionView *)collectionView{
    if (!_collectionView) {
         UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        collectionLayout.minimumLineSpacing = 0;
        collectionLayout.minimumInteritemSpacing = 0;
        collectionLayout.estimatedItemSize = CGSizeZero;
        collectionLayout.itemSize = CGSizeMake(self.width/self.preSelectColorArray.count, 50);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) collectionViewLayout:collectionLayout];
        _collectionView.backgroundColor = Color_FFFFFF;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.delaysContentTouches = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerReuseCellClass:[FDColorCollectionViewCell class]];
    }
    return _collectionView;
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
