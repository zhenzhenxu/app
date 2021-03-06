//
//  AppDelegate.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/12.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "AppDelegate.h"
#import "FrameworkDelegate.h"
#import "BWLoginController.h"
#import "BWTabBarController.h"
#import "BWUserManager.h"
#import "BWNavigationController.h"


@interface AppDelegate ()
@property(nonatomic, strong) FrameworkDelegate *frameworkDelegate;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /* 第三方框架配置 */
    self.frameworkDelegate = [[FrameworkDelegate alloc] initWithOptions:launchOptions];
    [self.frameworkDelegate configFrameworks];
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self registerNotifications];
    [self setupUI];
    [self.window makeKeyAndVisible];

  
    
    return YES;
}


- (void)setupUI{
    
    
    [self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
    
    if ([BWUserManager sharedInstance].loginStatus) {
            BWTabBarController *tabVC =[[BWTabBarController alloc]init];
            self.window.rootViewController = tabVC;
    
    
        }else{
           /*  登录界面 */

            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"BWLoginController" bundle:nil]; //加载箭头指向的viewController
            BWLoginController *loginVC = [storyboard instantiateInitialViewController];
            
            BWNavigationController *loginNavi = [[BWNavigationController alloc]initWithRootViewController:loginVC];
            if (self.window.rootViewController) {
                [self.window.rootViewController presentViewController:loginNavi animated:YES completion:^{
                    self.window.rootViewController.view.hidden = YES;
                }];
            }else {
                self.window.rootViewController = loginNavi;
            }
        }
    
    
    
    
}


- (void)registerNotifications{
    WEAK_SELF
        [[[NSNotificationCenter defaultCenter]rac_addObserverForName:kUserDidLoginNotification object:nil]subscribeNext:^(id x) {
            STRONG_SELF
            [self setupUI];
        }];
        [[[NSNotificationCenter defaultCenter]rac_addObserverForName:kUserDidLogoutNotification object:nil]subscribeNext:^(id x) {
           STRONG_SELF
            [self setupUI];
        }];
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
