//
//  ArticalView.h
//  ArticalDemo
//
//  Created by gxtc on 16/8/19.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "articleOneTypeModel.h"

typedef void (^searchBarVcBlock)(void);
typedef void (^articalRankBlock)(NSInteger);
typedef void (^webViewVCBlock)(NSString * ,articleOneTypeModel *);

@interface ArticalView : UIView
@property(nonatomic,copy)searchBarVcBlock searchBlock;
@property(nonatomic,copy)articalRankBlock articalRankBlock;
@property(nonatomic,strong)UIButton * navView2RightButton;

@property(nonatomic,strong)webViewVCBlock  webBlock;
@property(nonatomic,strong)webViewVCBlock  webGuangGaoBlock;


- (void)initCreat;
@end
