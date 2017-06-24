//
//  BWNetworkTools.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/13.
//  Copyright © 2017年 大有所为. All rights reserved.
//
#import "NSArray+Log.h"
#import "BWNetworkTools.h"
@interface BWNetworkTools()

@end

@implementation BWNetworkTools

/**
 *  发送一个请求
 *
 *  @param type    请求类型,POST or GET
 *  @param url     路径
 *  @param parameters  参数
 *  @param successHandler 成功回调
 *  @param failureHanler  失败回调
 */

+ (void)requestWithType:(RequestMethodType)type url:(NSString *)url parameters:(NSDictionary *)parameters onSuccess:(SuccessHandler)successHandler onFailure:(FailureHandler)failureHanler{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.f;

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    
   
    
 
    NSLog(@"parameters:\n %@",parameters);
    
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     urlStr = [NSString stringWithFormat:@"%@%@", kHttpIPAddress, urlStr];
    switch (type) {
        case RequestMethodTypeGet:
        {
            
            [manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:nil];
                if (successHandler) {
                    successHandler(responseDict);
                }
              //  BLOCK_EXEC(successHandler,responseDict);
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                
                if (failureHanler) {
                    failureHanler(error);
                       
                }
                
            }];
            
        }
            break;
            
        case RequestMethodTypePost:
        {
            
            [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
                
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject
                                                                             options:NSJSONReadingMutableContainers
                                                                           error:nil];
                if (successHandler) {
                    successHandler(responseDict);
                }
                NSLog(@"---%@",responseDict);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureHanler) {
                    NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                    id body = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    NSLog(@"-------%@", body);
                    failureHanler(error);
                }
                
            }];
            
        }
            break;
        default:
            break;
    }
    
    
    
    
}
+ (void)cancelAllRequest{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];

}

@end
