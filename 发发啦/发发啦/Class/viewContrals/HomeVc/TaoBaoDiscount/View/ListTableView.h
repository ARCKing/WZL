//
//  ListTableView.h
//  发发啦
//
//  Created by gxtc on 2017/8/3.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork.h"
#import "TaoBaoDiscountClassifyListModel.h"

typedef void (^ListTableViewIteamDidSelectBlock)(TaoBaoDiscountClassifyListModel *);


@interface ListTableView : UIView

@property (nonatomic,strong)NetWork * net;

@property (nonatomic,copy)ListTableViewIteamDidSelectBlock iteamDidSelectBK;

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)NSMutableArray * dataArray;

@property (nonatomic,copy)NSString * _id;

@end
