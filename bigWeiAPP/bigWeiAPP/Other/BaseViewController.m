//
//  BaseViewController.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/13.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "BaseViewController.h"
#import "NavigationBarController.h"
#import "YXPromtController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *vcArray = self.navigationController.viewControllers;
    if (!isEmpty(vcArray)) {
        if (vcArray[0] != self) {
            [self setupLeftBack];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.userInteractionEnabled = YES;
}

#pragma mark - Navi Left
- (void)setupLeftBack{
    [self setupLeftWithImageNamed:@"返回按钮" highlightImageNamed:@"返回按钮点击态"];
}

- (void)setupLeftWithImageNamed:(NSString *)imageName highlightImageNamed:(NSString *)highlightImageName{
    WEAK_SELF
    [NavigationBarController setLeftWithNavigationItem:self.navigationItem imageName:imageName highlightImageName:highlightImageName action:^{
        STRONG_SELF
        [self naviLeftAction];
    }];
}
- (void)naviLeftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupLeftWithCustomView:(UIView *)view{
    [NavigationBarController setLeftWithNavigationItem:self.navigationItem customView:view];
}

#pragma mark - Navi Right
- (void)setupRightWithImageNamed:(NSString *)imageName highlightImageNamed:(NSString *)highlightImageName{
    WEAK_SELF
    [NavigationBarController setRightWithNavigationItem:self.navigationItem imageName:imageName highlightImageName:highlightImageName action:^{
        STRONG_SELF
        [self naviRightAction];
    }];
}

- (void)setupRightWithCustomView:(UIView *)view{
    [NavigationBarController setRightWithNavigationItem:self.navigationItem customView:view];
}

- (void)setupRightWithTitle:(NSString *)title{
    WEAK_SELF
    [NavigationBarController setRightWithNavigationItem:self.navigationItem title:title action:^{
        STRONG_SELF
        [self naviRightAction];
    }];
}

- (void)naviRightAction{
    
}

#pragma mark - 网络提示
- (void)startLoading{
    [NavigationBarController disableRightNavigationItem:self.navigationItem];
    [YXPromtController startLoadingInView:self.view];
}

- (void)stopLoading{
    [NavigationBarController enableRightNavigationItem:self.navigationItem];
    [YXPromtController stopLoadingInView:self.view];
}

- (void)showToast:(NSString *)text{
    [YXPromtController showToast:text inView:self.view];
}



#pragma mark - 网络数据处理
- (BOOL)handleRequestData:(UnhandledRequestData *)data {
    return [self handleRequestData:data inView:self.view];
}
- (BOOL)handleRequestData:(UnhandledRequestData *)data inView:(UIView *)view {
    [self.emptyView removeFromSuperview];
    [self.errorView removeFromSuperview];
    [self.dataErrorView removeFromSuperview];
    
    BOOL handled = NO;
    if (data.error) {
        if (data.localDataExist) {
            [YXPromtController showToast:data.error.localizedDescription inView:view];
        }else {
            if (data.error.code == ASIConnectionFailureErrorType || data.error.code == ASIRequestTimedOutErrorType) {//网络错误/请求超时
                [view addSubview:self.errorView];
                [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(0);
                }];
            }else {
                [view addSubview:self.dataErrorView];
                [self.dataErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(0);
                }];
            }
        }
        handled = YES;
    }else {
        if (!data.requestDataExist) {
            [view addSubview:self.emptyView];
            [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            handled = YES;
        }
    }
    return handled;
    
}
@end
