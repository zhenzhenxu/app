//
//  BWLoginController.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/14.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "BWLoginController.h"
#import "BWTestVCViewController.h"
#import "BWLoginRequst.h"
#import "BWLoginDataManager.h"
@interface BWLoginController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;
@property (strong, nonatomic) NSMutableArray *data;


@end
/**
 * 随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
@implementation BWLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"login";
    [self test5];
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}
- (void)setupTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT - 64);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(64);
        
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _array = [NSMutableArray arrayWithObjects:@"数据1", @"数据2",nil];
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadNewData];
        
    }];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    // 马上进入刷新状态
   // [self.tableView.mj_header beginRefreshing];
}
#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:MJRandomData];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [tableView.mj_footer endRefreshing];
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", indexPath.row % 2?@"push":@"modal", self.data[indexPath.row]];
    
    return cell;
}
- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:MJRandomData];
        }
    }
    return _data;
}
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}
- (void)setupUI{



}
- (IBAction)loginBtnClick:(UIButton *)sender {
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];

    if (isEmpty(self.userName.text)) {
        [self showToast:@"请输入用户名"];
        return;
    }
    if (isEmpty(self.passWord.text)) {
        [self showToast:@"请输入密码"];
        return;
    }
    [self startLoading];
    WEAK_SELF
    [BWLoginDataManager loginWithName:self.userName.text password:self.passWord.text completeBlock:^(NSError *error) {
      STRONG_SELF
        [self stopLoading];
        if (error) {
            [self showToast:error.localizedDescription];

        }else{
            BWTestVCViewController *vc = [[BWTestVCViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:nil];
        
        }
    }];
    
}


-(void)test5{

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 50, 50, 50)];
    btn.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    [self.view addSubview:btn];
//    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
//        BWTestVCViewController *vc = [[BWTestVCViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:nil];
//       
//    }];
    [btn addTarget:self action:@selector(btncl)];
}
- (void)btncl{
    BWTestVCViewController *vc = [[BWTestVCViewController alloc]init];
    [self.navigationController pushViewController:vc animated:nil];

}
#pragma TEST
//-(void)test4{
//    self.errorView = [[ErrorView alloc]init];
//    [self.view addSubview:self.errorView];
//    [self.errorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
//    @weakify(self);
//    [self.errorView setRetryBlock:^{
//        @strongify(self); if (!self) return;
//        [self startLoading];
//    }];
//
//}
//- (void)test3{
//    self.emptyView = [[EmptyView alloc]init];
//    [self.view addSubview:self.emptyView];
//    self.emptyView.title = @"xxxxxxxx";
//    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//        
//    }];
//}
//- (void)test{
//    self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
//    [self startLoading];
//    
//    WEAK_SELF
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        STRONG_SELF
//        [self stopLoading];
//        
//        
//    });
//    
//    
//    
//    
//}
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
