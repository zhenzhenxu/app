//
//  BWLoginDataManager.h
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/15.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWLoginDataManager : NSObject

+ (BWLoginDataManager *)sharedInstance;
//用户名密码登录
+ (void)loginWithName:(NSString *)name password:(NSString *)password completeBlock:(void(^)(NSError *error))completeBlock;
@end
