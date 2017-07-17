//
//  WithDrawRecordVC.m
//  发发啦
//
//  Created by gxtc on 17/3/29.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "WithDrawRecordVC.h"
#import "MJRefresh.h"
#import "withDrawCashRecortCell.h"
#import "NetWork.h"
#import "MBProgressHUD.h"

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WithDrawRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIView * tableHeadView;

@property(nonatomic,strong)NSMutableArray * cashArray;
@property(nonatomic,strong)NSMutableArray * cashRecordArray;

@property (nonatomic,strong)withDrawCashRecortCell * myCell;
@property(nonatomic,retain)withDrawCashRecortCell * LastCell;

@property(nonatomic,assign)NSInteger currentIndexRow;
@property(nonatomic,assign)NSInteger lastIndexRow;

@property (nonatomic,strong)UIView * navView;

@property (nonatomic,assign)BOOL isOpen;

@end

@implementation WithDrawRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentIndexRow = 10000;
    self.lastIndexRow = 10000;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.cashArray = [NSMutableArray new];
    self.cashRecordArray = [NSMutableArray new];

    [self navViewCreat];
    
    [self tableViewCreat];
    
//    [self getCashRecordFromNet];
}

- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self.view addSubview:button];
    button.tag = 3000;
    [button addTarget:self action:@selector(comeBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"提现记录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    
}

- (void)comeBackAction{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- 获取提现记录
- (void)getCashRecordFromNet{
    
    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defaul objectForKey:@"usermessage"];
    
    NSString * uid = dict[@"uid"];
    NSString * token = dict[@"token"];
    NetWork * net = [[NetWork alloc]init];
    
    [net withDrawCashRecordWithUid:uid andToken:token];
    
    __weak WithDrawRecordVC * weakSelf = self;
    
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    net.weiXinPayCash =^(NSArray * array){
        
//        [hud hideAnimated:YES];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        weakSelf.cashRecordArray = [NSMutableArray arrayWithArray:array];
        NSLog(@"%@",weakSelf.cashRecordArray);
        
        [weakSelf.tableView reloadData];
    };
    
}



#pragma mark- tableViewCreat
- (void)tableViewCreat{
    
    [self tableHeadViewCreat];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, ScreenHeight - 64) style:UITableViewStylePlain];
    //    self.tableView.backgroundColor =[UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_W/7;
    self.tableView.tableHeaderView = _tableHeadView;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getCashRecordFromNet)];
    
    [self.tableView.mj_header beginRefreshing];
}


- (void)tableHeadViewCreat{
    
    self.tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/8)];
    self.tableHeadView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W/4-10, SCREEN_W/8)];
    timeLabel.text = @"时间";
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.backgroundColor = [UIColor whiteColor];
    [self.tableHeadView addSubview:timeLabel];
    
    UILabel * modeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/4, 0, SCREEN_W/4, SCREEN_W/8)];
    
    modeLabel.text = @"方式";
    modeLabel.textColor = [UIColor blackColor];
    [self.tableHeadView addSubview:modeLabel];
    modeLabel.backgroundColor = [UIColor whiteColor];
    modeLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * cashLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2 + SCREEN_W/16, 0, SCREEN_W/4, SCREEN_W/8)];
    
    cashLabel.text = @"金额(元)";
    cashLabel.textColor = [UIColor blackColor];
    [self.tableHeadView addSubview:cashLabel];
    cashLabel.backgroundColor = [UIColor whiteColor];
    
    UILabel * stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W -SCREEN_W/4 + 30 - 10, 0, SCREEN_W/4 -30, SCREEN_W/8)];
    [self.tableHeadView addSubview:stateLabel];
    stateLabel.text = @"状态";
    stateLabel.textColor = [UIColor blackColor];
    stateLabel.backgroundColor = [UIColor whiteColor];
    stateLabel.textAlignment = NSTextAlignmentRight;
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_W/8, SCREEN_W, 1)];
    line.backgroundColor =[UIColor lightGrayColor];
    [self.tableHeadView addSubview:line];
    
}


#pragma mark- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cashRecordArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cell_id = @"cell_id";
    self.myCell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
    if (self.myCell == nil) {
        
        self.myCell = [[withDrawCashRecortCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
        
        self.myCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    withDrawCashRecordModel * model = self.cashRecordArray[indexPath.row];
    
    if ([model.note isEqualToString:@""]) {
        
        self.myCell.reasonImgView.alpha = 0;
    }else{
        
        self.myCell.reasonImgView.alpha = 1;
        
    }
    
    self.myCell.cashModel = self.cashRecordArray[indexPath.row];
    return self.myCell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    withDrawCashRecordModel * model = self.cashRecordArray[indexPath.row];
    
    if ([model.note isEqualToString:@""]) {
        
        return;
    }
    
    
    
    withDrawCashRecortCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    
    self.currentIndexRow = indexPath.row;
    
    if (cell.isShow == YES) {
        
        cell.isShow = !cell.isShow;
        
        cell.reasonLabel.alpha = 0;
        
        
        cell.reasonImgView.transform = CGAffineTransformIdentity;
        
        self.isOpen = NO;
        
    }else{
        
        cell.isShow = !cell.isShow;
        
        self.isOpen = YES;
        
        [UIView animateWithDuration:1 animations:^{
            cell.reasonLabel.alpha = 1;
            
        }];
        
        
        cell.reasonImgView.transform = CGAffineTransformIdentity;
        
        cell.reasonImgView.transform = CGAffineTransformMakeRotation(M_PI);
        
    }
    
    
    if (self.LastCell && self.LastCell != cell) {
        
        if (self.LastCell.isShow) {
            
            self.LastCell.reasonLabel.alpha = 0;
            
            self.LastCell.isShow = NO;
            
            self.LastCell.reasonImgView.transform = CGAffineTransformIdentity;
            
        }
        
    }
    
    
    self.LastCell = cell;
    
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    withDrawCashRecordModel * model = self.cashRecordArray[indexPath.row];
    
    
    
    if (self.currentIndexRow == indexPath.row) {
        
        
        if ((self.lastIndexRow == self.currentIndexRow || [model.note isEqualToString:@""]) && self.isOpen == NO) {
            
            self.lastIndexRow = 10000;
            
            return SCREEN_W/7;
            
        }else if (self.isOpen == NO && self.lastIndexRow == 10000){
        
            return SCREEN_W/7;

        }else{
            
            self.lastIndexRow = self.currentIndexRow;
            
            return SCREEN_W/5;
        }
        
    }else{
        
        return SCREEN_W/7;
    }
    
}








@end
