//
//  GrabRedCashLuckVC.m
//  发发啦
//
//  Created by gxtc on 16/9/12.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "GrabRedCashLuckVC.h"
#import "LuckPeopleTableViewCell.h"
#import "NetWork.h"
#import "luckModel.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface GrabRedCashLuckVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)LuckPeopleTableViewCell * luckCell;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataSourceArray;
@property(nonatomic,strong)UIView * navView;
@property(nonatomic,strong)NetWork * net;
@property(nonatomic,strong)MBProgressHUD * hud;

@end

@implementation GrabRedCashLuckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSourceArray = [NSMutableArray new];
    [self navViewCreat];
    [self tableViewCreat];
    
//    [self getLuckListFromNet];
    
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark- 获取列表
- (void)getLuckListFromNet{

    
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.removeFromSuperViewOnHide = YES;
//    
//    self.hud = hud;
    
    if ( self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    [self.net luckListWithHour:self.hour];
    
    __weak GrabRedCashLuckVC * wewakSelf = self;
    
    self.net.luckRedModel=^(NSArray * array){
        
        wewakSelf.dataSourceArray = [NSMutableArray arrayWithArray:array];
        
        [wewakSelf.tableView reloadData];
        
        NSLog(@"%@",wewakSelf.dataSourceArray);
        
//        [hud hideAnimated:YES];
        
        [wewakSelf.tableView.mj_header endRefreshing];
        
    };

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [self.hud hideAnimated:YES];
    
    [self.tableView.mj_header endRefreshing];


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
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLabel.text = @"查看大家手气";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 35);
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
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (button.tag == 9900) {
        
        NSLog(@"9900");
    }
    
}



#pragma mark- tableViewCreat
- (void)tableViewCreat{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = SCREEN_W/4;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getLuckListFromNet)];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSourceArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _luckCell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_%ld",indexPath.row]];
    if (_luckCell == nil) {
        _luckCell = [[LuckPeopleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell_%ld",indexPath.row]];
    }

    _luckCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    luckModel * model = self.dataSourceArray[indexPath.row];

    NSLog(@"%@",model);
    
   
    [_luckCell addDataWithIconImage:model.headimgurl andUserName:model.nickname andTime:model.friendTime andMoney:model.money andIconTitle:model.title andLittleIcon:nil ];

    
    return _luckCell;
}


@end
