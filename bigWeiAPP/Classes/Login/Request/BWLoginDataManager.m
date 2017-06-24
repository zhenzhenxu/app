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

    
    
    
   
       // NSString *pwd = [[password dataUsingEncoding:NSUTF8StringEncoding]base64EncodedStringWithOptions:0];
        

    //NSString *pwd = password;
    NSDictionary *param = @{
                             @"username": @"15357499859", @"password":@"251314"
                            };
    // URL: https://cloud.bigwei.com/bigweiCloud/mobile/admin/login
    [BWNetworkTools requestWithType:RequestMethodTypePost url:kInterfaceLogin parameters:param onSuccess:^(id jsonData) {
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
        
   
        BWUserModel *model = [BWUserModel mj_objectWithKeyValues:jsonData[@"data"]];
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
