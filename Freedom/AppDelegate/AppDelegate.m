//
//  AppDelegate.m
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import "AppDelegate.h"
#import "CTabbarController.h"
#import "FDBaseViewController.h"
#import "FDBaseNavController.h"
#import "FDPaletteViewController.h"
#import "FDThemeViewController.h"
#import "FDMusicViewController.h"
#import "FDSpeedViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self setRootViewController];
    return YES;
}


- (void)setRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSArray *itemTitles = @[@"", @"", @"", @""];
    CTabbarController *root = [[CTabbarController alloc] init];
    for (int i = 0; i < itemTitles.count; i++) {
        FDBaseViewController *vc;
        if (i == 0) {
            vc = [[FDSpeedViewController alloc] init];
        }else if (i ==1 ) {
            vc = [[FDThemeViewController alloc] init];
        }else if (i ==2 ) {
            vc = [[FDMusicViewController alloc] init];
        }else{
            vc = [[FDSpeedViewController alloc] init];
        }
        FDBaseNavController *nav = [[FDBaseNavController alloc] initWithRootViewController:vc];
        if (i < itemTitles.count) {
            vc.title = itemTitles[i];
        }
        [root cAddChildViewController:nav];
    }
    root.cTabBar.tabBarItemsArray = itemTitles;
    root.cTabBar.tabBarItemsImageSelectedArray = @[@"tabbar_palette_select", @"tabbar_theme_select", @"tabbar_music_select", @"tabbar_speed_select"];
    root.cTabBar.tabBarItemsImageArray = @[@"tabbar_palette_noselect", @"tabbar_theme_noselect", @"tabbar_music_noselect", @"tabbar_speed_noselect"];
    root.cTabBar.backgroundImage = [UIImage imageNamed:@"tabbarImg"];
//    root.cTabBar.barTintColor = Color_FFFFFF;
    [root.cTabBar setTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} state:UIControlStateSelected];

    root.cTabBar.offset = UIOffsetMake(0, -20);
    self.window.rootViewController = root;
    self.window.backgroundColor = Color_FFFFFF;
    [self.window makeKeyAndVisible];
}

/** 图片圆角 */
+ (UIImage *)imageByCornerRadiusWithImage:(UIImage *)image radius:(CGFloat)radius {
    CGSize size = image.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height)
                                cornerRadius:radius] addClip];
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *finalImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImg;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:^(){
       }];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {

//    [[LocalArchiverManager shareManage] clearArchiverData];
}


@end
