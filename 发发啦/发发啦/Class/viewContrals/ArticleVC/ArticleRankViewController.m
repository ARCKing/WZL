//
//  ArticleRankViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "ArticleRankViewController.h"
#import "RankCellTableViewCell.h"
#import "webViewController.h"
#import "articleRankModel.h"
#import "NetWork.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface ArticleRankViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UIScrollView * scrollView;

@property(nonatomic,retain)UIView * tableHeadView;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)webViewController * web;
@property(nonatomic,strong)NetWork * net;
@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSMutableDictionary * dataDictionary;

@end

@implementation ArticleRankViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initCreatWithPage:(NSInteger)page{
    
    
    self.dataDictionary = [NSMutableDictionary new];
    
    self.currentPage = page;
    
    NSLog(@"page=>%ld",page);
    
    [self navViewCreat];
    [self tableHeadViewCreat];
    [self tableScrollViewCreat];
    
    [self getDataFromNetWithPage:page];
}

#pragma mark-获取网络数据
- (void)getDataFromNetWithPage:(NSInteger)page{
    
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    NSInteger myTime = 0;
    
    if (page == 0) {
        
        myTime = 1;
        
    }else if (page == 1){
        
        myTime = 7;

    }else{
        myTime = 30;

    }
    
    [self.net articleRankListGetFromNetWithTime:myTime];

    __weak ArticleRankViewController * weakSelf = self;
    
    self.net.articleList= ^(NSArray * array){
        
        [weakSelf.dataDictionary setObject:array forKey:[NSString stringWithFormat:@"%ld",page]];
        
        UITableView * tabV = (UITableView *)[weakSelf.scrollView viewWithTag:2200 + page];
        
        [tabV reloadData];
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
    titleLabel.text = @"排行榜";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 40);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}

#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    UIButton * bt1 = (UIButton *)[self.tableHeadView viewWithTag:1100];
    UIButton * bt2 = (UIButton *)[self.tableHeadView viewWithTag:1101];
    UIButton * bt3 = (UIButton *)[self.tableHeadView viewWithTag:1102];

    
    if (button.tag == 3000) {
        NSLog(@"3000");
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    
    }else if (button.tag == 1100) {
        NSLog(@"1100");
        [bt1 setSelected:YES];
        [bt2 setSelected:NO];
        [bt3 setSelected:NO];
        
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        
        self.currentPage = 0;
        
        UITableView * tabv = (UITableView *)[self.scrollView viewWithTag:2200+_currentPage];
        if (tabv == nil) {
            [self tableViewCreat];
            [self getDataFromNetWithPage:_currentPage];

        }

        
    }else if (button.tag == 1101){
        NSLog(@"1101");
        [bt1 setSelected:NO];
        [bt2 setSelected:YES];
        [bt3 setSelected:NO];
        
        [_scrollView setContentOffset:CGPointMake(SCREEN_W, 0) animated:YES];

        self.currentPage = 1;
        
        UITableView * tabv = (UITableView *)[self.scrollView viewWithTag:2200+_currentPage];
        if (tabv == nil) {
            [self tableViewCreat];
            [self getDataFromNetWithPage:_currentPage];
            
        }

    }else if (button.tag == 1102){
        NSLog(@"1102");
        [bt1 setSelected:NO];
        [bt2 setSelected:NO];
        [bt3 setSelected:YES];
        [_scrollView setContentOffset:CGPointMake(SCREEN_W * 2, 0) animated:YES];
        
        
        self.currentPage = 2;
        
        UITableView * tabv = (UITableView *)[self.scrollView viewWithTag:2200+_currentPage];
        if (tabv == nil) {
            [self tableViewCreat];
            [self getDataFromNetWithPage:_currentPage];
            
        }


    }

}

#pragma mark- tableHeadViewCreat
- (void)tableHeadViewCreat{
    self.tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, 36)];
    self.tableHeadView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableHeadView];
    
    NSArray * buttonTitle = @[@"点击日榜",@"点击周榜",@"点击月榜"];
    
    for (int i = 0; i < 3; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
#pragma mark- button.tag-1100+i
        button.tag = 1100 + i;
        button.frame = CGRectMake((1 + (SCREEN_W - 2)/3) * i, 0, (SCREEN_W - 2)/3, 35);
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [self.tableHeadView addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    

    UIButton * bt1 = (UIButton *)[self.tableHeadView viewWithTag:1100];
    UIButton * bt2 = (UIButton *)[self.tableHeadView viewWithTag:1101];
    UIButton * bt3 = (UIButton *)[self.tableHeadView viewWithTag:1102];
    
    if (_currentPage == 0) {
        [bt1 setSelected:YES];
        
    }else if (_currentPage == 1){
        [bt2 setSelected:YES];
        
    }else if (_currentPage == 2){
        [bt3 setSelected:YES];
    }
    
}


#pragma mark- tableScrollViewCreat
- (void)tableScrollViewCreat{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 + self.tableHeadView.bounds.size.height, SCREEN_W, SCREEN_H - 64 - self.tableHeadView.bounds.size.height)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_W * 3, 0);
    [self.view addSubview:_scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(_currentPage * SCREEN_W, 0);
#pragma mark- scrollView.tag-3333
    self.scrollView.tag = 3333;
#pragma mark- 添加tableView
    [self tableViewCreat];
}


#pragma mark- scrollViewDelagtemeathe
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    UIButton * bt1 = (UIButton *)[self.tableHeadView viewWithTag:1100];
    UIButton * bt2 = (UIButton *)[self.tableHeadView viewWithTag:1101];
    UIButton * bt3 = (UIButton *)[self.tableHeadView viewWithTag:1102];

    if (scrollView.tag == 3333) {
        
        NSInteger newPage = scrollView.contentOffset.x/SCREEN_W;
        
        if (newPage == 0) {
            [bt1 setSelected:YES];
            [bt2 setSelected:NO];
            [bt3 setSelected:NO];
            
        }else if (newPage == 1) {
            [bt1 setSelected:NO];
            [bt2 setSelected:YES];
            [bt3 setSelected:NO];
        
        }else if (newPage == 2) {
        
            [bt1 setSelected:NO];
            [bt2 setSelected:NO];
            [bt3 setSelected:YES];
        }

        
        self.currentPage = scrollView.contentOffset.x/SCREEN_W;

        
        UITableView * tabv = (UITableView *)[self.scrollView viewWithTag:2200+_currentPage];
        if (tabv == nil) {

            [self tableViewCreat];
//            [self getDataFromNetWithPage:_currentPage];
            
        }
        
    }
    
}

#pragma mark- tableView
- (void)tableViewCreat{
    
//    for (int i = 0; i < 3; i++) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W * _currentPage, 0, SCREEN_W, SCREEN_H - 64 - self.tableHeadView.bounds.size.height ) style:UITableViewStylePlain];
        tableView.tag = 2200 + _currentPage;
        tableView.rowHeight = SCREEN_W/4;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsVerticalScrollIndicator = NO;
        [self.scrollView addSubview:tableView];
//    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSString * pageKey = [NSString stringWithFormat:@"%ld",_currentPage];
    
    NSArray * array = self.dataDictionary[pageKey];
    
    NSLog(@"==%ld",array.count);
    
    return array.count;
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"====>>indexPath.row === %ld",indexPath.row);
    
    RankCellTableViewCell * rankCell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_%ld",_currentPage]];
    if (rankCell == nil) {
        rankCell = [[[NSBundle mainBundle]loadNibNamed:@"RankCellTableViewCell" owner:self options:nil]firstObject];
    }
    
    
    NSString * pageKey;
    
    NSArray * array;

    
    if (tableView.tag == 2200) {
        pageKey = [NSString stringWithFormat:@"%d",0];
        array = self.dataDictionary[pageKey];
    }else if(tableView.tag == 2201) {
        pageKey = [NSString stringWithFormat:@"%d",1];
        array = self.dataDictionary[pageKey];
    }else {
        pageKey = [NSString stringWithFormat:@"%d",2];
        array = self.dataDictionary[pageKey];
    }
    
    
    NSInteger indexRow = indexPath.row;

    articleRankModel * model = array[indexRow];
    rankCell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexRow + 1];
    rankCell.model = model;
    
    return rankCell;
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    NSLog(@"我点了=>%ld",indexPath.row);
    
    NSString * pageKey = [NSString stringWithFormat:@"%ld",_currentPage];
    
    NSArray * array = self.dataDictionary[pageKey];
    
    articleRankModel * model = array[indexPath.row];
    NSString * id_ = model.id_;
    
    webViewController * web = [[webViewController alloc]init];
    web.share_count = model.share_count;

    web.bigTitle = model.title;
    web.abstract = model.title;
    web.thumbimg = model.thumb;
    web.ucshare = model.ucshare;
    web.qqshare = model.qqshare;
    web.share = model.share;
    
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
//    self.hidesBottomBarWhenPushed = NO;
}




@end
