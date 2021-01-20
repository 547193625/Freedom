//
//  NSObject+RadiuView.h
//  Freedom
//
//  Created by Andrew on 2021/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RadiuView)

+(void)addCornerRadiu:(UIView *)view cornerWith:(float)width borderWidth:(float)borderWidth color:(UIColor *)color;

+(void)addCornerRadiu:(UIView *)view cornerWith:(float)width;

@end

NS_ASSUME_NONNULL_END
