//
//  InComeRankView.m
//  cellDemo
//
//  Created by gxtc on 16/8/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "InComeRankView.h"
#import "InComeRanKCell.h"
#import "NetWork.h"
#import "MJRefresh.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface InComeRankView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UIView * navView;

@property(nonatomic,strong)NetWork * net;
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,assign)BOOL isRefrush;

@end

@implementation InComeRankView


- (void)initCreat:(MBProgressHUD *)hud{
    
    
    [self navViewCreat];
    [self tableviewCreat];

    [self getData:hud];
 }


- (void)getData:(MBProgressHUD *)hud{

    if ( self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    [self.net userInComeRankDataSourceFromNet];
    
    __weak InComeRankView * weakSelf = self;
    
    self.net.incomeRankBlock=^(NSArray * array){
        
        if (!weakSelf.isRefrush) {
            
            [hud hideAnimated:YES];
            
        }
        weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
    };


}



- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self addSubview:button];
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"收入榜";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}


- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 2000) {
        NSLog(@"2000");
    }else if (button.tag == 2001){
        NSLog(@"2001");
        
    }else if (button.tag == 2002){
        NSLog(@"2002");
        
    }else if (button.tag == 2003){
        NSLog(@"2003");
        
    }else if (button.tag == 2004){
        NSLog(@"2004");
        
    }else if (button.tag == 2005){
        NSLog(@"2005");
        
    }else if (button.tag == 3000){
        NSLog(@"3000");
        self.incomeBlock();
    }
    
}

- (void)tableviewCreat{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H -64) style:UITableViewStylePlain];
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:_tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData:)];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    InComeRanKCell * cell = [tableView dequeueReusableCellWithIdentifier:@"inComeCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InComeRanKCell" owner:self options:nil]firstObject];
    }
    
    cell.model = self.dataArray[indexPath.row];
    cell.rankNumberLabel.text = [NSString stringWithFormat:@"NO.%ld",indexPath.row + 1];
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    NSLog(@"lalalaalal");
    self.isRefrush = YES;

}


@end
