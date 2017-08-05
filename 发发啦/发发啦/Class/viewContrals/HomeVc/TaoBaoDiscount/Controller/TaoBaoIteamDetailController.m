//
//  TaoBaoIteamDetailController.m
//  发发啦
//
//  Created by gxtc on 2017/8/5.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "TaoBaoIteamDetailController.h"
#import "TaoBaoListDetailCell.h"
#import "NetWork.h"
#import "MBProgressHUD.h"
#import "HeadScrolADlView.h"

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self

@interface TaoBaoIteamDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)UIView * footView;
@property (nonatomic,strong)NetWork * net;

@property (nonatomic,strong)MBProgressHUD * hud;

@end

@implementation TaoBaoIteamDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self tableViewInit];
    
    [self addButtons];
    
    [self getIteamDetailWithID:self._id];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.hud hideAnimated:YES];
}


#pragma mark- 获取商品详情
- (void)getIteamDetailWithID:(NSString *)_id{
    WEAK_SELF;

    [self.net getTaoBaoDiscountListDetailDataWithID:self._id];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.hud = hud;
    
    self.net.taoBaoDiscountListDetailBk = ^(NSString *code, NSString *message, NSString *str, NSArray * arr1, NSArray *arr2) {
        
        [hud hideAnimated:YES];
        
        if (arr1.count > 0) {
            
            weakSelf.model = arr1[0];
            
            
            [weakSelf.tableView reloadData];
        }
    };
    
}

- (NetWork *)net{

    if (!_net) {
        
        _net = [[NetWork alloc]init];
    }
    return _net;
}


- (void)addButtons{

    UIButton * shareBt = [self addButton:CGRectMake(0, ScreenHeight - ScreenWith/8, ScreenWith/2, ScreenWith/8) bgColor:[UIColor orangeColor] andTitle:@"分享商品" titleFont:17.0 ];
    [self.view addSubview:shareBt];
    
    
    UIButton * fiftyMoney = [self addButton:CGRectMake(ScreenWith/2, ScreenHeight - ScreenWith/8, ScreenWith/2, ScreenWith/8) bgColor:[UIColor redColor] andTitle:@"领优惠券" titleFont:17.0];
    [self.view addSubview:fiftyMoney];
    
    
    
    UIButton * popBt = [self addButton:CGRectMake(10, 30, 40, 40) bgColor:[UIColor blackColor] andTitle:@"←_←" titleFont:17.0];
    popBt.layer.cornerRadius = 20.0;
    popBt.clipsToBounds = YES;
    [self.view addSubview:popBt];
    
    
    [shareBt addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [fiftyMoney addTarget:self action:@selector(fiftyMoneyAction) forControlEvents:UIControlEventTouchUpInside];
    [popBt addTarget:self action:@selector(popBtAction) forControlEvents:UIControlEventTouchUpInside];

}


- (void)popBtAction{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction{

    NSLog(@"分享商品");

}


- (void)fiftyMoneyAction{

    NSLog(@"领50元优惠券");

}


- (void)tableViewInit{

    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenWith)];
    
    head.backgroundColor = [UIColor redColor];
    
    self.tableView.tableHeaderView = head;
    
    self.tableView.tableFooterView = self.footView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return ScreenWith/4;
    }else{
    
        return ScreenWith/10;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1) {
        
        
        NSLog(@"唤起淘宝");
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        TaoBaoListDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        if (cell == nil) {
        
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TaoBaoListDetailCell" owner:self options:nil]firstObject];
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
    
        
        cell.model = self.model;
        
        return cell;
    
    }else{
    
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        if (cell == nil) {
            
            cell =[[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = @"查看更多宝贝详情";
        
        return cell;
    }
    
}

- (UIView *)footView{

    if (!_footView) {
        
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenWith/10)];
        _footView.backgroundColor = [UIColor lightGrayColor];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, ScreenWith, ScreenWith/10-1)];
        label.text = @"——————精品推荐——————";
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:13.0];
        
        [_footView addSubview:label];
    }
    return _footView;
}



- (UIButton *)addButton:(CGRect )frame bgColor:(UIColor *)bgColor andTitle:(NSString *)title titleFont:(CGFloat)font{

    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt .frame = frame;
    bt.backgroundColor = bgColor;
    bt.titleLabel.font = [UIFont systemFontOfSize:font];
    [bt setTitle:title forState:UIControlStateNormal];
    return bt;
}

@end
