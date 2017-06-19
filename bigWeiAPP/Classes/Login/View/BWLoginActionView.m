//
//  BWLoginActionView.m
//  bigWeiAPP
//
//  Created by 大有所为 on 2017/6/19.
//  Copyright © 2017年 大有所为. All rights reserved.
//

#import "BWLoginActionView.h"

@implementation BWLoginActionView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    UIButton *btn = [[UIButton alloc]init];
    UIImage *image = [UIImage imageWithColor:[UIColor blueColor]];
    UIImage *highlightImage = [UIImage imageWithColor:[UIColor greenColor]];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
  

}
@end
