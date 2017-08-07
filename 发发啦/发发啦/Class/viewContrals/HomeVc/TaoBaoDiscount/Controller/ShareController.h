//
//  ShareController.h
//  发发啦
//
//  Created by macos on 2017/8/6.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoBaoDiscountClassifyListModel.h"

@interface ShareController : UIViewController

@property(nonatomic,strong)NSArray * imageArr;

@property(nonatomic,strong)NSArray * imageUrlArr;

@property(nonatomic,strong)TaoBaoDiscountClassifyListModel * model;

@end
