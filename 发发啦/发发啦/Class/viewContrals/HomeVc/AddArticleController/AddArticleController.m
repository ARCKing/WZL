//
//  AddArticleController.m
//  发发啦
//
//  Created by gxtc on 2017/7/17.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "AddArticleController.h"
#import "addArticletableHeadView.h"
#import "typeOneCell.h"
#import "wkWebViewController.h"
#import "articleModel.h"

#import "MBProgressHUD.h"
#import "NetWork.h"
#import "webViewController.h"
#import "ImportArticleCell.h"
#import "MJRefresh.h"
#import "CYLTableViewPlaceHolder.h"
#import "YiDianZiXunController.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define KURL @"http://wz.lgmdl.com"


@interface AddArticleController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) addArticletableHeadView * headView;

@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) NetWork * net;

@property (nonatomic,assign)NSInteger page;
@end

@implementation AddArticleController


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    [self.tableView.mj_header beginRefreshing];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArr = [NSMutableArray new];
    
    [self tableViewConfiguration];
 
}

#pragma mark- 添加采集链接
- (void)addArticleLink{

    NetWork * net = [[NetWork alloc]init];

    [net customerImportArticleURL:@"http://mp.weixin.qq.com/s/O8hqMsQNyydal2_9_ynogA" andc_id:@""];

    net.importArticleLinkBK = ^(NSString *code, NSString *message) {
        
        NSLog(@"%@",message);
    };
}


#pragma mark- 获取导入文章的列表
- (void)importArticleListWithPage:(NSInteger)page andIsRefresh:(BOOL)isRefresh{

    [self.net getCustomerAuditImportArticleWithPage:page];

    __weak AddArticleController * weakSelf = self;
    
    self.net.customerImportArticleListBK = ^(NSString *code, NSString *message, NSString *str, NSArray *arr1, NSArray * arr2) {
        
        
        if (isRefresh) {
            
        
            weakSelf.dataArr = [NSMutableArray arrayWithArray:arr1];
        
        }else{
        
        
            [weakSelf.dataArr addObjectsFromArray:arr1];
        }
        
        [weakSelf.tableView cyl_reloadData];
        
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    };

}

#pragma mark- 刷新
- (void)MJ_Refresh{


    self.page = 1;
    [self importArticleListWithPage:self.page andIsRefresh:YES];
    
}


#pragma mark- 加载更多
- (void)MJ_LoadMore{

    self.page +=1 ;
    [self importArticleListWithPage:self.page andIsRefresh:NO];
    
}


- (NetWork *)net{
    if (!_net) {
        
        _net = [[NetWork alloc]init];
    }
    return _net;
}

- (void)tableViewConfiguration{

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, ScreenWith/2 + 64, ScreenWith, ScreenHeight -64- ScreenWith/2);
    self.tableView.rowHeight = SCREEN_W / 4 + 20;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
//    self.tableView.tableHeaderView = self.headView;

    [self.view addSubview:self.headView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJ_Refresh)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJ_LoadMore)];
    
//    [self.tableView.mj_header beginRefreshing];
}


- (addArticletableHeadView *)headView{

    if (!_headView) {
        
        _headView = [[addArticletableHeadView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_W/2)];
        
        [_headView.addLinkBt addTarget:self action:@selector(addLinkButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
         [_headView.weiChatSearchLink addTarget:self action:@selector(weiChatSearchButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
         [_headView.weiChatHeadNews addTarget:self action:@selector(weiChatHeadNewsButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }

    return _headView;
}



- (void)addLinkButtonAction{

    
    UIPasteboard * paste = [UIPasteboard generalPasteboard];
    
    NSString * pasteUrl = [paste string];

    NSLog(@"%@",pasteUrl);
    
    
    if (pasteUrl == nil) {
        
        [self ShowMBPhudWith:@"链接为空或链接不正确" andShowTime:1.50];
    }
    
    
    NetWork * net = [[NetWork alloc]init];
    
    [net customerImportArticleURL:pasteUrl andc_id:nil];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak AddArticleController * weakSelf = self;
    
    net.importArticleLinkBK = ^(NSString * code, NSString * message) {
        
        [hud hideAnimated:YES];
    
        [weakSelf ShowMBPhudWith:message andShowTime:1.5];
        
    };
    
}


/**HUD文本提示框*/
- (void)ShowMBPhudWith:(NSString *)message andShowTime:(NSTimeInterval)time{
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:16.0];
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:time];
    
};


- (void)weiChatSearchButtonAction{

    wkWebViewController * vc = [[wkWebViewController alloc]init];
    
    vc.url = @"http://weixin.sogou.com/";
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    
}


- (void)weiChatHeadNewsButtonAction{

    YiDianZiXunController * vc = [[YiDianZiXunController alloc]init];
    
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)popBackButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)navRightButtonAction:(id)sender {
    
//    NSString stringWithFormat:@"%@/App/Index/jiaocheng",DomainURL
    
    
    wkWebViewController * vc = [[wkWebViewController alloc]init];
    vc.isTeach = YES;
    vc.url = [NSString stringWithFormat:@"%@/App/Index/jiaocheng",KURL];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

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
    
    if (![model.state isEqualToString:@"1"]) {
    
        return;
    }
    
    webViewController * vc = [[webViewController alloc]init];
    vc.id_ = model.article_id;
    vc.thumbimg = model.thumb;
    vc.bigTitle = model.title;
    vc.urlString = [NSString stringWithFormat:@"http://wz.lgmdl.com/app/article/detail_new?id=%@",model.article_id];
    vc.share_count = [NSString stringWithFormat:@"%d",arc4random()%1000 + 124];
    
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
@end
