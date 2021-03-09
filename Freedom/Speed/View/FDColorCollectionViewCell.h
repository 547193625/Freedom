//
//  FDColorCollectionViewCell.h
//  Freedom
//
//  Created by Andrew on 2021/3/8.
//

#import <UIKit/UIKit.h>
#import "FDColorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FDColorCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) FDColorModel *colorModel;

-(void)updatColorModel:(FDColorModel *)colorModel;


@end

NS_ASSUME_NONNULL_END
