//
//  InComeRankView.h
//  cellDemo
//
//  Created by gxtc on 16/8/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
typedef void(^incomeViewBlock)(void);


@interface InComeRankView : UIView

@property(nonatomic,copy)incomeViewBlock incomeBlock;

- (void)initCreat:(MBProgressHUD *)hud;
@end
