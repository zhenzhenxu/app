//
//  SSKeychain+BWUtil.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/16.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "SSKeychain+BWUtil.h"

@implementation SSKeychain (BWUtil)
+ (NSString *)rawLogin {
    return [[NSUserDefaults standardUserDefaults] objectForKey:BW_RAW_LOGIN];
}

+ (NSString *)password {
    return [self passwordForService:BW_SERVICE_NAME account:BW_PASSWORD];
}

+ (NSString *)accessToken {
    return [self passwordForService:BW_SERVICE_NAME account:BW_ACCESS_TOKEN];
}

+ (BOOL)setRawLogin:(NSString *)rawLogin {
    if (rawLogin == nil) NSLog(@"+setRawLogin: %@", rawLogin);
    
    [[NSUserDefaults standardUserDefaults] setObject:rawLogin forKey:BW_RAW_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (BOOL)setPassword:(NSString *)password {
    return [self setPassword:password forService:BW_SERVICE_NAME account:BW_PASSWORD];
}

+ (BOOL)setAccessToken:(NSString *)accessToken {
    return [self setPassword:accessToken forService:BW_SERVICE_NAME account:BW_ACCESS_TOKEN];
}

+ (BOOL)deleteRawLogin {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:BW_RAW_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (BOOL)deletePassword {
    return [self deletePasswordForService:BW_SERVICE_NAME account:BW_PASSWORD];
}

+ (BOOL)deleteAccessToken {
    return [self deletePasswordForService:BW_SERVICE_NAME account:BW_ACCESS_TOKEN];
}

@end
