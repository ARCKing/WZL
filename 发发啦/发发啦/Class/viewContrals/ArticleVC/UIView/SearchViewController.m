//
//  SearchViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/26.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResoultTableViewController.h"//-> 继承UITableViewController
#import "NetWork.h"
#import "searchBarModel.h"
#import "webViewController.h"

//#import "FIrstTableViewController.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

//@property(nonatomic,strong)FIrstTableViewController * searchControll;
//@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UITableView * tableView;
//@property(nonatomic,strong)UISearchController * searchController;
@property(nonatomic,strong)NSArray * dataSource;
@property(nonatomic,strong)UITableViewCell * cell;
@property(nonatomic,strong)UIView * navView;

@property(nonatomic,strong)UISearchBar * searchBar;

@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated{

//self.navigationController.navigationBar.hidden = NO;

    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArray = [NSMutableArray new];
    [self navViewCreat];

    
}



#pragma mark- 搜索框网络请求
- (void)searchBarResoultFromNetWithTitle:(NSString *)title{
    
    NetWork * net = [[NetWork alloc]init];
    
    [net searchBarGetDataFromNetWithTitle:title];
    
    __weak SearchViewController * weakSelf = self;
    net.searchBarResoult = ^(NSArray * array){
        weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
        
        [weakSelf.tableView reloadData];
        
    };
}


//#pragma mark- navViewCreat
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


    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(40, 20, SCREEN_W - 40, 44)];
    [_navView addSubview:_searchBar];
//    _searchBar.barTintColor = [UIColor colorWithRed:255/255.0 green:199/255.0 blue:58/255.0 alpha:1];
//    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    _searchBar.barTintColor = [UIColor clearColor];
    
    //去掉边框//==!!
    [_searchBar setBackgroundImage:[[UIImage alloc]init]];
    
    _searchBar.placeholder = @"输入文章标题搜索";
    _searchBar.delegate = self;
    [self tableView];
}



#pragma mark- searchaBarDelgate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    NSLog(@"正在搜索");
    
    [_searchBar resignFirstResponder];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    NSLog(@"编辑");
    

}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    NSLog(@"输入改变-网络请求");
    [self searchBarResoultFromNetWithTitle:searchText];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_searchBar resignFirstResponder];

}

- (void)buttonAction:(UIButton *)bt{

    [self.navigationController popViewControllerAnimated:YES];

}


//懒加载tableView
- (UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H -64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    
    return _tableView;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (_cell == nil) {
        
        _cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    searchBarModel * model = self.dataArray[indexPath.row];
    
    _cell.textLabel.text = model.title;
    
    return _cell;
    
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    NSLog(@"我点了=>%ld",indexPath.row);
    searchBarModel * model = self.dataArray[indexPath.row];
    NSString * id_ = model.id_;
    
    webViewController * web = [[webViewController alloc]init];
    
    
    NSString * url = [NSString stringWithFormat:@"http://wz.lgmdl.com/app/article/detail_new/id/%@",id_];
    NSLog(@"url =>%@",url);
    
    if (model.detail) {
        
        web.urlString = model.detail;
        
    }else{
        
        web.urlString = url;
        
    }
    
    web.id_ = model.id_;
    web.share_count = model.share_count;
    web.shareUrl = model.share;
    web.thumbimg = model.thumb;
    web.abstract = model.abstract;
    web.bigTitle = model.title;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    

}

@end
