//
//  BWUserModel.h
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/14.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {
 message = 登录成功;
 data = {
 username = 15357499859;
 multiCompany = 0;
 accessToken = 3373cf13f491352ea2c1ab6f6119a5aa;
 chatToken = ;
 }
 ;
 code = 200;
 }
 */
@interface BWUserModel : NSObject
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *pwd;
@property (nonatomic, strong) NSString *accessToken;
@end
