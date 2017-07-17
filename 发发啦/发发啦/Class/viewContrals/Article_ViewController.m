//
//  Article_ViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/15.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "Article_ViewController.h"
#import "ArticalView.h"
#import "SearchViewController.h"
#import "ArticleRankViewController.h"
#import "webViewController.h"
#import "articleOneTypeModel.h"
#import "wkWebViewController.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface Article_ViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,retain)UISearchBar * searchBar;
@property(nonatomic,retain)UIScrollView * titleScrollView;
@property(nonatomic,retain)UIView * lineView;
@property(nonatomic,retain)UIButton * navRightButton;

@end

@implementation Article_ViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidAppear:(BOOL)animated{
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [super viewDidAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view.
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.title = @"";
//    self.navigationController.navigationBar.translucent = YES;
    
    [self articalViewCreat];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webJump:) name:@"userInfoNotification" object:nil];

    
}


//推送跳转
- (void)webJump:(NSNotification *)userInfo{
    
    webViewController * web = [[webViewController alloc]init];
    web.urlString = userInfo.userInfo[@"aps"][@"sound"];
    [self.navigationController pushViewController:web animated:YES];
    
    
}


- (void)articalViewCreat{

    ArticalView * articalView = [[ArticalView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:articalView];
    [articalView initCreat];
    
    
    articalView.articalRankBlock=^(NSInteger page){
        
        ArticleRankViewController * articleRank = [[ArticleRankViewController alloc]init];
        
        [articleRank initCreatWithPage:page];
        
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:articleRank animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    };
    
    articalView.searchBlock = ^{
        SearchViewController * search = [[SearchViewController alloc]init];
        
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:search animated:YES];
        
        self.hidesBottomBarWhenPushed = NO;
    };
    
    
    articalView.webBlock = ^(NSString * url,articleOneTypeModel * model){
    
        webViewController * web = [[webViewController alloc]init];
        
        if (model.detail != nil) {
            
            web.urlString = model.detail;
            
        }else{
            
            web.urlString = url;
        }
        web.id_ = model.id_;
        web.bigTitle = model.title;
        web.abstract = model.abstract;
        web.thumbimg = model.thumb;
        web.shareUrl = model.share;
        web.share_count = model.share_count;
        web.ucshare = model.ucshare;
        web.qqshare = model.qqshare;
        web.share = model.share;
        
        CGFloat read_price = [model.read_price floatValue];
        
        if (read_price > 0.0) {
            
            web.isHeighPrice = YES;
            
        }else{
            
            web.isHeighPrice = NO;
        }

        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    };
    
    
    articalView.webGuangGaoBlock = ^(NSString * url,articleOneTypeModel * model){
    
        wkWebViewController * wk = [[wkWebViewController alloc]init];

        wk.url = model.adurl;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wk animated:YES];
        self.hidesBottomBarWhenPushed = NO;

        
    };
    
    
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
