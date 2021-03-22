//
//  UIBarButtonItem+item.h
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (item)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;


+ (UIBarButtonItem *)itemWithTitle:(NSString *)title selTitle:(NSString *)selTitle titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor  target:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
