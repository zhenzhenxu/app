//
//  BWLoginDataManager.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/15.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "BWLoginDataManager.h"
#import "BWUserManager.h"
@implementation BWLoginDataManager
+ (BWLoginDataManager *)sharedInstance{
    
    static BWLoginDataManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BWLoginDataManager alloc]init];
    });
    return sharedInstance;
}



+ (void)loginWithName:(NSString *)name password:(NSString *)password completeBlock:(void (^)(NSError *))completeBlock{

    
    
    [BWNetworkTools requestWithType:RequestMethodTypePost url:nil parameters:nil onSuccess:^(id jsonData) {

   
        BWUserModel *model = [BWUserModel mj_objectWithKeyValues:jsonData];
         [BWUserManager sharedInstance].userModel  = model;
        [BWUserManager sharedInstance].loginStatus = YES;
        BLOCK_EXEC(completeBlock,nil);
    } onFailure:^(NSError *error) {
        
        BLOCK_EXEC(completeBlock,error);
    }];

}
@end
