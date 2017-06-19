//
//  BWUserManager.h
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/14.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWUserModel.h"
@interface BWUserManager : NSObject
+ (BWUserManager *)sharedInstance;


@property (nonatomic, assign) BOOL loginStatus;
@property (nonatomic, strong) BWUserModel *userModel;
@end
