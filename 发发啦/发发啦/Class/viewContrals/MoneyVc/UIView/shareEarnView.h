//
//  shareEarnView.h
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shareEarnModel.h"

typedef void(^BackBlock) (void);
typedef void(^shareEarnDetailBlock) (shareEarnModel *);

@interface shareEarnView : UIView
@property(nonatomic,copy)BackBlock backBlock;
@property(nonatomic,copy)shareEarnDetailBlock shareEarnDetail;

- (void)initCreat;

@end
