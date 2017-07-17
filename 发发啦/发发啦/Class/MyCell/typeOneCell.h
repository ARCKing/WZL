//
//  typeOneCell.h
//  发发啦
//
//  Created by gxtc on 16/10/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "articleModel.h"
#import "articleOneTypeModel.h"
#import "userCollectionArticleModel.h"
#import "guaoGaoModel.h"
#import "userCollectionArticleModel.h"
@interface typeOneCell : UITableViewCell

@property(nonatomic,strong)articleModel * model;

@property(nonatomic,strong)articleOneTypeModel * model2;

@property(nonatomic,strong)userCollectionArticleModel * model3;

@property(nonatomic,strong)guaoGaoModel * model4;


@property(nonatomic,strong)articleOneTypeModel * model5;//文章列表广告


@end
