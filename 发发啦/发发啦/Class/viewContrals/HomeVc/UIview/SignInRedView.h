//
//  SignInRedView.h
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNextViewController.h"

typedef void(^backBlock) (void);

typedef void(^addAdvView) (UIView *);



@interface SignInRedView : UIView

@property(nonatomic,copy)backBlock backBlock;
@property(nonatomic,copy)backBlock shareViewBlock;
@property(nonatomic,copy)addAdvView advViewShou;



@property(nonatomic,retain)UIButton * resoultButton;
@property(nonatomic,retain)UIView * getMoneyView;

@property(nonatomic,assign)HomeNextViewController * homeNext;




- (void)initCreat;

@end
