//
//  FDSideMenuTitleView.h
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FDSideMenuTitleView;

@protocol FDSideMenuTitleViewDelegate <NSObject>

@optional

// 开启/关闭
- (void)menuTitleView:(FDSideMenuTitleView *)menuTitleView openSwitch:(UISwitch *)openSwitch;

@end

@interface FDSideMenuTitleView : UIView


@property (nonatomic, weak) id <FDSideMenuTitleViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title IsHidden:(BOOL)isHidden;

@end

NS_ASSUME_NONNULL_END
