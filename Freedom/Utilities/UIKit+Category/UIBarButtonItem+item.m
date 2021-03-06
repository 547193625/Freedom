//
//  UIBarButtonItem+item.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //包装到View里面
    UIView *contentView = [[UIView alloc] initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,35,40)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //包装到View里面
    UIView *contentView = [[UIView alloc] initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}
+ (UIBarButtonItem *)itemWithImages:(UIImage *)images selImages:(UIImage *)selImages target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,48,48)];
    [btn setImage:images forState:UIControlStateNormal];
    [btn setImage:selImages forState:UIControlStateSelected];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //包装到View里面
    UIView *contentView = [[UIView alloc] initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title selTitle:(NSString *)selTitle titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor  target:(id)target action:(SEL)action {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,35,44)];
    btn.backgroundColor = backgroundColor;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selTitle forState:UIControlStateSelected];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //包装到View里面
    UIView *contentView = [[UIView alloc] initWithFrame:btn.bounds];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

@end
