//
//  TaoBaoDiscountController.m
//  发发啦
//
//  Created by gxtc on 2017/8/4.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "TaoBaoDiscountController.h"
#import "ListTableView.h"
#import "ChannelScrollerView.h"
#import "NetWork.h"
#import "TaoBaoDiscountClassifyModel.h"
#import "TaoBaoDiscountClassifyListModel.h"
#import "TaoBaoListDetailCell.h"
#import "TaoBaoIteamDetailController.h"

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self

@interface TaoBaoDiscountController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIView * navView;
@property (nonatomic,strong)ChannelScrollerView * channelView;

@property (nonatomic,strong)UIScrollView * scrollView;

@property (nonatomic,strong)NSArray * channelClassifyArray;

@property (nonatomic,assign)NSInteger page;

@property (nonatomic,strong)NetWork * net;

@property (nonatomic,strong)ListTableView * currentTableView;

@end

@implementation TaoBaoDiscountController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    
    
    [self.navView addSubview:self.channelView];
    

}


- (UIView *)navView{
    if (!_navView) {
        
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, 64)];
        _navView.backgroundColor = [UIColor orangeColor];
        
        UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(5, 20, ScreenWith/8, 44);
        [bt setImage:[UIImage imageNamed:@"comm_icon_back_white"] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(popBackAction) forControlEvents:UIControlEventTouchUpInside];
        bt.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_navView addSubview:bt];
        
    }
    return _navView;
}


- (ChannelScrollerView *)channelView{
    if (!_channelView) {
        
        WEAK_SELF;
        _channelView = [[ChannelScrollerView alloc]initWithFrame:CGRectMake(ScreenWith/10, 20, ScreenWith - ScreenWith/10, 44)];
        _channelView.backgroundColor = [UIColor clearColor];
        
        _channelView.channelClassifyBK = ^(NSArray * array) {
            
            weakSelf.channelClassifyArray = array;
            
            [weakSelf.view addSubview:weakSelf.scrollView];
        };
        
        
        _channelView.currentPageBK = ^(NSInteger currentPage) {
            
            [weakSelf.scrollView setContentOffset:CGPointMake(ScreenWith * currentPage, 0) animated:YES];
            
        };
        
        
    }
    
    return _channelView;
}


- (void)popBackAction{

    [self.navigationController popViewControllerAnimated:YES];
}

- (UIScrollView *)scrollView{

    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreenWith,ScreenHeight - 64)];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(ScreenWith * self.channelClassifyArray.count, 0);
        _scrollView.tag = 2200;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
        [self addTableViewWithPage:0];
        
    }
    return _scrollView;
}


#pragma mark- 翻页加载

- (void)addTableViewWithPage:(NSInteger)page{

    ListTableView * listTableView = (ListTableView *)[self.scrollView viewWithTag:11220 + page];
    
    if (!listTableView) {
        
        ListTableView * view = [[ListTableView alloc]initWithFrame:CGRectMake(page * ScreenWith,0, ScreenWith, ScreenHeight - 64)];
        view.tag = 11220 + page;
        
        TaoBaoDiscountClassifyModel * model = self.channelClassifyArray[page];
        view._id = model._id;
        
        [self.scrollView addSubview:view];
        
        if (page == 0) {
            
            self.currentTableView = view;
        }
        
        
        WEAK_SELF;
        
        view.iteamDidSelectBK = ^(TaoBaoDiscountClassifyListModel * model) {
            
            TaoBaoIteamDetailController * vc = [[TaoBaoIteamDetailController alloc]init];
            vc._id = model._id;
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        
    }
}


- (void)changChannelSelectWithPage:(NSInteger)page{


    for (UIButton * bt in self.channelView.btArray) {
        
        if (bt.tag == page + 1100) {
            
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            bt.titleLabel.font = [UIFont systemFontOfSize:21];
            
        }else{
            
            [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            bt.titleLabel.font = [UIFont systemFontOfSize:17];
            
        }
        
        
    }


    [self.channelView changeChannelScrollViewContOfSetWithPage:page];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger page = scrollView.contentOffset.x/ScreenWith;

    if (scrollView.tag == 2200) {
                
        [self addTableViewWithPage:page];
    }

    [self changChannelSelectWithPage:page];
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{


    NSInteger page = scrollView.contentOffset.x/ScreenWith;
    
    if (scrollView.tag == 2200) {
        
        [self addTableViewWithPage:page];
    }
    
    
}

- (NetWork *)net{
    if (!_net) {
        
        _net = [[NetWork alloc]init];
    }
    return _net;
}
@end
