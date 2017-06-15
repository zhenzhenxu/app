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

@end
