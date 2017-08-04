//
//  ChannelScrollerView.h
//  发发啦
//
//  Created by gxtc on 2017/8/4.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTableViewPlaceHolder.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "ImportArticleCell.h"
#import "ListTaoBaoCell.h"
#import "NetWork.h"

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self

typedef void(^ChannelClassifyFinishBlock)(NSArray *);
typedef void(^ChannelClassifyCurrentPageBlock)(NSInteger);

@interface ChannelScrollerView : UIView

@property(nonatomic,copy)ChannelClassifyFinishBlock channelClassifyBK;
@property(nonatomic,copy)ChannelClassifyCurrentPageBlock currentPageBK;

@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)NSArray * channelClassifyArray;

@property(nonatomic,strong)NSMutableArray * btArray;

/**改变栏目位置*/
- (void)changeChannelScrollViewContOfSetWithPage:(NSInteger)page;
@end
