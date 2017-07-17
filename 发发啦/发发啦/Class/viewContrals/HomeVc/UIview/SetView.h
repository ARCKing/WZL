//
//  SetView.h
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^exitButtonBlock) (void);
typedef void(^editProfileBlock)(void);
typedef void(^logInBlock) (void);
typedef void(^newPassWordBlock) (void);
typedef void(^cleraCacheBlock)(void);
typedef void(^bangDingWeiXingBlock)(void);

typedef void(^aboutUsBlock) (void);
typedef void(^toWebViewBlock) (void);

typedef void(^MineSelfCollectionBlock) (void);


@interface SetView : UIView

@property(nonatomic,copy)exitButtonBlock exitBlock;
@property(nonatomic,copy)exitButtonBlock exitBlock2;

@property(nonatomic,copy)editProfileBlock editBolck;
@property(nonatomic,copy)logInBlock logBlock;
@property(nonatomic,copy)newPassWordBlock newPassBlock;
@property(nonatomic,copy)cleraCacheBlock clearBlock;
@property(nonatomic,copy)bangDingWeiXingBlock bdWeiXing;

@property(nonatomic,copy)aboutUsBlock aboutUs;
@property(nonatomic,copy)toWebViewBlock toWeb;

@property(nonatomic,copy)MineSelfCollectionBlock collectionBK;


- (void)initCreat;
-(void)ClearManager;

@end
