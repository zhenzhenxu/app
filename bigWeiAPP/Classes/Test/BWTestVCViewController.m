//
//  BWTestVCViewController.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/16.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "BWTestVCViewController.h"
#import "BWUserManager.h"
@interface BWTestVCViewController ()

@end

@implementation BWTestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self getCurrentMonthForDays];
    self.view.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40, 50, 50, 50)];
    btn.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    [self.view addSubview:btn];
    btn.title = @"退出";
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [BWUserManager sharedInstance].loginStatus = NO;
    
        }];
    
    
    self.view.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(140, 150, 50, 50)];
    btn2.backgroundColor =  [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    [self.view addSubview:btn2];
    btn2.title = @"跳转";
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
     BWTestVCViewController *vc =   [[BWTestVCViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calendar{

    // 可指定日历的算法
//    NSCalendar  * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    // currentCalendar取得的值会一直保持在cache中,第一次取得以后如果用户修改该系统日历设定，这个值也不会改变。
////    NSCalendar  * calendar = [NSCalendar currentCalendar];
//    //如果用autoupdatingCurrentCalendar，那么每次取得的值都会是当前系统设置的日历的值。
//    NSCalendar  * autoupdatingCurrent = [NSCalendar autoupdatingCurrentCalendar];
//    //- initWithCalendarIdentifier:
//    //如果想要用公历的时候，就要将NSDateFormatter的日历设置成公历。否则随着用户的系统设置的改变，取得的日期的格式也会不一样。
//    NSCalendar *initCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setCalendar:initCalendar];


}
-(NSInteger)getCurrentMonthForDays{
    // 创建一个日期类对象(当前月的calendar对象)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSRange是一个结构体，其中location是一个以0为开始的index，length是表示对象的长度。他们都是NSUInteger类型。
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}


@end
