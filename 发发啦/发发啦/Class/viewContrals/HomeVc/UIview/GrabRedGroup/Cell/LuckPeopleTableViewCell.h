//
//  LuckPeopleTableViewCell.h
//  发发啦
//
//  Created by gxtc on 16/9/12.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LuckPeopleTableViewCell : UITableViewCell


- (void)addDataWithIconImage:(NSString *)iconUrl andUserName:(NSString *)userName andTime:(NSString *)time andMoney:(NSString *)moner andIconTitle:(NSString *)title andLittleIcon:(NSString *)littleIcon;

@end
