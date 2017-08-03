//
//  wkWebViewController.m
//  弹框
//
//  Created by gxtc on 16/12/26.
//  Copyright © 2016年 root. All rights reserved.
//

#import "wkWebViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
#import "addArticleBottomView.h"
#import "NetWork.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface wkWebViewController ()<WKNavigationDelegate,WKNavigationDelegate,WKUIDelegate>
@property (nonatomic,strong)WKWebView * wkWeb;
@property(nonatomic,strong)UIView * navView;
@property(nonatomic,strong)UILabel * titleLabel;

@property(nonatomic,strong)MBProgressHUD * hud;


@property(nonatomic,strong)addArticleBottomView * addArticleView;


@property(nonatomic,strong)UIButton * popButton;

@property(nonatomic,copy)NSString * articleTitle;

@property(nonatomic,copy)NetWork * net;

@end

@implementation wkWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor =[ UIColor whiteColor];
    
    [self navViewCreat];
    
    [self wkWebCreat];
    
   
}


- (addArticleBottomView *)addArticleView{

    if (!_addArticleView) {
        
        _addArticleView =[[addArticleBottomView alloc]initWithFrame:CGRectMake(0, SCREEN_H - 49, SCREEN_W, 49)];
        [_addArticleView.addArticleButton addTarget:self action:@selector(addArticleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addArticleView;
}


- (void)addArticleButtonAction{

    NSLog(@"addArticleButtonAction");
    __weak wkWebViewController * weakSelf = self;

    if (self.isYiDianZiXun) {
        
        [self.net YiDianZiXunImportArticelWithTitle:self.importArticleModel.title thumb:self.importArticleModel.image _id:self.importArticleModel.docid];
        
        self.net.importArticleTitleBK = ^(NSString *code, NSString *message) {
            
            [weakSelf showHudWithMessage:message andDissmissdelay:2.0];
        };
        
    }else{
    
        [self.net customerImportArticleTitle:self.articleTitle andc_id:nil];
    
        self.net.importArticleTitleBK = ^(NSString *code, NSString *message) {
        
            [weakSelf showHudWithMessage:message andDissmissdelay:2.0];
        };
    }
}


- (void)showHudWithMessage:(NSString *)message andDissmissdelay:(NSTimeInterval)time{

    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:16.0];
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:time];
}



- (NetWork *)net{
    
    if (!_net) {
        
        _net = [[NetWork alloc]init];
    }

    return _net;
}


- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(5,32, 40, 20);
    [self.view addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 27, 250, 30)];
    titleLabel.text = @"";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 40);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    self.titleLabel = titleLabel;
}


- (UIButton *)popButton{

    if (!_popButton) {
        
    
        _popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
        _popButton.backgroundColor = [UIColor clearColor];
    
        [_popButton setTitle:@"关闭" forState:UIControlStateNormal];
    
        [_popButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
        _popButton.frame = CGRectMake(SCREEN_W - 50, 20, 50, 44);
    
        
        [_popButton addTarget:self action:@selector(popButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _popButton;
}


- (void)popButtonAction{

    [self.navigationController popViewControllerAnimated:YES];

}


- (void)buttonAction{
    
    
    if ([self.wkWeb canGoBack]) {
        
        [self.wkWeb goBack];
        
        
    }else{
    
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)wkWebCreat{

    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];

    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];

    self.wkWeb = webView;
    
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.hud = HUD;
    
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    NSLog(@"didStartProvisionalNavigation,URL=>>>>>%@",self.wkWeb.URL);
    
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"didCommitNavigation");
    
    [self.hud hideAnimated:YES];

}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"didFinishNavigation");
    
    
    NSLog(@"didFinishNavigation,URL=%@",self.wkWeb.URL);

}



- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler {
   
    
    if ([self.wkWeb canGoBack]) {
        
        [self.view addSubview:self.popButton];

    }else{
    
        [self.popButton removeFromSuperview];
    }
    
    
    
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    if([strRequest isEqualToString:@"about:blank"]) {//主页面加载内容
    
    }else{
        
        NSLog(@"url=====>%@",strRequest);

    }
    decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
    
 
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{


    if ([keyPath isEqualToString:@"title"]) {
        
        self.titleLabel.text = self.wkWeb.title;
        
        self.articleTitle = self.wkWeb.title;
        
        
        NSRange range = [self.articleTitle rangeOfString:@"搜狗微信"];
            
        if (range.location == NSNotFound) {
            
            if (!self.isTeach) {
                
                [self.view addSubview:self.addArticleView];
            }
        
        }else{
        
            [self.addArticleView removeFromSuperview];
        
        }
        
    }
}


- (void)dealloc{

    [self.wkWeb removeObserver:self forKeyPath:@"title"];
    
}


@end
