//
//  NSObject+RadiuView.m
//  Freedom
//
//  Created by Andrew on 2021/1/20.
//

#import "NSObject+RadiuView.h"

@implementation NSObject (RadiuView)
+(void)addCornerRadiu:(UIView *)view cornerWith:(float)width borderWidth:(float)borderWidth color:(UIColor *)color
{
    view.layer.cornerRadius = width;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = color.CGColor;
}


+(void)addCornerRadiu:(UIView *)view cornerWith:(float)width
{
    view.layer.cornerRadius = width;
    view.layer.masksToBounds = YES;
}
@end
