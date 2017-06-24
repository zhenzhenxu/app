//
//  FrameworkDelegate.h
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/21.
//  Copyright © 2017年 大有所为. All rights reserved.
//应用启动时  第三方框架的一些配置工作

#import <Foundation/Foundation.h>

@interface FrameworkDelegate : NSObject
@property (nonatomic, assign, readonly) NetworkStatus networkStatus;

- (instancetype)initWithOptions:(NSDictionary *)launchOptions;

- (void)configFrameworks;

#pragma mark - JPush
- (void)registerDeviceToken:(NSData *)data;
- (void)handleRemoteNotification:(NSDictionary *)userInfo;
- (void)showRemoteNotificationInActive:(NSDictionary *)userInfo;
- (void)resetBadge;
@end
