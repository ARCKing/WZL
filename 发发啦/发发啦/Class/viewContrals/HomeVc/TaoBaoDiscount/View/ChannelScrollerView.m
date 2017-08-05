//
//  ChannelScrollerView.m
//  发发啦
//
//  Created by gxtc on 2017/8/4.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ChannelScrollerView.h"
#import "TaoBaoDiscountClassifyModel.h"
#define bt_with ScreenWith/6
#define bt_heigh 44

@interface ChannelScrollerView()

@property(nonatomic,strong)NetWork * net;


@end

@implementation ChannelScrollerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.btArray = [NSMutableArray new];
        
        [self getChannelClassify];
    }
    
    return self;
    
}


-(void)drawRect:(CGRect)rect{
    
    
}


- (void)addUI{
    
    [self addSubview:self.scrollView];
}


- (UIScrollView *)scrollView{

    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith - ScreenWith/10, 44)];
        _scrollView.pagingEnabled = NO;
        _scrollView.contentSize = CGSizeMake(bt_with * self.channelClassifyArray.count, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.userInteractionEnabled = YES;
        
        for (int i = 0; i < self.channelClassifyArray.count; i ++) {
            
            TaoBaoDiscountClassifyModel * model = self.channelClassifyArray[i];
            
//            NSInteger _id = [model._id integerValue];
            
            UIButton * bt =  [self addBtWithTitle:model.name andtag:1100 + i andFrame:CGRectMake(i * bt_with, 0, bt_with, bt_heigh)];
        
            [self.btArray addObject:bt];
            
            [_scrollView addSubview:bt];
        }
        
    }

    return _scrollView;
}


- (UIButton *)addBtWithTitle:(NSString *)title andtag:(NSInteger)tag andFrame:(CGRect )fram{

    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = fram;
    [bt setTitle:title forState:UIControlStateNormal];
    bt.backgroundColor = [UIColor clearColor];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    bt.titleLabel.font = [UIFont systemFontOfSize:17.0];
    bt.tag = tag;
    [bt addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (tag == 1100) {
        
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        bt.titleLabel.font = [UIFont systemFontOfSize:21];

    }
    
    
    return bt;
}



- (void)btAction:(UIButton *)bt{

    NSInteger page = bt.tag - 1100;
    
    for (UIButton * bts in self.btArray) {
        
        if (bts.tag == bt.tag) {
        
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            bt.titleLabel.font = [UIFont systemFontOfSize:21];
            
        }else{
        
            [bts setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            bts.titleLabel.font = [UIFont systemFontOfSize:17];

        }
        
        
    }

    [self changeChannelScrollViewContOfSetWithPage:page];
    
    self.currentPageBK(page);
}

/**改变栏目位置*/
- (void)changeChannelScrollViewContOfSetWithPage:(NSInteger)page{

    NSInteger count = self.channelClassifyArray.count;
    
    if (page > 2 && self.channelClassifyArray.count > 5) {
        
        if (page*bt_with >= (self.channelClassifyArray.count -3)*bt_with) {
            
            CGFloat allLong = self.channelClassifyArray.count * bt_with;

            
            
            [self.scrollView setContentOffset:CGPointMake(bt_with * (page-2) - bt_with*(3 - (count - page)) - bt_with/2, 0) animated:YES];

        }else{
            
            [self.scrollView setContentOffset:CGPointMake(bt_with * (page-2), 0) animated:YES];

        }
    }else{
        
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];

    }
    
}


- (void)getChannelClassify{

    [self.net getTaoBaoDiscountChannelClassify];
    WEAK_SELF;
    self.net.taoBaoDiscountChannelClassifyBK = ^(NSString * code, NSString *message, NSString *str, NSArray * dataArr, NSArray *arr) {
        
        weakSelf.channelClassifyArray = dataArr;
        
        [weakSelf addUI];

        weakSelf.channelClassifyBK(dataArr);
    };
}


- (NetWork *)net{

    if (!_net) {
        
        _net = [[NetWork alloc]init];
    }
    return _net;
}

@end
