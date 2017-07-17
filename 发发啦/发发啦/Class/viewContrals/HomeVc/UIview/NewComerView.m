//
//  NewComerView.m
//  ScrollviewDemo
//
//  Created by gxtc on 16/8/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "NewComerView.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface NewComerView ()<UIScrollViewDelegate>
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UIView * navView;

@end

@implementation NewComerView

- (void)initCreat{

    self.backgroundColor = [UIColor whiteColor];
    
    [self scrollViewCreat];
    
    [self navViewCreat];
}

- (void)scrollViewCreat{

    
    NSArray * arrayPic = @[@"xinshou_02.jpg",@"xinshou_03.jpg",@"xinshou_04.jpg",@"xinshou_05.jpg",@"xinshou_06.jpg",@"xinshou_07.jpg"];
//    NSArray * titleArray = @[@"注册微转啦",@"快速赚钱",@"邀请徒弟",@"收徒技巧",@"提现打款",@"常见问题"];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    _scrollView.contentSize = CGSizeMake(0, SCREEN_H - 63);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < 6; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((SCREEN_W / 2)*(i%2),(SCREEN_H-64)/3*(i / 2), SCREEN_W/2,(SCREEN_H - 64)/3);
        button.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        button.layer.cornerRadius = 10;
        [_scrollView addSubview:button];
        [button setImage:[UIImage imageNamed:arrayPic[i]] forState:UIControlStateNormal];
        
        button.tag = 2000 + i;

        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:_scrollView];
}


- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self addSubview:button];
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = [NSString stringWithFormat:@"新手学堂"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}


- (void)buttonAction:(UIButton *)button{

    NSString * type = [NSString new];
    
    if (button.tag == 2000) {
        NSLog(@"2000");
        type = @"register";
    }else if (button.tag == 2001){
        NSLog(@"2001");
        type = @"make_money";

    }else if (button.tag == 2002){
        NSLog(@"2002");
        type = @"prentice";

    }else if (button.tag == 2003){
        NSLog(@"2003");
        type = @"skills";

    }else if (button.tag == 2004){
        NSLog(@"2004");
        type = @"auto";

    }else if (button.tag == 2005){
        NSLog(@"2005");
        type = @"common_problem";
    }else if (button.tag == 3000){
        NSLog(@"3000");
        self.backBlock();
        
        return;
    }
    
    self.h5Block(type);
    
}


@end
