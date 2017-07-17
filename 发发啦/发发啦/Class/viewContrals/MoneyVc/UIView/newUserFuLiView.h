//
//  newUserFuLiView.h
//  发发啦
//
//  Created by gxtc on 16/10/26.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "articleModel.h"
typedef void(^BackBlock) (void);
typedef void(^GoToEditPersonMessageBlock) (void);
typedef void(^GoToSignBlock) (void);
typedef void(^GoToInviteBlock) (void);

typedef void(^GoToWebBlock) (articleModel *);


//typedef void(^newTaskFinishBlock)(NSString *,NSString *);

@interface newUserFuLiView : UIView
@property(nonatomic,copy)BackBlock fuLiBlock;
@property(nonatomic,copy)GoToEditPersonMessageBlock editPersonMessage;
@property(nonatomic,copy)GoToSignBlock signRed;
@property(nonatomic,copy)GoToInviteBlock toInvite;
@property(nonatomic,copy)GoToWebBlock toWeb;



- (void)initCreat;

@end
