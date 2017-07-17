//
//  MyCollectView.h
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userCollectionArticleModel.h"
#import "MBProgressHUD.h"

typedef void(^backBlock) (void);

typedef void(^collectArticleWebBlock) (userCollectionArticleModel *);

@interface MyCollectView : UIView

@property(nonatomic,copy)backBlock backBlock;
@property(nonatomic,copy)collectArticleWebBlock webBlock;



- (void)initCreat:(MBProgressHUD *)hud;

@end
