//
//  FrameworkDelegate.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/21.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "FrameworkDelegate.h"
//#import "UCSProgressHUD.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max

#import <UserNotifications/UserNotifications.h>

#endif

@interface FrameworkDelegate () <JPUSHRegisterDelegate>

@property(nonatomic, copy) NSDictionary *launchOptions;
@property(nonatomic, assign, readwrite) NetworkStatus networkStatus;

@property(nonatomic, strong) Reachability *reachability;

@property(nonatomic, strong) UIWindow *HUDWindow;


@end

@implementation FrameworkDelegate

- (instancetype)initWithOptions:(NSDictionary *)launchOptions {
    if (self = [super init]) {
        _launchOptions = [launchOptions copy];
    }
    return self;
}

- (void)configFrameworks {
    [self configureReachability];
    [self configAFNetworking];
    [self configIQKeyboardManager];
}


- (void)configureReachability {
    self.reachability = Reachability.reachabilityForInternetConnection;
    
    //    RAC(self, networkStatus) = [[[[[NSNotificationCenter defaultCenter]
    //                                                         rac_addObserverForName:kReachabilityChangedNotification object:nil]
    //                                                         map:^(NSNotification *notification) {
    //                                                             return @([notification.object currentReachabilityStatus]);
    //                                                         }]
    //                                                         startWith:@(self.reachability.currentReachabilityStatus)]
    //                                                         distinctUntilChanged];
    
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self)
        [self.reachability startNotifier];
    });
}

- (void)configAFNetworking {
    //AFNetworkActivityIndicatorManager 主要是用来设置状态栏处的网络标示
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

- (void)configIQKeyboardManager {
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

#pragma mark - JPush

- (void)configJPush {
    // APNs
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
#ifdef DEBUG
    BOOL isProduction = NO;
#else
    BOOL isProduction = YES;
#endif
    // JPush
    NSString *advertisingId = nil;
    [JPUSHService setupWithOption:self.launchOptions
                           appKey:BW_JPUSH_APPKEY
                          channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
}

- (void)registerDeviceToken:(NSData *)data {
    [JPUSHService registerDeviceToken:data];
}

- (void)handleRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    
}

// 程序激活状态时对远程推送的展示
- (void)showRemoteNotificationInActive:(NSDictionary *)userInfo {
    
    
}

- (void)resetBadge {
    [JPUSHService resetBadge];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

#pragma mark - JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
        willPresentNotification:(UNNotification *)notification
          withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [self showRemoteNotificationInActive:userInfo];
    }
    // 选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    completionHandler(0);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center
 didReceiveNotificationResponse:(UNNotificationResponse *)response
          withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [self handleRemoteNotification:userInfo];
    }
    completionHandler();
}
@end
