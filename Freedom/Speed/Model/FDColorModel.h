//
//  FDColorModel.h
//  Freedom
//
//  Created by Andrew on 2021/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDColorModel : NSObject
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, assign) NSInteger item;
@end

NS_ASSUME_NONNULL_END
