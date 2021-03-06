//
//  FDFavoriteColorView.h
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FDFavoriteColorView;

@protocol FDFavoriteColorViewDelegate <NSObject>

- (void)favoriteColorView:(FDFavoriteColorView *)favoriteColorView addBtn:(UIButton *)addBtn;

@end

@interface FDFavoriteColorView : UIView



@property (nonatomic, weak) id <FDFavoriteColorViewDelegate> delegate;

- (void)updateSelectedColor:(NSMutableArray *)preSelectColorArray;

- (instancetype)initWithFrame:(CGRect)frame preSelectColorArray:(NSMutableArray *)preSelectColorArray;

@end

NS_ASSUME_NONNULL_END
