//
//  UIButton+Style.h
//  test
//
//  Created by 刘江 on 2017/9/8.
//  Copyright © 2017年 Liujiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ButtonStyle) {
    ButtonStyleImageTopTitleBottom, // image在上，label在下
    ButtonStyleImageLeftTitleRight, // image在左，label在右
    ButtonStyleImageBottomTitleTop, // image在下，label在上
    ButtonStyleImageRightTitleLeft // image在右，label在左
};
@interface UIButton (Style)
- (void)layoutButtonWithButtonStyle:(ButtonStyle)style imageTitleSpace:(CGFloat)space;
@end
