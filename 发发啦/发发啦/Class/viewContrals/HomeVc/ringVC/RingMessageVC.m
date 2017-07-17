//
//  RingMessageVC.m
//  发发啦
//
//  Created by gxtc on 16/9/12.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "RingMessageVC.h"
#import "MessageCell.h"
#import "DetailMessageVC.h"
#import "systemMessageModel.h"
#import "NetWork.h"
#import "MJRefresh.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface RingMessageVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)MessageCell * cell;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataSourceArray;
@property(nonatomic,strong)UIView * navView;

@property(nonatomic,strong)NetWork * net;
@property(nonatomic,strong)NSMutableArray * dataMessage;

@property(nonatomic,assign)NSInteger page;
@end

@implementation RingMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataMessage = [[NSMutableArray alloc]init];
    
    [self systemMessageGetFromNet];
    
    [self navViewCreat];
    [self tableViewCreat];
}


#pragma mark- 网络请求
- (void)systemMessageGetFromNet{
 
    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
        
    }
    
    [self.net systemMessageGetFromNetWithPage:1];
    
    __weak RingMessageVC * weakSelf = self;
    self.net.systemMessage = ^(NSArray * array){
    
        [weakSelf.tableView.mj_header endRefreshing];
        
        weakSelf.dataMessage = [NSMutableArray arrayWithArray:array];
        
        [weakSelf.tableView reloadData];
    };
    
}

#pragma mark- 下拉刷新
- (void)MJRefreshDatas{

    self.page = 1;
    [self systemMessageGetFromNet];
    
}

#pragma mark- 上托加载更多
- (void)MJLoadMoreDatas{

    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
        
    }
    
    self.page++;
    
    [self.net systemMessageGetFromNetWithPage:self.page];
    
    __weak RingMessageVC * weakSelf = self;
    self.net.systemMessage = ^(NSArray * array){
        
        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];

        [weakSelf.dataMessage addObjectsFromArray:array];
        
        [weakSelf.tableView reloadData];
    };

    
}


#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self.view addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"系统消息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    
//    UIButton * readAllBt = [UIButton buttonWithType:UIButtonTypeCustom];
//    [readAllBt setTitle:@"全部已读" forState:UIControlStateNormal];
//    readAllBt.frame = CGRectMake(0,0,100,30);
//    readAllBt.center = CGPointMake(SCREEN_W - 60, 45);
//    readAllBt.titleLabel.font = [UIFont systemFontOfSize:16];
//    [readAllBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.navView addSubview:readAllBt];
//    [readAllBt addTarget:self action:@selector(readAllAlready) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark-全部已读
- (void)readAllAlready{

    NSLog(@"全部已读");
    
    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
        
    }
    
    
    [self.net systemMessageReadAll];
    
    __weak RingMessageVC * weakSelf = self;
    
    self.net.systemMessageReadAllB=^(NSString * message,NSString * code){
    
     [weakSelf.tableView.mj_header beginRefreshing];

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
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (button.tag == 9900) {
        
        NSLog(@"9900");
    }
    
}


#pragma mark-tableViewCreat
- (void)tableViewCreat{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJRefreshDatas)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJLoadMoreDatas)];
    
    [self.tableView.mj_header beginRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataMessage.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (self.cell == nil) {
        self.cell = [[[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:self options:nil]firstObject];
    }
    systemMessageModel * model = self.dataMessage[indexPath.row];
    
    self.cell.model = model;
    
    return self.cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"选择了%@",indexPath);
    systemMessageModel * model = self.dataMessage[indexPath.row];
    
    DetailMessageVC * detailVC = [[DetailMessageVC alloc]init];
    detailVC.id_ = model.id_;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
