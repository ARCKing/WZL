//
//  myTableViewCell.h
//  hongbaoGroup
//
//  Created by gxtc on 16/9/2.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "redModel.h"
#import "articleModel.h"

@interface myTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton * button;
@property(nonatomic,strong)UIButton * getButton;

@property(nonatomic,strong)redModel * redModel;
@property(nonatomic,strong)articleModel * articleModel;

/** 添加Cell显示信息*/
//- (void)messageWithTimeLabel:(NSString *)time andtitleLabel:(NSString *)title andCustomer:(NSDictionary *)dict;


- (void)showThreePeople:(NSArray *)peopleArray;

@end
