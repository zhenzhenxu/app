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

    
    
    
   
        NSString *pwd = [[password dataUsingEncoding:NSUTF8StringEncoding]base64EncodedStringWithOptions:0];
        

   
    NSDictionary *param = @{
                             @"UserID": name, @"Password": pwd
                            };
    
    [BWNetworkTools requestWithType:RequestMethodTypePost url:kInterfaceLogin parameters:param onSuccess:^(id jsonData) {

   
        BWUserModel *model = [BWUserModel mj_objectWithKeyValues:jsonData];
         [BWUserManager sharedInstance].userModel  = model;
        [BWUserManager sharedInstance].loginStatus = YES;
        BLOCK_EXEC(completeBlock,nil);
    } onFailure:^(NSError *error) {
        
        BLOCK_EXEC(completeBlock,error);
    }];

}

// base 64编码
- (NSString *)base64Encode:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}
@end
