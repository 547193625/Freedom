//
//  MSDragButton.h
//  MSDragBtn
//
//  Created by peng zhao on 2019/11/26.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSDragButtonRemainStyle) {
    MSDragButtonRemainStyleNone,//默认 无自动停靠边界，停留在最后的可控范围内
    MSDragButtonRemainStyleAutomaticMargin,//自动吸附在可控范围边界（内部只实现在左右边界吸附）
    MSDragButtonRemainStyleAutomaticMarginLeft,//自动吸附 左 边界
    MSDragButtonRemainStyleAutomaticMarginRight,//自动吸附 右 边界
};

@interface MSDragButton : UIButton
/// 悬浮按钮的拖拽范围
@property (nonatomic) CGRect cagingArea;
/// 停留样式
@property (nonatomic, assign) MSDragButtonRemainStyle remainStyle;

@property (nonatomic, copy) void (^panBtnComplete)(CGFloat x,CGFloat y);

@end

NS_ASSUME_NONNULL_END
