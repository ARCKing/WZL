//
//  shareEarnView.m
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "shareEarnView.h"
#import "oneTypeCell.h"
#import "NetWork.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface shareEarnView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView * navView;
@property(nonatomic,strong)oneTypeCell * oneCell;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;
@end
@implementation shareEarnView

- (void)initCreat{
    self.dataArray = [NSArray new];
    [self navViewCreat];
    [self tableViewCreat];
    [self getDataFromNet];
}


#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"享立赚";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}



#pragma mark- 数据网络请求
- (void)getDataFromNet{

    NetWork * net =[[NetWork alloc]init];
    
    [net shareEarn];
    
    __weak shareEarnView * weakSelf = self;
    
    net.shareEarnBlock=^(NSArray * array){
    
        weakSelf.dataArray = [NSArray arrayWithArray:array];
    
        [self.tableView reloadData];
    };

}

#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 5000) {
        NSLog(@"5000");
    }else if (button.tag == 5001){
        NSLog(@"5001");
    }else if (button.tag == 5002){
        NSLog(@"5002");
    }else if (button.tag == 3000){
        NSLog(@"3000");
        
        self.backBlock();
        
    }else if (button.tag == 9900) {
        NSLog(@"9900");
        
    }
    
}

#pragma mark- tableViewCreat
- (void)tableViewCreat{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    [self addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_W/5;
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_oneCell == nil) {
        _oneCell = [[[NSBundle mainBundle]loadNibNamed:@"oneTypeCell" owner:self options:nil]firstObject];
    }
    
    _oneCell.model = self.dataArray[indexPath.row];
    
    return _oneCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"选择了 = > %ld",indexPath.row);
    
    shareEarnModel * model = self.dataArray[indexPath.row];
    
    self.shareEarnDetail(model);
    
    
}


@end
