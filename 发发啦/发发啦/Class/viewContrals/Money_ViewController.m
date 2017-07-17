//
//  Money_ViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/15.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "Money_ViewController.h"
#import "HomeVc/HomeNextViewController.h"
#import "MoneyNextVC.h"
#import "LogInViewController.h"
#import "webViewController.h"
#import "NetWork.h"
#import "MBProgressHUD.h"


#import "articleOneTypeModel.h"

#import "articleRankModel.h"

#import "RankCellTableViewCell.h"

#import <WebKit/WebKit.h>

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width



@interface Money_ViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UIButton * rightButtion;
@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UITableViewCell * myCell;

@property(nonatomic,retain)NSArray * cellPicArrayUnLoad;
@property(nonatomic,retain)NSArray * cellPicArrayLoad;

@property(nonatomic,retain)NSArray * unLoadDetailText;
@property(nonatomic,retain)NSArray * loadDetailText;

@property(nonatomic,retain)NSArray * unLoadText;
@property(nonatomic,retain)NSArray * loadText;

@property(nonatomic,strong)NSMutableArray * buttonArray;


@property(nonatomic,retain)HomeNextViewController * homeNextVC;
@property(nonatomic,retain)MoneyNextVC * moneyNextVc;

@property(nonatomic,copy)NSString * isLogIn;

@property(nonatomic,copy)NSString * profit_task_new;

@property(nonatomic,strong)NetWork * net;

@property(nonatomic,strong)UIButton * freshButton;

@property(nonatomic,assign)BOOL isHidden;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation Money_ViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.hidden = YES;
    self.isLogIn = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogIn"];
    
    NSDictionary * dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    self.profit_task_new = dict[@"new_member_task"];
    
    [self.tableView reloadData];
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
}


#pragma mark- 审核隐藏
/** 审核隐藏*/
- (void)checkReviewHidden{
    
    
#warning 改改改!!!!!!!!!!
    [self creat];

    
    
    /*
    
    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }
    
    [self.net isHiddenWhenReview];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak Money_ViewController * weakSelf = self;
    
    self.net.hiddenWhenReviewBK = ^(NSString * code, BOOL isHiden) {
        
        
        [hud hideAnimated:YES];
        
        if (isHiden == NO) {
            
            NSLog(@"不需要隐藏");
            
                [weakSelf creat];

        }else{
        
            [weakSelf isReviewUICreat];
        
        }
        
    };
    */
}


//wk
- (void)wkWebViewCreat{

    NSString * url1 = @"http://zqw.2662126.com/App/Article/detail.html?id=94";
    NSString * url2 = @"http://zqw.2662126.com/App/Article/detail.html?id=1";
    
    NSInteger numb1 = arc4random()%20 + 1;
    
    if (numb1 % 2 == 0) {
        
        url1 = [NSString stringWithFormat:@"%@", url2];
    }
    
    WKWebView * wk = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49)];
    [self.view addSubview:wk];
    [wk loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url1]]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
    self.cellPicArrayUnLoad = @[@"task_day.png",@"task_read.png",@"task_ad.png",@"task_share.png",@"task_red.png"];
    self.unLoadDetailText = @[@"每日任务",@"阅读赚",@"享立赚",@"转发赚",@"抢红包"];
    self.unLoadText = @[@"让你每天收益有保障",@"不用分享也能赚钱",@"分享即可获得收益",@"分享后的文章被你朋友阅读+0.05元",@"每天赚点抢红包"];
    
    self.cellPicArrayLoad = @[@"task.png",@"task_day.png",@"task_read.png",@"task_ad.png",@"task_share.png",@"task_red.png"];
    self.loadDetailText = @[@"新手福利",@"每日任务",@"阅读赚",@"享立赚",@"转发赚",@"抢红包"];
    self.loadText = @[@"完成后可立即领取红包",@"让你每天收益有保障",@"不用分享也能赚钱",@"分享即可获得收益",@"分享后的文章被你朋友阅读+0.05元",@"每天赚点抢红包"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isHidden = YES;
    
    
//    [self creat];

    [self checkReviewHidden];
    
    
}


//审核下的页面
- (void)isReviewUICreat{

//    UILabel * labelView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64)];
//    labelView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:labelView];
//    labelView.text = @"今日美文推荐";
//    labelView.textColor = [UIColor whiteColor];
//    labelView.textAlignment = NSTextAlignmentCenter;
//    
//    [self wkWebViewCreat];
    
    
    [self articleTableviewCreatNew];
    
}


#pragma mark- 创建文章列表
- (void)articleTableviewCreatNew{
    
    UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64)];
    headLabel.text = @"热门文章";
    headLabel.backgroundColor = [UIColor orangeColor];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.textColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H - 49) style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.rowHeight = SCREEN_W/4;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.tag = 123456;
    
    self.tableView = tableView;
    
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.tableHeaderView = headLabel;
    
    [self.view addSubview:tableView];
    
    
    //网络请求
    
    [self getArticleDataListFromNet];
}


- (void)getArticleDataListFromNet{

    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }
    
    [self.net articleRankListGetFromNetWithTime:30];
    
    __weak Money_ViewController * weakSelf = self;
    
    self.net.articleList= ^(NSArray * array){

        if (array.count > 0) {
            
            weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
            
            [weakSelf.tableView reloadData];
        }
    };
    
}




/** 初始化界面*/
- (void)creat{
    [self creatNavView];
    [self creatTableview];
}



/** 导航栏初始化*/
- (void)creatNavView{
    
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64)];
    self.navView.backgroundColor = [UIColor colorWithRed:255/255.0 green:157/255.0 blue:55/255.0 alpha:1];
    [self.view addSubview:_navView];
    
    self.rightButtion = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButtion.frame = CGRectMake(0, 0,SCREEN_W / 4, 30);
    self.rightButtion.center = CGPointMake(SCREEN_W - SCREEN_W / 5, 40 );
    [self.navView addSubview:_rightButtion];
    [self.rightButtion setTitle:[NSString stringWithFormat:@"赚钱秘籍"] forState:UIControlStateNormal];
    self.rightButtion.titleLabel.font = [UIFont systemFontOfSize:16];
    
//    self.rightButtion.backgroundColor = [UIColor colorWithRed:255/255.0 green:157/255.0 blue:55/255.0 alpha:1];
#pragma mark- rightButton.tag-4444
    self.rightButtion.tag = 4444;
    [self.rightButtion addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.titleLabel.center = CGPointMake(SCREEN_W / 2, 40);
    [self.navView addSubview:_titleLabel];
    self.titleLabel.text = [NSString stringWithFormat:@"赚钱"];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    
}

/** tableview初始化*/
- (void)creatTableview{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_W / 5;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self addTableHeadView];
    
    
}

/** 头部视图*/
- (void)addTableHeadView{
    
    NSArray * buttonPic = @[@"recruit_day.png",@"recruit_month.png",@"recruit_week.png"];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 100)];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = view;
    
    UILabel * lableString1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
    [view addSubview:lableString1];
    lableString1.text = [NSString stringWithFormat:@"赏金收徒"];
    lableString1.textColor = [UIColor blackColor];
    lableString1.font = [UIFont systemFontOfSize:17];
    
    UILabel * lableString2 = [[UILabel alloc]initWithFrame:CGRectMake(10 + CGRectGetMaxX(lableString1.frame), 5, 150, 30)];
    [view addSubview:lableString2];
    lableString2.text = [NSString stringWithFormat:@"收徒越多还有更多奖励"];
    lableString2.textColor = [UIColor lightGrayColor];
    lableString2.font = [UIFont systemFontOfSize:12];

    NSArray * buttonLable1 = @[@"每日收徒",@"每周收徒",@"每月收徒"];
    NSArray * buttonLable2 = @[@"+1.00元",@"+15.00元",@"+30.00元"];
    self.buttonArray = [NSMutableArray new];
    for (int i = 0; i < 3; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10 + (10 + (SCREEN_W - 45) / 3) * i, 35, (SCREEN_W - 30) / 3, 55);
        [view addSubview:button];
        button.tag = 100 + i;
        [button setBackgroundImage:[UIImage imageNamed:buttonPic[i]] forState:UIControlStateNormal];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(button.frame.size.width/2, 10, 100, 20)];
        label1.text = buttonLable1[i];
        label1.font = [UIFont systemFontOfSize:12];
        [button addSubview:label1];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(button.frame.size.width/2, CGRectGetMaxY(label1.frame), 100, 15)];
        label2.text = buttonLable2[i];
        label2.textColor = [UIColor whiteColor];
        label2.font = [UIFont systemFontOfSize:11];
        [button addSubview:label2];
        
        [button addTarget:self action:@selector(tableHeadViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttonArray addObject:button];
    }
    
    
}

/** 导航按钮事件*/
- (void)navRightButtonAction{


}

/** tableHeadViewButton事件*/
- (void)tableHeadViewButtonAction:(UIButton *)button{
    
    
    MoneyNextVC * nextVc = [[MoneyNextVC alloc]init];
    
    if (button.tag == 100) {
        NSLog(@"------100-----");

        
        nextVc.buttonTag = 100;
        
        
    }else if (button.tag == 101) {
    
        NSLog(@"------101-----");
        nextVc.buttonTag = 101;

    }else if (button.tag == 102) {
        
        NSLog(@"------102-----");
        nextVc.buttonTag = 102;

        
    }
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}


- (void)buttonAction{

    NSLog(@"4444");

    _homeNextVC = [[HomeNextViewController alloc]init];
    _homeNextVC.buttonTag = 8007;
    [_homeNextVC didLoadViewWithButtonTag];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_homeNextVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    if (tableView.tag == 123456) {
        
        return self.dataArray.count;
    }
    
    
    if ([self.isLogIn isEqualToString:@"1"]) {
        
        if ([self.profit_task_new isEqualToString:@"0"]) {
            
            return 6;
        }else{
        
        return 5;
        }
    }
    
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    if (tableView.tag == 123456) {
    
        NSLog(@"====>>indexPath.row === %ld",indexPath.row);
        
        RankCellTableViewCell * rankCell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_%ld",indexPath.row]];
        
        if (rankCell == nil) {
            
            rankCell = [[[NSBundle mainBundle]loadNibNamed:@"RankCellTableViewCell" owner:self options:nil]firstObject];
        }
        
        
        articleRankModel * model = self.dataArray[indexPath.row];
        
        rankCell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        rankCell.model = model;
        
        return rankCell;


    }else{
    
        static NSString * cell_id = @"cell_id";
        _myCell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    
        if (_myCell == nil) {
            _myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
        }
    
    
    
        if ([self.isLogIn isEqualToString:@"1"]) {
        
            if ([self.profit_task_new isEqualToString:@"0"]) {
            _myCell.textLabel.text = self.loadDetailText[indexPath.row];
            _myCell.detailTextLabel.text = self.loadText[indexPath.row];
            
            
            
            _myCell.imageView.image = [UIImage imageNamed:self.cellPicArrayLoad[indexPath.row]];
            
                if (indexPath.row == 4) {
                
                    UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hot1.png"]];
                    image.frame = CGRectMake(SCREEN_W/3 + 20, 15, SCREEN_W/15, SCREEN_W/15);
                
                    [_myCell.contentView addSubview:image];
                
                }
            
            }else{
        
            
                _myCell.textLabel.text = self.unLoadDetailText[indexPath.row];
                _myCell.detailTextLabel.text = self.unLoadText[indexPath.row];
            
                _myCell.imageView.image = [UIImage imageNamed:self.cellPicArrayUnLoad[indexPath.row]];
            
            
                if (indexPath.row == 3) {
                
                    UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hot1.png"]];
                    image.frame = CGRectMake(SCREEN_W/3 + 20, 15, SCREEN_W/15, SCREEN_W/15);
                
                    [_myCell.contentView addSubview:image];
                
                }
            
            
            
            }
        
        }else{
    
        _myCell.textLabel.text = self.unLoadDetailText[indexPath.row];
        _myCell.detailTextLabel.text = self.unLoadText[indexPath.row];
        
        _myCell.imageView.image = [UIImage imageNamed:self.cellPicArrayUnLoad[indexPath.row]];
        
        
            if (indexPath.row == 3) {
            
                UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hot1.png"]];
                image.frame = CGRectMake(SCREEN_W/3 + 20, 15, SCREEN_W/15, SCREEN_W/15);
            
                [_myCell.contentView addSubview:image];
            
            }
        
        
        
        }
    
        return  _myCell;
    }
}




- (void)goToFourVC{
    
    self.tabBarController.selectedIndex = 3;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 123456) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        
        NSLog(@"我点了=>%ld",indexPath.row);
        
        
        articleRankModel * model = self.dataArray[indexPath.row];
        NSString * id_ = model.id_;
        
        webViewController * web = [[webViewController alloc]init];
        web.share_count = model.share_count;
        
        web.bigTitle = model.title;
        web.abstract = model.title;
        web.thumbimg = model.thumb;
        web.ucshare = model.ucshare;
        
        NSString * url = [NSString stringWithFormat:@"http://wz.lgmdl.com/app/article/detail_new/id/%@",id_];
        NSLog(@"url =>%@",url);
        
        if (model.detail) {
            
            web.urlString = model.detail;
            
        }else{
            
            web.urlString = url;
        }
        
        web.shareUrl = url;
        web.id_ = id_;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        self.hidesBottomBarWhenPushed = NO;

        
    }else{
    
    _moneyNextVc = [[MoneyNextVC alloc]init];

    __weak Money_ViewController * weakSelf = self;
    
    self.moneyNextVc.toFourVc=^{
    
    
        [weakSelf performSelector:@selector(goToFourVC) withObject:nil afterDelay:0.5];

    
    };
    
    
    if ([self.isLogIn isEqualToString:@"1"]) {
    
        //新手任务未完成
        if ([self.profit_task_new isEqualToString:@"0"]) {
            
         if (indexPath.row == 1) {
            
            NSLog(@"%ld",indexPath.row);
            
            _moneyNextVc.buttonTag = 1221;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:_moneyNextVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            
         }else if (indexPath.row == 2) {
            
            _moneyNextVc.buttonTag = 1;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:_moneyNextVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            NSLog(@"%ld",indexPath.row);
            
         }else if (indexPath.row == 3) {
            
            NSLog(@"%ld",indexPath.row);
            _moneyNextVc.buttonTag = 2;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:_moneyNextVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            NSLog(@"%ld",indexPath.row);
            
            
         }else if (indexPath.row == 4) {
            
            NSLog(@"%ld",indexPath.row);
            
            self.tabBarController.selectedIndex = 3;
            
         }else if (indexPath.row == 5) {
            
            NSLog(@"%ld",indexPath.row);
            
            _homeNextVC = [[HomeNextViewController alloc]init];
            _homeNextVC.buttonTag = 101;
            [_homeNextVC didLoadViewWithButtonTag];
            [self.navigationController pushViewController:_homeNextVC animated:YES];
            
         }else if (indexPath.row == 0) {
            
            NSLog(@"%ld",indexPath.row);
            
             _moneyNextVc.buttonTag = 0;
             self.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:_moneyNextVc animated:YES];
             self.hidesBottomBarWhenPushed = NO;

         }
        }else{
        
                    if (indexPath.row == 0) {
            
                        NSLog(@"%ld",indexPath.row);
            
                        _moneyNextVc.buttonTag = 1221;
                        self.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:_moneyNextVc animated:YES];
                        self.hidesBottomBarWhenPushed = NO;
            
                    }else if (indexPath.row == 1) {
            
                        _moneyNextVc.buttonTag = 1;
                        self.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:_moneyNextVc animated:YES];
                        self.hidesBottomBarWhenPushed = NO;
                        NSLog(@"%ld",indexPath.row);
            
                    }else if (indexPath.row == 2) {
            
                        NSLog(@"%ld",indexPath.row);
                        _moneyNextVc.buttonTag = 2;
                        self.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:_moneyNextVc animated:YES];
                        self.hidesBottomBarWhenPushed = NO;
                        NSLog(@"%ld",indexPath.row);
            
            
                    }else if (indexPath.row == 3) {
                        
                        self.tabBarController.selectedIndex = 3;
                        NSLog(@"%ld",indexPath.row);
            
                    }else if (indexPath.row == 4) {
                    
                        NSLog(@"%ld",indexPath.row);
                        
                        _homeNextVC = [[HomeNextViewController alloc]init];
                        _homeNextVC.buttonTag = 101;
                        [_homeNextVC didLoadViewWithButtonTag];
                        self.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:_homeNextVC animated:YES];
                        self.hidesBottomBarWhenPushed = NO;

                    }

        
        }

        
    }else{
    
        LogInViewController * login = [[LogInViewController alloc]init];
        
        [self presentViewController:login animated:YES completion:nil];
        
    }
    
    }
}


@end
