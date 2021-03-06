//
//  BRTabBarController.m
//  Freedom
//
//  Created by Andrew on 2021/3/6.
//

#import "FDTabBarController.h"
#import "FDBaseNavController.h"
#import "FDPaletteViewController.h"
#import "FDThemeViewController.h"
#import "FDMusicViewController.h"
#import "FDSpeedViewController.h"

#define kClassKey @"classKey"
#define kClassTitleKey @"classTitleKey"
#define kClassImageKey @"classImageKey"
#define kClassSelectImageKey @"classSelectImageKey"

@interface FDTabBarController ()<UITabBarDelegate>
@property (nonatomic, assign) NSInteger indexFlag;
@end

@implementation FDTabBarController

static dispatch_once_t onceToken = 0;
static FDTabBarController *tabBarVC = nil;

+(instancetype)sharedInstance{
    dispatch_once(&onceToken, ^{
        tabBarVC = [[FDTabBarController alloc] init];
    });
    
    return tabBarVC;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.indexFlag = 0;
    
    self.tabBarController.tabBar.delegate = self;
    
    if (@available(iOS 13.0, *)) { // 解决选中颜色变蓝色问题
        [UITabBar appearance].tintColor = Color_649CF0;
    }

    [UITabBar appearance].translucent = NO;
    
    NSArray *childArray = @[
                        @{
                            kClassKey : @"FDSpeedViewController",
                            kClassTitleKey : @"调色板",
                            kClassImageKey : @"tabbar_palette_noselect",
                            kClassSelectImageKey : @"tabbar_palette_select"
                            },
                            @{
                                kClassKey : @"FDThemeViewController",
                                kClassTitleKey : @"主题",
                                kClassImageKey : @"tabbar_theme_noselect",
                                kClassSelectImageKey : @"tabbar_theme_select"
                                },

                            @{
                                kClassKey : @"FDMusicViewController",
                                kClassTitleKey : @"音乐",
                                kClassImageKey : @"tabbar_music_noselect",
                                kClassSelectImageKey : @"tabbar_music_select"
                                },
                            @{
                                kClassKey :@"FDSpeedViewController",
                                kClassTitleKey : @"速度",
                                kClassImageKey : @"tabbar_speed_noselect",
                                kClassSelectImageKey : @"tabbar_speed_select"
                                }
                            ];
    
    [childArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict = obj;
        UIViewController *childCtrl = [[NSClassFromString(dict[kClassKey]) alloc] init];
        FDBaseNavController *nav = [[FDBaseNavController alloc] initWithRootViewController:childCtrl];
        UITabBarItem *tabBarItem = nav.tabBarItem;
        tabBarItem.title = dict[kClassTitleKey];
        tabBarItem.image = [UIImage imageNamed:dict[kClassImageKey]];
        tabBarItem.selectedImage = [[UIImage imageNamed:dict[kClassSelectImageKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:Font_10,NSForegroundColorAttributeName:Color_999999} forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:Font_10,NSForegroundColorAttributeName:Color_649CF0} forState:UIControlStateSelected];
        
//        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
        
        [self addChildViewController:nav];
    }];
    

}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    /** 给 tabBarButton 加动画 */
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [arry addObject:btn];
            }
        }
        //添加动画
        [self addScaleAnimtaionWithArr:arry index:index];
        
        self.indexFlag = index;
    }
    
}

#pragma mark - More Animation

// 先放大，再缩小
- (void)addScaleAnimtaionWithArr:(NSMutableArray *)arry index:(NSInteger)index
{
    //放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.8];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.2];     //结束伸缩倍数
    UIView *view = arry[index];
    [[view layer] addAnimation:animation forKey:nil];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
