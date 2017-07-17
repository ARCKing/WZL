//
//  taskView.h
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock) (void);

typedef void(^readEarnBlock) (void);

typedef void(^inviteBlock) (void);

typedef void(^shareEarnBlock) (void);


@interface taskView : UIView

@property(nonatomic,copy)BackBlock backBlock;
@property(nonatomic,copy)readEarnBlock readEarn;
@property(nonatomic,copy)inviteBlock inviteFriend;
@property(nonatomic,copy)shareEarnBlock shareEarnBlock;

@property(nonatomic,strong)UIButton * toFourVcButton;


- (void)initCreat;

@end
