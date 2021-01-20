//
//  UIImage+Extension.h
//  HomeStay
//
//  Created by Q房通 on 2017/11/29.
//  Copyright © 2017年 Q房通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 根据颜色生成图片 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)combineImage;

//是否有透明度
- (BOOL)hasAlpha;
//返回有透明度的图片
- (UIImage *)imageWithAlpha;
//图片边角设置遮罩图片
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
//圆角图片
- (UIImage *)createRoundedWithRadius:(CGFloat)radius;

//上传图片压缩
+ (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize andImage:(UIImage *)image;

//图片压缩
+ (UIImage *)zipImageWithURL:(NSString *)imageURL;

//压缩
+ (NSData *)imageWithImageData:(NSData *)imageData;

//拍照图片旋转
- (UIImage *)fixOrientation:(UIImage *)aImage;

/**
 *  获取矩形的渐变色的UIImage
 *
 *  @param bounds       UIImage的bounds
 *  @param colors       渐变色数组，可以设置两种颜色
 *  @param gradientType 渐变的方式：0--->从上到下   1--->从左到右
 *
 *  @return 渐变色的UIImage
 */
+ (UIImage*)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(int)gradientType;

@end








