//
//  FDSpeedTopView.h
//  Freedom
//
//  Created by Andrew on 2021/1/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FDSpeedTopView;

@protocol FDSpeedTopViewDelegate <NSObject>

- (void)topView:(FDSpeedTopView *)topView menuBtn:(UIButton *)menuBtn;

@end

@interface FDSpeedTopView : UIView

@property (nonatomic, assign) CGFloat accelerationX; // 加速度

@property (nonatomic, weak) id<FDSpeedTopViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
