//
//  GrabRedCashView.h
//  发发啦
//
//  Created by gxtc on 16/8/26.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backBlock) (void);

typedef void(^groupBlock) (NSInteger);


@interface GrabRedCashView : UIView

@property(nonatomic,copy)backBlock backBlock;

@property(nonatomic,copy)groupBlock groupBlock;

- (void)initCreat;


@end
