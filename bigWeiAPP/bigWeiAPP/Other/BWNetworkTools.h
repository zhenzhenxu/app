//
//  BWNetworkTools.h
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/13.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2
};



typedef void(^SuccessHandler)(id jsonData);
typedef void(^FailureHandler)(NSError *error);
@interface BWNetworkTools : NSObject


/**
 *  发送一个请求
 *
 *  @param type    请求类型,POST or GET
 *  @param url     路径
 *  @param parameters  参数
 *  @param successHandler 成功回调
 *  @param failureHanler  失败回调
 */

+ (void)requestWithType:(RequestMethodType)type
                    url:(NSString *)url
             parameters:(NSDictionary *)parameters
              onSuccess:(SuccessHandler)successHandler
              onFailure:(FailureHandler)failureHanler;
@end
