//
//  profitView.m
//  inComeDetailDemo
//
//  Created by gxtc on 16/8/23.
//  Copyright © 2016年 gxtc. All rights reserved.
//


#import "profitView.h"
#import "inComeDetailCell.h"
#import "inviateComeDetailCell.h"
#import "NetWork.h"
#import "MJRefresh.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface profitView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView * taskTableview;
@property(nonatomic,retain)UITableView * inviateTableview;

@property(nonatomic,retain)UIView * readHeadView;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UIButton * Backbutton;
@property(nonatomic,retain)UILabel * incomeLabel;
@property(nonatomic,retain)UIView * line;
@property(nonatomic,retain)UIView * scrollViewCube;
@property(nonatomic,retain)UILabel * littleLabel;

@property(nonatomic,assign)NSInteger currentPage;

@property(nonatomic,retain)UIView * tableHeadView1;
@property(nonatomic,retain)UIView * tableHeadView2;

@property(nonatomic,strong)NSArray * dataArray0;//任务收益
@property(nonatomic,strong)NSArray * dataArray1;//邀请收益

@property(nonatomic,copy)NSString * invite_income;
@property(nonatomic,copy)NSString * task_income;

@end

@implementation profitView

- (void)initCreat:(MBProgressHUD * )hud{
    
    self.dataArray0 = [NSArray new];
    self.dataArray1 = [NSArray new];

    //获取收益明细
    [self getdataSourceOfNet:hud];
    
    [self readHeadViewCreat];
    [self twoButtonCreat];
    [self incomeLabelcreat];
    [self scrollViewCreat];
    
    [self tableHeadViewCreat];
    [self tableViewCreat];
    
    
    if (self.page == 0) {
        
        
    }else{
    
        self.scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
        
        self.scrollViewCube.frame = CGRectMake(SCREEN_W/2, CGRectGetMaxY(self.line.frame) - 2, (SCREEN_W - 40) /2 , 3);
        self.currentPage = 1;
        
        NSLog(@"%@",self.invite_income);
        
        self.littleLabel.text = @"邀请好友所获得收益(元)";
    }
    
    
    
    
}



#pragma mark- 任务收益刷新
- (void)MjrefreshWithTask{

    NetWork * net = [[NetWork alloc]init];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dic = [defaults objectForKey:@"usermessage"];
    
    NSLog(@"%@",dic);
    
    [net userProfitDetailMessageWithUid:dic[@"uid"] andToken:dic[@"token"] andAction0:@"0"];
    
    __weak profitView * weakSelf = self;
    
    net.userProfit=^(NSArray * array,NSString * task_income){
        
        [weakSelf.taskTableview.mj_header endRefreshing];
        
        weakSelf.dataArray0 = [NSArray arrayWithArray:array];
        
        [weakSelf.taskTableview reloadData];
        
        if (weakSelf.page == 0) {
            
            weakSelf.incomeLabel.text = task_income;
            
        }
        
        weakSelf.task_income = task_income;
    };

}

#pragma mark- 邀请收益刷新
- (void)MjrefreshWithIntnviate{
    
    NetWork * net = [[NetWork alloc]init];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dic = [defaults objectForKey:@"usermessage"];
    
    __weak profitView * weakSelf = self;

    [net userProfitDetailMessageWithUid:dic[@"uid"] andToken:dic[@"token"] andAction1:@"1"];
    
    net.inviteProfit = ^(NSArray * array,NSString * invite_income){
        
        [weakSelf.inviateTableview.mj_header endRefreshing];
        
        weakSelf.dataArray1 = [NSArray arrayWithArray:array];
        
        [weakSelf.inviateTableview reloadData];
        
        if (weakSelf.page == 1) {
            
            weakSelf.incomeLabel.text = invite_income;
            
        }
        
        weakSelf.invite_income = invite_income;
    };
    

}



//获取收益明细
- (void)getdataSourceOfNet:(MBProgressHUD *)hud{

    NetWork * net = [[NetWork alloc]init];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dic = [defaults objectForKey:@"usermessage"];
    
    NSLog(@"%@",dic);
    
    [net userProfitDetailMessageWithUid:dic[@"uid"] andToken:dic[@"token"] andAction0:@"0"];

    __weak profitView * weakSelf = self;
    
    net.userProfit=^(NSArray * array,NSString * task_income){
    
        [hud hideAnimated:YES];
        
        weakSelf.dataArray0 = [NSArray arrayWithArray:array];
    
        [weakSelf.taskTableview reloadData];
        
        if (weakSelf.page == 0) {
            
        weakSelf.incomeLabel.text = task_income;
            
        }
        
        weakSelf.task_income = task_income;
    };
    
    
    [net userProfitDetailMessageWithUid:dic[@"uid"] andToken:dic[@"token"] andAction1:@"1"];

    net.inviteProfit = ^(NSArray * array,NSString * invite_income){
    
        weakSelf.dataArray1 = [NSArray arrayWithArray:array];
        
        [weakSelf.inviateTableview reloadData];

        if (weakSelf.page == 1) {
            
            weakSelf.incomeLabel.text = invite_income;

        }
        
        weakSelf.invite_income = invite_income;
    };
    
    
}


- (void)readHeadViewCreat{
    self.readHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H / 3)];
    [self addSubview:_readHeadView];
    
#pragma mark- 背景颜色渐变
//    背景颜色渐变
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H / 3);
    gradientLayer.colors  = [NSArray arrayWithObjects:
                             (id)[UIColor orangeColor].CGColor,
                             (id)[UIColor redColor].CGColor, nil];
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    self.Backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.Backbutton setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    [self.Backbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.Backbutton.frame = CGRectMake(10, 20, 30, 30);
    [self.readHeadView addSubview:_Backbutton];
#pragma mark- backButton.tag-1000
    self.Backbutton.tag = 1000;
    [self.Backbutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label.text = @"收益明细";
    label.font = [UIFont systemFontOfSize:16];
    [self.readHeadView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(SCREEN_W/2, 35);

}

#pragma mark- tweButtonCreat
-(void)twoButtonCreat{

    NSArray * title = @[@"任务收益",@"邀请收益"];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(SCREEN_W/2 * i, CGRectGetMaxY(_Backbutton.frame), SCREEN_W/2, 30);
        [self.readHeadView addSubview:button];
        button.titleLabel.font =[ UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
#pragma mark- button.tag- 2000 + i
        button.tag = 2000+i;
    }
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_Backbutton.frame) + 35, SCREEN_W, 0.5)];
    _line.backgroundColor = [UIColor whiteColor];
    [self.readHeadView addSubview:_line];
    
    [self scrollViewCubeCreat];

}


#pragma mark- scrollViewCreat
- (void)scrollViewCubeCreat{
    self.scrollViewCube = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.line.frame) - 2, (SCREEN_W - 40) /2 , 3)];
    self.scrollViewCube.backgroundColor = [UIColor whiteColor];
    [self.readHeadView addSubview:_scrollViewCube];
    
}

#pragma mark- incomeLabel
- (void)incomeLabelcreat{

//    NSDictionary * dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    self.incomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/5)];
    self.incomeLabel.text = @"0";
    self.incomeLabel.font = [UIFont systemFontOfSize:55];
    self.incomeLabel.textAlignment = NSTextAlignmentCenter;
    self.incomeLabel.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(self.line.frame) + SCREEN_W/7);
    self.incomeLabel.textColor = [UIColor whiteColor];
//    self.incomeLabel.backgroundColor = [UIColor purpleColor];
    [self addSubview:_incomeLabel];
    
    self.littleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.incomeLabel.frame), SCREEN_W, 30)];
    self.littleLabel.text = @"做任务所获得收益(元)";
    self.littleLabel.textAlignment = NSTextAlignmentCenter;
    self.littleLabel.font = [UIFont systemFontOfSize:14];
    self.littleLabel.textColor = [UIColor blackColor];
    [self.readHeadView addSubview:_littleLabel];
    
    
}

#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    if (button.tag == 1000) {
        NSLog(@"1000");
        
        self.backBlock();
        
    }else if (button.tag == 2000){
        NSLog(@"2000");
        
//        NSDictionary * dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
        
        if (self.task_income == nil) {
            
            self.task_income = @"0";
        }
        
        
        self.incomeLabel.text =self.task_income;
        self.littleLabel.text = @"做任务所获得收益(元)";

        
        _currentPage = 0;
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollViewCube.frame = CGRectMake(20, CGRectGetMaxY(self.line.frame) - 2, (SCREEN_W - 40) /2 , 3);
        }];
        
    }else if (button.tag == 2001){
        NSLog(@"2001");
        _currentPage = 1;
        [self.scrollView setContentOffset:CGPointMake(SCREEN_W, 0) animated:YES];
        
//        NSDictionary * dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
        
        if (self.invite_income == nil) {
            
            self.invite_income = @"0";
        }

        
        self.incomeLabel.text = self.invite_income;

        self.littleLabel.text = @"邀请好友所获得收益(元)";

        [UIView animateWithDuration:0.3 animations:^{
           self.scrollViewCube.frame = CGRectMake(SCREEN_W/2, CGRectGetMaxY(self.line.frame) - 2, (SCREEN_W - 40) /2 , 3);
            
        }];
    }
}


#pragma mark- scrollViewCreat
- (void)scrollViewCreat{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _readHeadView.bounds.size.height,SCREEN_W,SCREEN_H - _readHeadView.bounds.size.height)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.tag = 1111;
    
    [self addSubview:_scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREEN_W*2, 0);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.scrollView addSubview:label];
    self.scrollView.bounces = NO;
    label.backgroundColor = [UIColor blackColor];
}


#pragma mark- scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"%f",scrollView.contentOffset.x);
    if (scrollView.tag == 1111) {
        _currentPage = scrollView.contentOffset.x/SCREEN_W;

    }
    if (_currentPage == 0) {
//        NSDictionary * dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
        if (self.task_income == nil) {
            
            self.task_income = @"0";
        }

        
        self.incomeLabel.text = self.task_income;
        self.littleLabel.text = @"做任务所获得收益(元)";
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollViewCube.frame = CGRectMake(20 , CGRectGetMaxY(self.line.frame) - 2, (SCREEN_W - 40) /2 , 3);
        }];

    }else if(_currentPage == 1) {
//        NSDictionary * dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
        
        if (self.invite_income == nil) {
            
            self.invite_income = @"0";
        }

        
        self.incomeLabel.text = self.invite_income;
        self.littleLabel.text = @"邀请好友所获得收益(元)";
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollViewCube.frame = CGRectMake(SCREEN_W/2 , CGRectGetMaxY(self.line.frame) - 2, (SCREEN_W - 40) /2 , 3);
        }];
    }
}


#pragma mark- tableHeadViewCreat
- (void)tableHeadViewCreat{

    self.tableHeadView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    self.tableHeadView1.backgroundColor = [UIColor whiteColor];
    UILabel * label1_1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    label1_1.text = @"来源";
    label1_1.textColor = [UIColor blackColor];
    label1_1.center = CGPointMake(40, 20);
    label1_1.font = [UIFont systemFontOfSize:14];
    [self.tableHeadView1 addSubview:label1_1];
    
    UILabel * label1_2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    label1_2.text = @"收入(元)";
    label1_2.textColor = [UIColor blackColor];
    label1_2.center = CGPointMake(SCREEN_W - 5 - 25, 20);
    label1_2.font = [UIFont systemFontOfSize:14];
    [self.tableHeadView1 addSubview:label1_2];

    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(5, 38, SCREEN_W - 10, 2)];
    line1.backgroundColor =[ UIColor lightGrayColor];
    [self.tableHeadView1 addSubview:line1];
    
//-----
    self.tableHeadView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    self.tableHeadView2.backgroundColor =[UIColor whiteColor];
    UILabel * label2_1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    label2_1.text = @"好友";
    label2_1.textColor = [UIColor blackColor];
    label2_1.center = CGPointMake(40, 20);
    label2_1.font = [UIFont systemFontOfSize:14];
    [self.tableHeadView2 addSubview:label2_1];
    
//    UILabel * label2_2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    label2_2.text = @"邀请收入(元)";
//    label2_2.textColor = [UIColor blackColor];
//    label2_2.center = CGPointMake(SCREEN_W / 2, 20);
//    label2_2.font = [UIFont systemFontOfSize:14];
//    [self.tableHeadView2 addSubview:label2_2];
    
    UILabel * label2_3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label2_3.text = @"分享收入(元)";
    label2_3.textColor = [UIColor blackColor];
    label2_3.center = CGPointMake(SCREEN_W - 5 - 45, 20);
    label2_3.font = [UIFont systemFontOfSize:14];
    [self.tableHeadView2 addSubview:label2_3];
    
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(5, 38, SCREEN_W - 10, 2)];
    line2.backgroundColor =[ UIColor lightGrayColor];
    [self.tableHeadView2 addSubview:line2];

}

#pragma mark- tableViewCreat
- (void)tableViewCreat{
    
    self.taskTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, self.scrollView.bounds.size.height) style:UITableViewStyleGrouped];
#pragma mark- tableView.tag-2000
    self.taskTableview.tag = 2000;
    self.taskTableview.delegate = self;
    self.taskTableview.dataSource = self;
    
    self.taskTableview.backgroundColor =[UIColor whiteColor];
    
    self.inviateTableview = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, self.scrollView.bounds.size.height) style:UITableViewStyleGrouped];
#pragma mark- tableView.tag-3000
    self.inviateTableview.tag = 3000;
    self.inviateTableview.delegate = self;
    self.inviateTableview.dataSource = self;
    self.inviateTableview.backgroundColor =[UIColor whiteColor];
    
    [self.scrollView addSubview:_taskTableview];
    [self.scrollView addSubview:_inviateTableview];
    
    self.taskTableview.tableHeaderView = _tableHeadView1;
    self.inviateTableview.tableHeaderView = _tableHeadView2;
    self.taskTableview.showsVerticalScrollIndicator = NO;
    self.inviateTableview.showsVerticalScrollIndicator = NO;
    
    self.taskTableview.rowHeight = 65;
    self.inviateTableview.rowHeight = 65;
    
    self.taskTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MjrefreshWithTask)];
    
    self.inviateTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MjrefreshWithIntnviate)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView.tag == 2000) {
        
        return self.dataArray0.count;
        
    }else {
        
        return self.dataArray1.count;
;
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    inComeDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"inComCell"];
    inviateComeDetailCell * inviateCell = [tableView dequeueReusableCellWithIdentifier:@"inviateCell"];
    
    

    
    if (tableView.tag == 2000) {
    
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"inComeDetailCell" owner:self options:nil]firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        cell.model = self.dataArray0[indexPath.row];
        return cell;
        
        
    }else if(tableView.tag == 3000){
    
        if (inviateCell == nil) {
            
            inviateCell = [[[NSBundle mainBundle]loadNibNamed:@"inviateComeDetailCell" owner:self options:nil]firstObject];
            
            inviateCell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        inviateCell.model = self.dataArray1[indexPath.row];
        return inviateCell;
    }else{

        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
    }
}

@end
