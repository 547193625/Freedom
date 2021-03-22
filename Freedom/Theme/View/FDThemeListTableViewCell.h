//
//  FDThemeListTableViewCell.h
//  Freedom
//
//  Created by Andrew on 2021/3/22.
//

#import <UIKit/UIKit.h>
#import "FDThemeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FDThemeListTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *colorArray;

@property (nonatomic, strong) FDThemeModel *themeModel;

@end

NS_ASSUME_NONNULL_END
