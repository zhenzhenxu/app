//
//  BWLoginController.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/14.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "BWLoginController.h"

@interface BWLoginController ()

@end

@implementation BWLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor redColor];
    [self test3];
    


}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}


#pragma TEST
-(void)test4{
    self.errorView = [[ErrorView alloc]init];
    [self.view addSubview:self.errorView];
    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        
    }];
    @weakify(self);
    [self.errorView setRetryBlock:^{
        @strongify(self); if (!self) return;
        [self startLoading];
    }];

}
- (void)test3{
    self.emptyView = [[EmptyView alloc]init];
    [self.view addSubview:self.emptyView];
    self.emptyView.title = @"xxxxxxxx";
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        
    }];
}
- (void)test{
    self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    [self startLoading];
    
    WEAK_SELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STRONG_SELF
        [self stopLoading];
        
        
    });
    
    
    
    
}

- (void)test2{

    UITextField *testfield = [[UITextField alloc]init];
    [self.view addSubview:testfield];
    [testfield mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.center.mas_equalTo(self.view.center);
        make.width.mas_equalTo(60);
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(40);
    }];
    
    testfield.placeholder = @"我是特效hgahihgahgoa";
    
    UITextField *testfield2 = [[UITextField alloc]init];
    [self.view addSubview:testfield2];
    [testfield2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.center.mas_equalTo(self.view.center);
        make.width.mas_equalTo(160);
        make.left.mas_equalTo(40);
        make.bottom.mas_equalTo(-30);
    }];
    
    testfield2.placeholder = @"我是ssss是多少";
    testfield.textColor = [UIColor blackColor];
    [[testfield rac_signalForControlEvents:UIControlEventEditingChanged]subscribeNext:^(id x) {
        NSLog(@"点击。。。。。。。");
        
    }];
    [[testfield2 rac_textSignal]subscribeNext:^(id x) {
        NSLog(@"88888888");
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"tap");
    }];
    [self.view addGestureRecognizer:tap];
}

@end
