//
//  wkWebViewController.h
//  弹框
//
//  Created by gxtc on 16/12/26.
//  Copyright © 2016年 root. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImportArticleModel.h"
@interface wkWebViewController : UIViewController

@property (nonatomic,copy)NSString * url;

@property (nonatomic,assign)BOOL isTeach;

@property (nonatomic,assign)BOOL isYiDianZiXun;


@property (nonatomic,strong)ImportArticleModel * importArticleModel;
@end
