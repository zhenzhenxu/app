//
//  BWNetworkTools.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/13.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "BWNetworkTools.h"

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
    manager.requestSerializer.timeoutInterval = 10.f;//设置请求超时的时间
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.removesKeysWithNullValues = YES;
    manager.responseSerializer = responseSerializer;
    NSLog(@"parameters:\n %@",parameters);
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
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
                
                if (successHandler) {
                    successHandler(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureHanler) {
                    failureHanler(error);
                }
                
            }];
            
        }
            break;
        default:
            break;
    }
    
    
    
    
}
@end
