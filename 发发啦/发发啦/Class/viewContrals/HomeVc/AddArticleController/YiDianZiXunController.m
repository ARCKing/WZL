//
//  YiDianZiXunController.m
//  发发啦
//
//  Created by gxtc on 2017/8/3.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "YiDianZiXunController.h"

#import "MBProgressHUD.h"
#import "NetWork.h"
#import "webViewController.h"
#import "ImportArticleCell.h"
#import "MJRefresh.h"
#import "CYLTableViewPlaceHolder.h"
#import "wkWebViewController.h"

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self

@interface YiDianZiXunController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) NetWork * net;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,copy)NSString * addtime;
@end


@implementation YiDianZiXunController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self tableViewConfiguration];
    
    
}

- (NSString *)addtime{

    NSDate * nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    
    _addtime = [NSString stringWithFormat:@"%.f",now];

    return _addtime;
}
#pragma madk- 一点资讯数据请求
- (void)YiDianZiXunArticleListGetFromNetWithCstart:(NSInteger)cstart
                                              cend:(NSInteger)cend
                                           refresh:(NSString *)refresh
                                           addtime:(NSString *)addtime{

    WEAK_SELF;
    
    [self.net YiDianZiXunGetArticleListWithCstart:cstart Cend:cend refresh:refresh addtime:addtime];
    
    self.net.yiDiZiXunArticleListBK = ^(NSString *status, NSString *str1, NSString * str2, NSArray * articleDataArr, NSArray * arr) {
        
        NSLog(@"%@-%@",articleDataArr,status);
        
        if ([refresh isEqualToString:@"1"]) {
        
            weakSelf.dataArr = [NSMutableArray arrayWithArray:articleDataArr];
            

        
        }else{
        
        
            [weakSelf.dataArr addObjectsFromArray:articleDataArr];
            
        }
        
        [weakSelf.tableView cyl_reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
    };

}


- (void)tableViewConfiguration{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, ScreenWith/2 + 64, ScreenWith, ScreenHeight -64- ScreenWith/2);
    self.tableView.rowHeight = ScreenWith / 4 + 20;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //    self.tableView.tableHeaderView = self.headView;
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJ_Refresh)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJ_LoadMore)];
    
    [self.tableView.mj_header beginRefreshing];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ImportArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ImportArticleCell" owner:self options:nil]firstObject];
    }
    
    ImportArticleModel * model = self.dataArr[indexPath.row];
    
    if (![model.state isEqualToString:@"1"]) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    }
    
    cell.model =model;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    ImportArticleModel * model = self.dataArr[indexPath.row];
    
    wkWebViewController * vc = [[wkWebViewController alloc]init];
    vc.importArticleModel = model;
    vc.url = model.url;
    vc.isYiDianZiXun = YES;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//有数据->没数据 会调用一次
- (UIView *)makePlaceHolderView{
    
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith,ScreenWith)];
    v.userInteractionEnabled = YES;
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith/5, ScreenWith/5)];
    image.image =[ UIImage imageNamed:@"icon_noD"];
    image.center = CGPointMake(v.center.x, v.center.y - ScreenWith/5);
    image.userInteractionEnabled = YES;
    [v addSubview:image];
    return v;
}

//另外，占位视图默认的设置是不能滚动的，也就不能下拉刷新了，但是如果想让占位视图可以滚动，则需要实现下面的可选代理方法。
- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    
    return YES;
}


#pragma mark- 刷新
- (void)MJ_Refresh{
    
    
    self.page = 0;
    [self YiDianZiXunArticleListGetFromNetWithCstart:0 cend:50 refresh:@"1" addtime:self.addtime];

}


#pragma mark- 加载更多
- (void)MJ_LoadMore{
    
    self.page +=1 ;
    [self YiDianZiXunArticleListGetFromNetWithCstart:self.page*50 cend:self.page*50 + 50 refresh:@"0" addtime:self.addtime];

}


- (NetWork *)net{
    if (!_net) {
        
        _net = [[NetWork alloc]init];
    }
    return _net;
}


- (IBAction)popBackButtonAction:(id)sender {


    [self.navigationController popViewControllerAnimated:YES];
}


@end
