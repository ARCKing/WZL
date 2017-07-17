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

#import "webViewController.h"


#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width


@interface AddArticleController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) addArticletableHeadView * headView;

@end

@implementation AddArticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self tableViewConfiguration];
}



- (void)tableViewConfiguration{

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = SCREEN_W / 4;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.tableHeaderView = self.headView;
}


- (addArticletableHeadView *)headView{

    if (!_headView) {
        
        _headView = [[addArticletableHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/2)];
        
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
}


- (void)weiChatSearchButtonAction{

    wkWebViewController * vc = [[wkWebViewController alloc]init];
    
    vc.url = @"https://baidu.com";
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    
}


- (void)weiChatHeadNewsButtonAction{

    wkWebViewController * vc = [[wkWebViewController alloc]init];
    
    vc.url = @"https://baidu.com";
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)popBackButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)navRightButtonAction:(id)sender {
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    typeOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        
        cell = [[typeOneCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    webViewController * vc = [[webViewController alloc]init];

    vc.urlString = @"https://baidu.com";
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
