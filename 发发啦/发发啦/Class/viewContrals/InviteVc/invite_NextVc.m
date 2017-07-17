//
//  invite_NextVc.m
//  发发啦
//
//  Created by gxtc on 16/11/23.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "invite_NextVc.h"
#import "MBProgressHUD.h"
#import "NetWork.h"
#import "myPrenticeCell.h"
#import "MJRefresh.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width


@interface invite_NextVc ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NetWork * net;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)UIView * navView;
@property(nonatomic,strong)MBProgressHUD * hud;

@property(nonatomic,assign)BOOL isRefresh;


@end

@implementation invite_NextVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.page = 1;
    
    self.dataArray = [NSMutableArray new];
    [self navViewCreat];
     [self tableViewCreat];
    [self myPrenticeListFromNet:self.page];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)MJ_refreshData{

    self.isRefresh = YES;
    self.page = 1;
    
    [self myPrenticeListFromNet:self.page];
    
}


- (void)MJ_loadMoreData{

    self.isRefresh = NO;
    self.page ++;
    [self myPrenticeListFromNet:self.page];


}


#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setTitle:@"<–" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    //    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = [NSString stringWithFormat:@"收徒列表"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}



- (void)buttonAction:(UIButton *)bt{


    [self.navigationController popViewControllerAnimated:YES];
}


- (void)myPrenticeListFromNet:(NSInteger)page{

    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    self.hud = hud;
    
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }

    [self.net myPrenticeWithPage:page];
    
    __weak invite_NextVc * weakSelf = self;
    
    self.net.myPrenticeList=^(NSArray * array){
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];

        
        [hud hideAnimated: YES];
        
        if (weakSelf.isRefresh == YES) {
            
            weakSelf.dataArray = [NSMutableArray arrayWithArray:array];

        }else{
        
            [weakSelf.dataArray addObjectsFromArray:array];
        
        }
        
        
        
    
        [weakSelf.tableView reloadData];
    };
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.hud hideAnimated:YES];
}

- (void)tableViewCreat{

        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H-64) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = SCREEN_W/4;
        self.tableView.tableFooterView = [[UIView alloc]init];
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.tableView];
    
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJ_refreshData)];
    
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJ_loadMoreData)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    myPrenticeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        
        cell = [[myPrenticeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    myPrenticeModel * model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
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
