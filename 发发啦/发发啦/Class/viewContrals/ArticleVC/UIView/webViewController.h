//
//  webViewController.h
//  发发啦
//
//  Created by gxtc on 16/9/28.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import <UMSocialCore/UMSocialCore.h>

@interface webViewController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (nonatomic,copy)NSString * urlString;
@property (nonatomic,copy)NSString * articleTitle;

@property (nonatomic, assign)BOOL isPost;
@property (nonatomic, assign)BOOL isReadEarn;
@property (nonatomic, assign)BOOL isNewTeach;
@property (nonatomic, assign)BOOL isPush;


@property(nonatomic,copy)NSString * token;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,assign)NSInteger  cid;

@property(nonatomic,copy)NSString * bigTitle;
@property(nonatomic,copy)NSString * abstract;
@property(nonatomic,copy)NSString * thumbimg;
@property(nonatomic,copy)NSString *  id_;
@property(nonatomic,copy)NSString * shareUrl;
@property(nonatomic,copy)NSString * share_count;

@property(nonatomic,copy)NSString * ucshare;
@property(nonatomic,copy)NSString * qqshare;
@property(nonatomic,copy)NSString * share;

@property(nonatomic,assign)BOOL isHeighPrice;


@property (nonatomic, assign) UMSocialPlatformType socialType;

@end
