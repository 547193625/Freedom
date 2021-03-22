//
//  FDThemeModel.h
//  Freedom
//
//  Created by Andrew on 2021/3/22.
//

#import <Foundation/Foundation.h>
#import "FDThemeColorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FDThemeModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) AAChartType hartType;

@property (nonatomic, strong) NSMutableArray <FDThemeColorModel *>*colorArray;

@end

NS_ASSUME_NONNULL_END
