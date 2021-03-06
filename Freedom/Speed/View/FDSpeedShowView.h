//
//  FDSpeedShowView.h
//  Freedom
//
//  Created by Andrew on 2021/1/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FDSpeedShowView;

@protocol FDSpeedShowViewDelegate <NSObject>

- (void)showView:(FDSpeedShowView *)showView addBtn:(UIButton *)addBtn;

@end


@interface FDSpeedShowView : UIView
@property (nonatomic, weak) id<FDSpeedShowViewDelegate> delegate;
@property (nonatomic, assign) CGFloat accelerationX; // 加速度
@end

NS_ASSUME_NONNULL_END
