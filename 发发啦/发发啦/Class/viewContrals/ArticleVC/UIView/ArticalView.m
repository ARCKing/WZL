//
//  ArticalView.m
//  ArticalDemo
//
//  Created by gxtc on 16/8/19.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "ArticalView.h"
#import "typeOneCell.h"
#import "buttonOrderView.h"
#import "NetWork.h"
#import "articleClassModel.h"
#import "MJRefresh.h"
#import "articleModel.h"
#import "typeTwoCell.h"
#import "AFNetworking.h"

#import "MBProgressHUD.h"
#import "CoreDataManger.h"
#import "UIImageView+WebCache.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface ArticalView ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, retain) NSMutableArray *adViewArray;


@property(nonatomic,retain)UIScrollView * titleScrollView;
@property(nonatomic,retain)UIScrollView * tableViewScrollView;

@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UIView * navView2;
//@property(nonatomic,strong)UIButton * navView2RightButton;

@property(nonatomic,retain)UIButton * listButton;


/** 文章分类标题数据*/
@property(nonatomic,retain)NSMutableArray * titleMuArray;

/** 文章分类列表数据*/
@property(nonatomic,retain)NSMutableArray * articleListArray;
@property(nonatomic,retain)NSMutableDictionary * articleListDictionary;


@property(nonatomic,retain)UIView * channelView;

@property(nonatomic,retain)UIView * scrollViewCube;

@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * tableViewArray;

@property(nonatomic,assign)NSInteger currentPage;

@property(nonatomic,retain)NSMutableArray * charnnelButtonArray;

@property(nonatomic,retain)UIView * tableHeadView;

@property(nonatomic,strong)UIButton * navRightButton;

@property(nonatomic,strong)buttonOrderView * buttonView;

@property(nonatomic,strong)NSArray * articleClassArray;

@property(nonatomic,strong)NSMutableArray * addButtonArray;
@property(nonatomic,strong)NetWork * net;
@property(nonatomic,strong)NSMutableArray * pageIndexArray;
@property(nonatomic,assign)BOOL isMJRefresh;
@property(nonatomic,strong)NSMutableArray * currentDataArray;
@property(nonatomic,assign)BOOL isOtherPage;
@property(nonatomic,strong)MBProgressHUD * hud;
@property(nonatomic,assign)BOOL NetWorkStatus;

@property(nonatomic,strong)CoreDataManger * CDManger;

@end

@implementation ArticalView


- (void)initCreat{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.CDManger = [CoreDataManger shareCoreDataManger];
    
    self.NetWorkStatus = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkError) name:@"NetWorkError" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkOk) name:@"NetWorkOk" object:nil];

    //页码
    self.pageIndexArray = [NSMutableArray new];
    //当前数据
    self.currentDataArray = [NSMutableArray new];
    
    _currentPage = 0;
    
    
    
    
    
    //频道
    self.articleClassArray = [NSArray new];
    
    //所有频道数据
    self.articleListDictionary = [NSMutableDictionary new];
    
//    [self getArticleClassFromNet];
    
    [self navViewCreat];

    [self dataInit];
    
    
    
    
}




- (void)netWorkError{

    self.NetWorkStatus = NO;
    
}


- (void)netWorkOk{
    self.NetWorkStatus = YES;
}



//-(void)dealloc{
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}


#pragma mark- 下拉刷新
- (void)MJReFreshData{

    if (self.NetWorkStatus == NO) {
        
        UITableView * tb = (UITableView *)[self.tableViewScrollView viewWithTag:3000 + _currentPage];
        
        [tb.mj_header endRefreshing];
        
        return;
    }
    
    self.isMJRefresh = YES;
    
    NSLog(@"刷新--%ld",_currentPage);
    
    
    articleClassModel * model = self.titleMuArray[self.currentPage];
    
    [self articleListGetFromNetWithCid:[model.c_id integerValue] andPage:1];
    
    
    
    if(self.pageIndexArray.count >0){
    //置回第一页
    [self.pageIndexArray replaceObjectAtIndex:_currentPage withObject:[NSString stringWithFormat:@"1"]];

    }
}


#pragma mark- 上拉加载更多
- (void)MJLoadingMoreData{

    
    self.isMJRefresh = NO;

    if ((int)self.pageIndexArray.count == 0) {
        UITableView * tb = (UITableView *)[self.tableViewScrollView viewWithTag:3000 + _currentPage];
        
        [tb.mj_footer endRefreshingWithNoMoreData];

        return;
        
        
    }
    
    NSString * indexStr = self.pageIndexArray[_currentPage];
    
    NSInteger index = [indexStr integerValue];
    
    index ++;
    
    [self.pageIndexArray replaceObjectAtIndex:_currentPage withObject:[NSString stringWithFormat:@"%ld",index]];
    
    
    
    articleClassModel * models = self.titleMuArray[self.currentPage];

    
    [self articleListGetFromNetWithCid:[models.c_id integerValue] andPage:index];

}



#pragma mark- 查找本地频道分类
- (void)getLocationArticalClass{


    
}




#pragma mark- 频道检查-更新
- (void)articleCharnelClassCheck{

    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }
    
    [self.net getArticleClassFromNet];
    
    
    __weak ArticalView * weakSelf = self;
    
    NSArray * arrays = [self.CDManger checkArticleList];

    
    self.net.articleClass=^(NSArray * array){
        
        
        if ((int)array.count != (int)arrays.count) {
            
            [weakSelf.CDManger deleteAllArticleClassData];
            
            [weakSelf.CDManger insertIntoDataWithArticalClassTheSelect:array andTheUnselect:nil];
            
            
        }else{
        
            
            BOOL same = YES;
        
            for (articleClassModel * model1 in array) {
            
                for (int i = 0; i < (int)array.count; i++) {
                
                    articleClassModel * model2 = arrays[i];
                    
                    if ([model1.title isEqualToString:model2.title]) {
                        
                        same = YES;
                        
                        break;
                        
                    }else{
                        
                        same = NO;
                    
                    }
                    
                }
                
                if (same == NO) {
                    
                    break;
                }
            }
        
            
            if (same == NO) {
                
                [weakSelf.CDManger deleteAllArticleClassData];
                
                [weakSelf.CDManger insertIntoDataWithArticalClassTheSelect:array andTheUnselect:nil];
                
            }
            
        }
    };
}


#pragma mark- 从网络获取文章频道标题
- (void)getArticleClassFromNet{
    
    
    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }
    
    [self.net getArticleClassFromNet];
    
    __weak ArticalView * weakSelf = self;

    self.net.articleClass=^(NSArray * array){
        
        
        [weakSelf.CDManger deleteAllArticleClassData];

        
        for (int i = 0; i < (int)array.count; i++) {
        
            [weakSelf.pageIndexArray addObject:@"1"];
            
        }
        
        [weakSelf.titleMuArray addObjectsFromArray:array];
        
        
        [weakSelf.CDManger insertIntoDataWithArticalClassTheSelect:array andTheUnselect:nil];
        
        [weakSelf performSelector:@selector(titleScrollViewCreat)];

//        [weakSelf.CDManger checkSelectArticleCharnel];
        
        
        
    };
}


#pragma mark- 每个频道列表
- (void)articleListGetFromNetWithCid:(NSInteger)cid andPage:(NSInteger)page{
    
    
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.viewForLastBaselineLayout animated:YES];
//    hud.removeFromSuperViewOnHide = YES;
    
    NSLog(@"cid =>%ld page =>%ld",cid,page);
    
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }

    
    [self.net articleListGetFromNetWithC_id:cid andPageIndex:page];
    
    __weak ArticalView * weakSelf = self;

    self.net.articleList=^(NSArray * arry){
    
//        [hud hideAnimated:YES];
        
        //只要是刷新，就不管他是不是翻到新的频道【创建时刷新与主动刷新】
        if (weakSelf.isMJRefresh) {
            
            weakSelf.currentDataArray = [NSMutableArray arrayWithArray:arry];
            
        }else if(weakSelf.isOtherPage ){
        //翻到新的频道就获取上一次这个频道的数据[若没有数据则是刷新状态 weakSelf.isMJRefresh]
            
            NSString * cidKey = [NSString stringWithFormat:@"%ld",cid];
            
            NSArray * lastDataArray = weakSelf.articleListDictionary[cidKey];
            weakSelf.currentDataArray = [NSMutableArray arrayWithArray:lastDataArray];
            [weakSelf.currentDataArray addObjectsFromArray:arry];
            
            
        }else{
        
            [weakSelf.currentDataArray addObjectsFromArray:arry];

        }
        
        NSLog(@"%ld",weakSelf.currentDataArray.count);
        
        
        NSString * cidKey = [NSString stringWithFormat:@"%ld",cid];
        
        [weakSelf.articleListDictionary setObject:weakSelf.currentDataArray forKey:cidKey];
        
        UITableView * tab = (UITableView *)[weakSelf.tableViewScrollView viewWithTag:3000+self.currentPage];
            
            [tab reloadData];
        
        [tab.mj_header endRefreshing];
        [tab.mj_footer endRefreshing];
        
    };

}

#pragma mark- 数据初始化
- (void)dataInit{


    if (self.charnnelButtonArray == nil) {
        
        self.charnnelButtonArray = [NSMutableArray new];

    }
    
    
    
    
    self.titleMuArray = [NSMutableArray new];
    
    NSArray * arrays = [self.CDManger checkSelectArticleCharnel];

    if (arrays.count>0) {
        
        
        for (int i = 0; i < (int)arrays.count; i++) {
            
            [self.pageIndexArray addObject:@"1"];
            
        }

        
        [self.titleMuArray addObjectsFromArray:arrays];

        [self titleScrollViewCreat];
        
        
        
        [self articleCharnelClassCheck];

    }else{
    

        [self getArticleClassFromNet];
    }
    
    
    
}


#pragma mark- 文章频道滑条
- (void)titleScrollViewCreat{

    [self charnelOrderViewCreat];

    
    NSLog(@"%@",_titleMuArray);

    self.titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10,64 - 30, SCREEN_W - 50, 30)];
    
    
    [self.navView addSubview:self.titleScrollView];
    
    self.titleScrollView.backgroundColor = [UIColor orangeColor];
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
#pragma mark- 滑条滑动范围
    self.titleScrollView.contentSize = CGSizeMake((self.titleMuArray.count * 25 + (self.titleMuArray.count -1) * 20) + 20, 0);
    
    
    NSLog(@"%f", self.titleScrollView.contentOffset.y);


#pragma mark- titleScrollView.tag- 1000
    self.titleScrollView.tag = 1000;
    self.titleScrollView.delegate = self;

    
    [self addCharnnelButton];

}


#pragma mark- 导航栏
- (void)navViewCreat{
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64)];
    [self addSubview:_navView];
    self.navView.backgroundColor = [UIColor orangeColor];

}



- (void)charnelOrderViewCreat{
#pragma mark- 频道排序箭头
    self.navRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.navRightButton.frame = CGRectMake(SCREEN_W - 33, 30, 30, 28);
    [self.navRightButton setImage:[UIImage imageNamed:@"player_arrow_down.png"] forState: UIControlStateNormal];
    [self.navRightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.navView addSubview:_navRightButton];
    [self.navRightButton addTarget:self action:@selector(navRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navRightButton setSelected:NO];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W - 38, 36, 1, 16)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.navView addSubview:line];
    
    
#pragma mark- 创建频道排序页面
    self.buttonView = [[buttonOrderView alloc]initWithFrame:CGRectMake(0, -SCREEN_H + 64, SCREEN_W, SCREEN_H - 64 - 49)];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_buttonView];
    
    //完成按钮
    [self.buttonView.lineButton addTarget:self action:@selector(lineButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
#pragma mark- 创建排序导航栏
    
    self.navView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W - 30, 44)];
    self.navView2.backgroundColor = [UIColor orangeColor];
    
    UILabel * myChanneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/4, 44)];
    myChanneLabel.text = @"我的频道";
    myChanneLabel.textColor = [UIColor whiteColor];
    myChanneLabel.font = [UIFont systemFontOfSize:16];
    myChanneLabel.center = CGPointMake(SCREEN_W/10 + 5, 22);
    myChanneLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView2 addSubview:myChanneLabel];
    
    
    UILabel * myChanneLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, 44)];
    myChanneLabel2.text = @"点击排序可拖动";
    myChanneLabel2.textColor = [UIColor whiteColor];
    myChanneLabel2.font = [UIFont systemFontOfSize:13];
    myChanneLabel2.center = CGPointMake(SCREEN_W/5 + SCREEN_W/4, 22);
    myChanneLabel2.textAlignment = NSTextAlignmentCenter;
    [self.navView2 addSubview:myChanneLabel2];
    
    
    
    
    
#pragma mark- 排序按钮
    self.navView2RightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navView2RightButton setTitle:@"排序" forState:UIControlStateNormal];
    self.navView2RightButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.navView2RightButton.layer.borderWidth = 1;
    self.navView2RightButton.layer.cornerRadius = 5;
    self.navView2RightButton.frame = CGRectMake(0, 0, 40, 20);
    self.navView2RightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navView2RightButton.center = CGPointMake(CGRectGetMaxX(_navView2.frame) - 30, 22);
    [self.navView2RightButton addTarget:self action:@selector(channelOrderWithPanGuest) forControlEvents:UIControlEventTouchUpInside];
    [self.navView2 addSubview:_navView2RightButton];
    
    
}


#pragma mark- 点击排序
- (void)channelOrderWithPanGuest{
    
    [_buttonView performSelector:@selector(addGest) withObject:nil];
    
    NSLog(@"排序，添加手势");
    
}



#pragma mark- 添加频道完成
- (void)lineButtonAction{

    [_navRightButton setSelected:NO];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        
        _navRightButton.transform = CGAffineTransformIdentity;
        self.buttonView.frame = CGRectMake(0, -SCREEN_H + 64 + 49 + 64, SCREEN_W, SCREEN_H - 64 - 49);
        [_navView2 removeFromSuperview];
    }];
    
    NSArray * select = [NSArray arrayWithArray:self.buttonView.selectArray];
    NSArray * unSelect = [NSArray arrayWithArray:self.buttonView.unSelectArray];
    
    NSMutableArray * arr1 = [[NSMutableArray alloc]init];
    NSMutableArray * arr2 = [[NSMutableArray alloc]init];

    for (UIButton * bt in select) {
        articleClassModel * model = [[articleClassModel alloc]init];
        model.title = bt.titleLabel.text;
        model.c_id = [NSString stringWithFormat:@"%ld",(bt.tag - 2200)];
        
        [arr1 addObject:model];
    }
    
    for (UIButton * bt in unSelect) {
        articleClassModel * model = [[articleClassModel alloc]init];
        model.title = bt.titleLabel.text;
        model.c_id = [NSString stringWithFormat:@"%ld",(bt.tag - 1100)];
        
        [arr2 addObject:model];
    }
    
    
    [self.CDManger deleteAllArticleClassData];
    
    [self.CDManger insertIntoDataWithArticalClassTheSelect:arr1 andTheUnselect:arr2];
    
    
    [self initCreat];
}

#pragma mark- 打开排序界面
- (void)navRightButtonAction:(UIButton *)button{
    NSLog(@"%d",button.selected);
    
    [self bringSubviewToFront:_buttonView];
    [self bringSubviewToFront:_navView];

    
    if (button.selected == NO) {
        
    
    [UIView animateWithDuration:0.2 animations:^{
       
        button.transform = CGAffineTransformMakeRotation(M_PI);
        
        [self.navView addSubview:_navView2];
        self.buttonView.frame = CGRectMake(0,64, SCREEN_W, SCREEN_H - 64 - 49);
    }];
        
    }else {
    
        [UIView animateWithDuration:0.2 animations:^{
            
            button.transform = CGAffineTransformIdentity;
            self.buttonView.frame = CGRectMake(0, -SCREEN_H + 64 + 49 + 64, SCREEN_W, SCREEN_H - 64 - 49);
            [_navView2 removeFromSuperview];

        }];

    }
    
    button.selected = !button.selected;

}

#pragma 添加频道按钮
- (void)addCharnnelButton{
    
    for (int i = 0; i < (int)self.titleMuArray.count; i++) {
        
        articleClassModel * model = self.titleMuArray[i];
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:model.title forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateSelected];
         button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setSelected:NO];
        
#pragma mark- channelButton Tag值
        button.tag = 3000 + i;
        
        
//        if ([_titleMuArray[i] isEqualToString:@"视频"]) {
//            
//            button.tag = 868686;
//            NSLog(@"%ld视频",button.tag);
//        }
        
        if (i == 0) {
            [button setSelected:YES];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        
//        button.frame = CGRectMake(5 + (25 + 20) * i, -20, 40, 20);
        button.frame = CGRectMake(5 + (25 + 20) * i, 0, 40, 20);

        NSLog(@"%f",button.frame.size.height);
        NSLog(@"%f",button.frame.origin.y);

//        button.backgroundColor = [UIColor blackColor];
        [self.titleScrollView addSubview:button];
        
        [button addTarget:self action:@selector(ChannelbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.charnnelButtonArray addObject:button];
    }
    
    [self scrollViewCubeCreat];
}


#pragma mark- 初始化滑条
- (void)scrollViewCubeCreat{
    self.scrollViewCube = [[UIView alloc]initWithFrame:CGRectMake(3, 30 - 5, 40, 3)];
    
    NSLog(@"%f",self.titleScrollView.bounds.size.height -25);
    
    [self.titleScrollView addSubview:self.scrollViewCube];
    self.scrollViewCube.backgroundColor = [UIColor whiteColor];
    self.scrollViewCube.layer.cornerRadius = 3;
    
    [self tableViewScrollViewCreat];

    
}

#pragma mark- 改变滑块位置
- (void)setScrollViewcubeContentOffSet{
    
    [UIView animateWithDuration:0.3 animations:^{
    
        self.scrollViewCube.frame = CGRectMake(5 + _currentPage * (45), 25, 40, 2);
    }];

}


#pragma mark- 文章列表详情
- (void)tableViewScrollViewCreat{
    
    self.tableViewScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H -64)];
//    tag值
    self.tableViewScrollView.tag = 2000;
    self.tableViewScrollView.backgroundColor = [UIColor whiteColor];
    self.tableViewScrollView.delegate = self;
    self.tableViewScrollView.contentSize = CGSizeMake(_titleMuArray.count * SCREEN_W, SCREEN_H - 64);
    self.tableViewScrollView.pagingEnabled = YES;
    [self addSubview:_tableViewScrollView];
    self.tableViewScrollView.bounces = NO;
    
    [self addCharnnelTableView];
}


#pragma mark- 添加首个TableView
- (void)addCharnnelTableView{

    self.tableViewArray = [NSMutableArray new];
    
//    for (int i = 0; i < (int)_titleMuArray.count; i++) {
    
        for (int i = 0; i < 1; i++) {

        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W * i, 0, SCREEN_W, SCREEN_H - 64 - SCREEN_W/8) style:UITableViewStylePlain];
        [self.tableViewScrollView addSubview:tableView];
        
        tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        
#pragma mark- tableView.tag-3000+i
        tableView.tag = 3000 + i;
        tableView.rowHeight = SCREEN_W/3;
        tableView.dataSource = self;
        tableView.delegate = self;
        
        [self.tableViewArray addObject:tableView];
    }
    
    [self tableHeadViewCreat];
    
    UITableView * tableView = (UITableView *)[_tableViewScrollView viewWithTag:3000];
    
    tableView.tableHeaderView = _tableHeadView;
    

    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJReFreshData)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJLoadingMoreData)];

    [tableView.mj_header beginRefreshing];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    articleClassModel * model = self.titleMuArray[self.currentPage];
    
    NSString * pageKey = [NSString stringWithFormat:@"%ld",[model.c_id integerValue]];
    
    NSArray * array = self.articleListDictionary[pageKey];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    typeOneCell * oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
    typeTwoCell * twoCell = [tableView dequeueReusableCellWithIdentifier:@"twoCell"];
    UITableViewCell * advCell = [tableView dequeueReusableCellWithIdentifier:@"advCell"];
    
    
    if (oneCell == nil) {
        oneCell = [[typeOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"oneCell"];

    }
    
    if (twoCell == nil) {
        
        twoCell = [[typeTwoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"twoCell"];

    }
    
    if (advCell == nil) {
        advCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"advCell"];
    }
    
    
    articleClassModel * models = self.titleMuArray[self.currentPage];

    NSString *  pageKey = [NSString stringWithFormat:@"%ld",[models.c_id integerValue]];
    
    NSArray * array = self.articleListDictionary[pageKey];

    
        articleOneTypeModel * model = array[indexPath.row];
        
        NSLog(@"%@",model);
        
        if (model.id_2) {
            
            
//            if (self.adViewArray.count > 0)
//            {
//                BaiduMobAdNativeAdView *view = [self.adViewArray objectAtIndex:arc4random()%3];
//                view.tag = 0;
//                [[advCell viewWithTag:0] removeFromSuperview];
//                [advCell addSubview: view];
//                [self sendVisibleImpressionAtIndexPath:indexPath];
//            }
            
            
//            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/3, SCREEN_W/5)];
//            imageView.center =CGPointMake(SCREEN_W/6 + 15, SCREEN_W/8);
//            [advCell.contentView addSubview:imageView];
//            [imageView sd_setImageWithURL:[NSURL URLWithString:model.adthumb]];
//            
//            
//            UILabel * labrl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), SCREEN_W/8 - 15, SCREEN_W/2, 30)];
//            [advCell.contentView addSubview:labrl];
//            labrl.numberOfLines = 0;
//            labrl.text = model.adtitle;
//            labrl.font = [UIFont systemFontOfSize:14];
            
            oneCell.model5 = model;
            
            return oneCell;
            
            
        }else{
        
            if ([model.duotu isEqualToString:@"1"]) {
                twoCell.model = model;
                return twoCell;
            }else{
                oneCell.model2 = model;
                return oneCell;
            }
            
        }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    articleClassModel * models = self.titleMuArray[self.currentPage];

    NSString * pageKey = [NSString stringWithFormat:@"%ld",[models.c_id integerValue]];
    
    NSArray * array = self.articleListDictionary[pageKey];

    articleOneTypeModel * model = array[indexPath.row];
    
    if ([model.duotu isEqualToString:@"1"]) {
        
        return SCREEN_W/3;
    }
    
       return SCREEN_W/4;

}


#pragma mark- cellSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    articleClassModel * models = self.titleMuArray[self.currentPage];

    NSString * pageKey = [NSString stringWithFormat:@"%ld",[models.c_id integerValue]];
    
    NSArray * array = self.articleListDictionary[pageKey];
    articleOneTypeModel * model = array[indexPath.row];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (model.id_2) {
        //广告
        self.webGuangGaoBlock(@"",model);

    }else{
    
//        if ([model.duotu isEqualToString:@"1"]) {
//            
//            NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/app/article/detail_new/%@",model.id_];
//            
//            self.webBlock(url);
//
//        }else{
        
    NSString * url = [NSString stringWithFormat:@"http://wz.lgmdl.com/app/article/detail_new/id/%@",model.id_];
        
        NSLog(@"url=>%@",url);
        
            self.webBlock(url,model);
//        }
    
    }
    
}

#pragma mark- 频道按钮事件
- (void)ChannelbuttonAction:(UIButton *)button{
    NSInteger channelNumber = button.tag - 3000;

#pragma mark- 改变按钮选中状态
    for (UIButton * bt in _charnnelButtonArray) {
        
        if (channelNumber == bt.tag - 3000) {
            [bt setSelected:YES];
            bt.titleLabel.font = [UIFont systemFontOfSize:16];
            
        }else{
            [bt setSelected:NO];
            bt.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        
        
    }
    
    

    _currentPage = channelNumber;
    NSLog(@"=>%ld",_currentPage);
    [self setScrollViewcubeContentOffSet];
    [self.tableViewScrollView setContentOffset:CGPointMake(SCREEN_W * _currentPage, 0) animated:YES];
    
    UITableView * tabV = (UITableView *)[self.tableViewScrollView viewWithTag:3000 + _currentPage];
    if (tabV == nil) {
        [self scorllowDidLoadDataWithPage:_currentPage];
    }
    
    
    CGFloat cubeContentOffSetD_value = self.scrollViewCube.frame.origin.x - SCREEN_W/2;
    
    CGFloat titleScrollViewContentOffSetD_value = self.titleScrollView.contentSize.width - self.scrollViewCube.frame.origin.x;
    
    NSLog(@"%f=%f=%f",cubeContentOffSetD_value,titleScrollViewContentOffSetD_value,SCREEN_W/2);
    
    
    if (cubeContentOffSetD_value > 0 && titleScrollViewContentOffSetD_value > SCREEN_W/2) {
        
        [self.titleScrollView setContentOffset:CGPointMake(cubeContentOffSetD_value + self.scrollViewCube.frame.size.width/2,0) animated:YES];
        
        NSLog(@"%f", self.titleScrollView.contentOffset.y);

        
        
    }else if (cubeContentOffSetD_value < 0){
        
        [self.titleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        NSLog(@"%f", self.titleScrollView.contentOffset.y);

    }else {
        
        [self.titleScrollView setContentOffset:CGPointMake(self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width, 0) animated:YES];
        
        NSLog(@"%f", self.titleScrollView.contentOffset.y);

    }

    
    
}


#pragma mark- 滑动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    
    
    if (scrollView.tag == 2000) {
        NSLog(@"%f",scrollView.contentOffset.x);
        _currentPage = scrollView.contentOffset.x / SCREEN_W;
        
        NSLog(@"page => %ld",_currentPage);
        
       [self setScrollViewcubeContentOffSet];
#pragma mark- 改变按钮选中状态
       for (UIButton * bt in _charnnelButtonArray) {
        
          if (_currentPage == bt.tag - 3000) {
            [bt setSelected:YES];
            bt.titleLabel.font = [UIFont systemFontOfSize:16];
            
            }else{
            [bt setSelected:NO];
            bt.titleLabel.font = [UIFont systemFontOfSize:13];
          }
       }
        
        CGFloat cubeContentOffSetD_value = _scrollViewCube.frame.origin.x - SCREEN_W/2;
        
        CGFloat titleScrollViewContentOffSetD_value = _titleScrollView.contentSize.width - _scrollViewCube.frame.origin.x;
        
        NSLog(@"%f-%f-%f",cubeContentOffSetD_value,titleScrollViewContentOffSetD_value,SCREEN_W/2);
        
        
        if (cubeContentOffSetD_value > 0 && titleScrollViewContentOffSetD_value > SCREEN_W/2) {
            
            [_titleScrollView setContentOffset:CGPointMake(cubeContentOffSetD_value + _scrollViewCube.frame.size.width/2, 0) animated:YES];

            NSLog(@"%f", self.titleScrollView.contentOffset.y);

        }else if (cubeContentOffSetD_value < 0){
        
            [_titleScrollView setContentOffset:CGPointMake(0,0) animated:YES];
            NSLog(@"%f", self.titleScrollView.contentOffset.y);

        
        }else {
        
            [_titleScrollView setContentOffset:CGPointMake(_titleScrollView.contentSize.width - _titleScrollView.frame.size.width, 0) animated:YES];

            NSLog(@"%f", self.titleScrollView.contentOffset.y);

        }
        
        
        
#pragma mark- 翻页加载
        
        UITableView * tabV = (UITableView *)[self.tableViewScrollView viewWithTag:3000 + _currentPage];
        if (tabV == nil) {
            [self scorllowDidLoadDataWithPage:_currentPage];
        }
        
    }else if (scrollView.tag == 1000) {
    
        
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0) animated:NO];
        
        NSLog(@"1000=%f",scrollView.contentOffset.y);
    
    }
    
    self.isOtherPage = YES;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    NSLog(@"%f", self.titleScrollView.contentOffset.y);


}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

    NSLog(@"%f", self.titleScrollView.contentOffset.y);

}




#pragma mark- 翻页加载
- (void)scorllowDidLoadDataWithPage:(NSInteger)page{

    self.isMJRefresh = YES;
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W * page, 0, SCREEN_W, SCREEN_H - 64 - SCREEN_W/8) style:UITableViewStylePlain];
    [self.tableViewScrollView addSubview:tableView];
    
    tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
#pragma mark- tableView.tag-3000+i
    tableView.tag = 3000 + page;
    tableView.rowHeight = SCREEN_W/3;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.tableViewArray addObject:tableView];


    articleClassModel * models = self.titleMuArray[self.currentPage];

    [self articleListGetFromNetWithCid:[models.c_id integerValue] andPage:1];
    
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJReFreshData)];
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJLoadingMoreData)];

    
    [tableView.mj_header beginRefreshing];
}


#pragma tableHeadViewCreat
- (void)tableHeadViewCreat{
    self.tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H * 2 /9 - 5)];
    
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/10)];
    [self.tableHeadView addSubview:searchBar];
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_W/10, SCREEN_W, SCREEN_W/4)];
    buttonView.backgroundColor = [UIColor whiteColor];
    [self.tableHeadView addSubview:buttonView];
    
    NSArray * buttonPic = @[@"article_icon_day.png",@"article_icon_week.png",@"article_icon_month.png"];
    NSArray * buttonName = @[@" 点击日榜 ",@" 点击周榜 ",@" 点击月榜 "];
    
    for (int i = 0; i < 3; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.backgroundColor = [UIColor redColor];
        [button setImage:[UIImage imageNamed:buttonPic[i]] forState:UIControlStateNormal];
        [button setTitle:buttonName[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
#pragma mark- button.tag-3300+i
        button.tag = 3300 + i;
    
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake(buttonView.bounds.size.width/16+(buttonView.bounds.size.width/16 + buttonView.bounds.size.width/4) * i, 0, buttonView.bounds.size.width/4, buttonView.bounds.size.width/4);
        
        [buttonView addSubview:button];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleEdgeInsets = UIEdgeInsetsMake(58, -150, 0, -80);
        button.imageEdgeInsets = UIEdgeInsetsMake(-10,0,0,0);

    }
    
    
}

#pragma maark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    self.articalRankBlock(button.tag - 3300);
    
    if (button.tag == 3300) {
        NSLog(@"3300");
    }else if(button.tag == 3301){
        NSLog(@"3301");
    }else if(button.tag == 3302){
        NSLog(@"3302");
        
    }


}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

    NSLog(@"搜索跳转");
    
    self.searchBlock();
    
    return NO;
}



@end
