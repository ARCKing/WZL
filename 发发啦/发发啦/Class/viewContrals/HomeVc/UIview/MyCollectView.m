//
//  MyCollectView.m
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "MyCollectView.h"
#import "NetWork.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#import "UIImageView+WebCache.h"
#import "typeOneCell.h"
@interface MyCollectView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)typeOneCell * cell;

@end

@implementation MyCollectView

- (void)initCreat:(MBProgressHUD *)hud{
    self.dataArray = [NSMutableArray new];
    [self dataMessageGetFromNet:hud];
    [self navViewCreat];
    [self tableviewCreat];
}

- (void)dataMessageGetFromNet:(MBProgressHUD *)hud{
    NetWork * net = [[NetWork alloc]init];
    [net userCollectionArticleShow];

    __weak MyCollectView * weakSelf = self;
    net.userArticleCollection=^(NSArray * array){
        
        [hud hideAnimated:YES];
        
        weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
        
        [self.tableView reloadData];
    };
    
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
#pragma mark- button.tag-9000
    button.tag = 9000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"我的收藏";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 40);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}


#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    if (button.tag == 9000) {
        NSLog(@"9000");
        self.backBlock();
    }

}


#pragma mark- tableViewCreat
- (void)tableviewCreat{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:_tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = SCREEN_W/4;
    self.tableView.tableFooterView = [[UIView alloc]init];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    self.cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.cell == nil) {
        self.cell = [[typeOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    userCollectionArticleModel * model = self.dataArray[indexPath.row];
    self.cell.model3 = model;
    
    return self.cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"我选了:%ld",indexPath.row);
    
    self.webBlock(self.dataArray[indexPath.row]);
    
}


@end
