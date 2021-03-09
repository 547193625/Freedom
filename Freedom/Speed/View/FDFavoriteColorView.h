//
//  FDFavoriteColorView.h
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import <UIKit/UIKit.h>
#import "FDColorModel.h"

NS_ASSUME_NONNULL_BEGIN

@class FDFavoriteColorView;

@protocol FDFavoriteColorViewDelegate <NSObject>

// 添加
- (void)favoriteColorView:(FDFavoriteColorView *)favoriteColorView item:(NSInteger )item;

// 点击了颜色
- (void)favoriteColorView:(FDFavoriteColorView *)favoriteColorView colorModel:(FDColorModel * )colorModel item:(NSInteger )item array:(NSMutableArray <FDColorModel *>*)array;

// 删除
- (void)favoriteColorView:(FDFavoriteColorView *)favoriteColorView  array:(NSMutableArray <FDColorModel *>*)array item:(NSInteger )item;


@end

@interface FDFavoriteColorView : UIView



@property (nonatomic, weak) id <FDFavoriteColorViewDelegate> delegate;

// 更新颜色数组
- (void)updateSelectedColor:(NSMutableArray *)preSelectColorArray;

// 更新单个颜色
-(void)updateSelectedColorModel:(FDColorModel *)colorModel;


- (instancetype)initWithFrame:(CGRect)frame preSelectColorArray:(NSMutableArray *)preSelectColorArray;

@end

NS_ASSUME_NONNULL_END
