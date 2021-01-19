//
//  FDBaseViewController.h
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FDBaseViewController : UIViewController
@property (nonatomic,assign) NSInteger currentPage; //当前页



// 隐藏导航栏的底部线条
- (void)showLine;

// 显示导航栏的底部线条
- (void)hideLine;

//HUD
- (void)showLoading:(UIView *)view text:(NSString *)text;
- (void)hideLoading;
/*
 * 显示提醒信息，2S后自动隐藏
 * 所有HUD提示都用此函数，禁止自己定义MBHUD
 */
- (void)showToastText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
