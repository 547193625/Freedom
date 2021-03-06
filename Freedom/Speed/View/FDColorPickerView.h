//
//  FDColorPickerView.h
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FDColorPickerView;

@protocol FDColorPickerViewDelegate <NSObject>

- (void)getCurrentColor:(UIColor *)color;

@end

@interface FDColorPickerView : UIView

@property (nonatomic, weak) id <FDColorPickerViewDelegate> delegate;

// 随机坐标位置
-(void)updateDragButtonPoint:(CGPoint)point;


@end

NS_ASSUME_NONNULL_END
