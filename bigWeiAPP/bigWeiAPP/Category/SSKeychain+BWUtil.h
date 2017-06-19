//
//  SSKeychain+BWUtil.h
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/16.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import <SSKeychain/SSKeychain.h>

@interface SSKeychain (BWUtil)
+ (NSString *)rawLogin;
+ (NSString *)password;
+ (NSString *)accessToken;

+ (BOOL)setRawLogin:(NSString *)rawLogin;
+ (BOOL)setPassword:(NSString *)password;
+ (BOOL)setAccessToken:(NSString *)accessToken;

+ (BOOL)deleteRawLogin;
+ (BOOL)deletePassword;
+ (BOOL)deleteAccessToken;
@end
