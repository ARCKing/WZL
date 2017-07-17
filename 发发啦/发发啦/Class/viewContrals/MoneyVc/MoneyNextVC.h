//
//  MoneyNextVC.h
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^toFourVcBlock) (void);

@interface MoneyNextVC : UIViewController
@property(nonatomic,assign)NSInteger buttonTag;
@property(nonatomic,copy)toFourVcBlock toFourVc;

@end
