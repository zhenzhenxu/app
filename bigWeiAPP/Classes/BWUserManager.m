//
//  BWUserManager.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/14.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "BWUserManager.h"

@implementation BWUserManager
+ (BWUserManager *)sharedInstance{

    static dispatch_once_t once;
    static BWUserManager *sharedInstance;
    
    dispatch_once(&once, ^{
        
        sharedInstance = [[BWUserManager alloc]init];
        [sharedInstance loadData];
    });
    
    return sharedInstance;
}
- (BOOL)LoginStatus{

    if (self.userModel) {
    
        return YES;
    }

    return NO;
}

- (void)setLoginStatus:(BOOL)loginStatus {
    if (loginStatus) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kUserDidLoginNotification object:nil];
    }else {
        self.userModel = nil;
        [[NSNotificationCenter defaultCenter]postNotificationName:kUserDidLogoutNotification object:nil];
    }
}

- (void)setUserModel:(BWUserModel *)userModel {
    _userModel = userModel;
    [self saveData];
}

#pragma mark -保存到偏好设置中
- (void)saveData {
    NSString *json = [self.userModel mj_JSONString];
    [[NSUserDefaults standardUserDefaults]setValue:json forKey:@"user_model_key"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)loadData {
    NSString *json = [[NSUserDefaults standardUserDefaults]valueForKey:@"user_model_key"];
    if (json) {
        self.userModel = [BWUserModel mj_objectWithKeyValues:json];
    }
}
@end
