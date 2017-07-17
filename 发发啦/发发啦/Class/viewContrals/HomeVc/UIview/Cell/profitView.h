//
//  profitView.h
//  inComeDetailDemo
//
//  Created by gxtc on 16/8/23.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


typedef void(^backBlock) (void);
@interface profitView : UIView

@property(nonatomic,copy)backBlock backBlock;

@property(nonatomic,assign)NSInteger page;

- (void)initCreat:(MBProgressHUD *)hud;
@end
