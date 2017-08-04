//
//  TaoBaoDiscountController.m
//  发发啦
//
//  Created by gxtc on 2017/8/4.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "TaoBaoDiscountController.h"
#import "ListTableView.h"
#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self

@interface TaoBaoDiscountController ()

@property (nonatomic,strong)UIView * navView;

@end

@implementation TaoBaoDiscountController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.navView];
    
    ListTableView * view = [[ListTableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWith, ScreenHeight - 64)];
    
    [self.view addSubview:view];
    
}


- (UIView *)navView{
    if (!_navView) {
        
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, 64)];
        _navView.backgroundColor = [UIColor orangeColor];
        
        UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(5, 20, 60, 44);
        [bt setImage:[UIImage imageNamed:@"comm_icon_back_white"] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(popBackAction) forControlEvents:UIControlEventTouchUpInside];
        bt.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_navView addSubview:bt];
        
    }
    return _navView;
}

- (void)popBackAction{

    [self.navigationController popViewControllerAnimated:YES];
}
@end
