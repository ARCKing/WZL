//
//  ListTableView.m
//  发发啦
//
//  Created by gxtc on 2017/8/3.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ListTableView.h"
#import "CYLTableViewPlaceHolder.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "ImportArticleCell.h"
#import "ListTaoBaoCell.h"

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self

@interface ListTableView()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate>

@property(nonatomic,assign)NSInteger page;
@end

@implementation ListTableView

- (instancetype)initWithFrame:(CGRect)frame{


    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self addUI];
    }

    return self;

}


-(void)drawRect:(CGRect)rect{


}


- (void)addUI{

    [self addSubview:self.tableView];

}


- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, self.frame.size.height) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = ScreenWith / 4 + 30;
        
        _tableView.tableFooterView = [[UIView alloc]init];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJ_Refresh)];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MJ_LoadMore)];
    
        [_tableView.mj_header beginRefreshing];
    
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count + 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ListTaoBaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ListTaoBaoCell" owner:self options:nil]firstObject];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark- 刷新
- (void)MJ_Refresh{
    
    
    self.page = 0;
    
}


#pragma mark- 加载更多
- (void)MJ_LoadMore{
    
    self.page +=1 ;
    
}


- (NetWork *)net{
    if (!_net) {
        
        _net = [[NetWork alloc]init];
    }
    return _net;
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
