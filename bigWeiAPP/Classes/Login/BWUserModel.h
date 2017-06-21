//
//  BWUserModel.h
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/14.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWUserModel : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *pwd;
@property (nonatomic, strong) NSString *token;
@end
