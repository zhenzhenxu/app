//
//  BaseViewController.h
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/13.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyView.h"
#import "ErrorView.h"
#import "DataErrorView.h"
@interface BaseViewController : UIViewController

/**
 *  内容为空/网络错误/数据错误界面
 */
@property (nonatomic, strong)EmptyView *emptyView;
@property (nonatomic, strong)ErrorView *errorView;
@property (nonatomic, strong)DataErrorView *dataErrorView;

// 提示
- (void)startLoading;
- (void)stopLoading;
- (void)showToast:(NSString *)text;


/**
 *  设置导航右端图片
 *
 *  @param imageName          普通状态图片
 *  @param highlightImageName 高亮状态图片
 */
- (void)setupRightWithImageNamed:(NSString *)imageName highlightImageNamed:(NSString *)highlightImageName;

/**
 *  设置导航左端为自定义view
 *
 *  @param view 自定义view
 */
- (void)setupLeftWithCustomView:(UIView *)view;

/**
 *  点击右端图片的事件响应，子类需要自己实现
 */
- (void)naviRightAction;

/**
 *  设置导航右端为自定义view
 *
 *  @param view 自定义view
 */
- (void)setupRightWithCustomView:(UIView *)view;

/**
 *  设置导航右端为文字
 *
 *  @param title 文字内容
 */
- (void)setupRightWithTitle:(NSString *)title;

/**
 *  设置导航左端图片
 *
 *  @param imageName          普通状态图片
 *  @param highlightImageName 高亮状态图片
 */
- (void)setupLeftWithImageNamed:(NSString *)imageName highlightImageNamed:(NSString *)highlightImageName;

/**
 *  返回动作,默认为 popViewControllerAnimated
 */
- (void)naviLeftAction;
// 设置返回按钮样式
- (void)setupLeftBack;



@end
