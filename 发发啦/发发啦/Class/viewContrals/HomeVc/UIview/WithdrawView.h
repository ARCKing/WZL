//
//  WithdrawView.h
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^backBlock) (void);
typedef void (^aliPayAndWeiXinPayMessage) (NSString *);

typedef void (^WeiXinPayBangDing) (NSString *);


@interface WithdrawView : UIView

@property(nonatomic,copy)backBlock backBlock;
@property(nonatomic,copy)aliPayAndWeiXinPayMessage cashMessage;

@property(nonatomic,copy)WeiXinPayBangDing WXBangDing;


- (void)initCreat:(NSInteger)page;
@end
