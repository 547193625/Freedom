//
//  AppDelegate.m
//  Freedom
//
//  Created by Andrew on 2021/1/19.
//

#import "AppDelegate.h"
#import "FDTabBarController.h"
#import "FDBaseNavController.h"
#import "FDSideMenuViewController.h"
#import "MMDrawerController.h"

@interface AppDelegate ()
@property (nonatomic, strong) MMDrawerController *drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [self configSideMenuVC];
    return YES;
}



-(void)configSideMenuVC{
    FDTabBarController *tabbarVC = [[FDTabBarController alloc] init];
    FDSideMenuViewController *menuVC = [[FDSideMenuViewController alloc] init];
    FDBaseNavController *menuNvaVC = [[FDBaseNavController alloc]initWithRootViewController:menuVC];

    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:tabbarVC  rightDrawerViewController:menuNvaVC];

    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningNavigationBar;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    self.drawerController.maximumRightDrawerWidth = kScreenWidth - 75;
    self.drawerController.showsShadow  = NO;
  
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:self.drawerController];
    [self.window makeKeyAndVisible];
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
