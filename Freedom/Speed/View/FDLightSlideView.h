//
//  FDLightSlideView.h
//  Freedom
//
//  Created by Andrew on 2021/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FDLightSlideView;

@protocol FDLightSlideViewDelegate <NSObject>

// 滑块数值
- (void)lightSlideView:(FDLightSlideView *)LightSlideView slider:(UISlider *)slider;

@end

@interface FDLightSlideView : UIView

@property (nonatomic, weak) id <FDLightSlideViewDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
