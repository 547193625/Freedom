//
//  UIImage+ColorSelect.h
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ColorSelect)

- (UIColor *)colorAtPixel:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
