//
//  readEarnView.m
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "readEarnView.h"
#import "oneTypeCell.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface readEarnView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView * navView;
@property(nonatomic,strong)oneTypeCell * oneCell;
@property(nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSMutableArray * imgArray;
@property (nonatomic,strong)NSMutableArray * titleArray;

@end

@implementation readEarnView

- (void)initCreat{
 
    NSArray * titleArray = @[@"美食专区",@"健康养生",@"美女图集",@"搞笑频道"];
    NSArray * imgArray = @[@"food.png",@"food2.png",@"girl.png",@"dog.png"];
    
    
    self.imgArray = [NSMutableArray arrayWithArray:imgArray];
    self.titleArray = [NSMutableArray arrayWithArray:titleArray];
    
    [self navViewCreat];
    [self tableViewCreat];
    
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
    titleLabel.text = @"阅读赚钱";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
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
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _oneCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_oneCell == nil) {
        _oneCell = [[[NSBundle mainBundle]loadNibNamed:@"oneTypeCell" owner:self options:nil]firstObject];
    }
    
    _oneCell.imgView.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
    _oneCell.titleLabel.text = self.titleArray[indexPath.row];
    _oneCell.titleLabel2.text = self.titleArray[indexPath.row];
    
    return _oneCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger index = indexPath.row;
    NSLog(@"选择了=> %ld",index);
    
    NSInteger page = index;
    
    if (index == 3) {
        page++;
    }
    self.toWebView(self.titleArray[index],page);
    
}

@end
