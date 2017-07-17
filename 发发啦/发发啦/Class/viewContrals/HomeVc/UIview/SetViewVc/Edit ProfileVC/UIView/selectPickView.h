//
//  selectPickView.h
//  发发啦
//
//  Created by gxtc on 16/8/31.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^sendMessageBlock) (NSString *);

@interface selectPickView : UIView

@property(nonatomic,copy)sendMessageBlock messageBlock;

@property(nonatomic,strong)NSArray * aliAndWeiXinPayCashArray;

- (void)DidLoadWithTag:(NSInteger)tag;


@end
