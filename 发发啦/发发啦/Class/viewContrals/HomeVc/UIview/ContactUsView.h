//
//  ContactUsView.h
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
typedef void(^backBlock)(void);
@interface ContactUsView : UIView
@property(nonatomic,copy)backBlock backBlock;

- (void)initCreat:(MBProgressHUD *)hud;
@end
