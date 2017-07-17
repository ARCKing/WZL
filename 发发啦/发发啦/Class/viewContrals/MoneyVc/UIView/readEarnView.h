//
//  readEarnView.h
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BackBlock) (void);
typedef void(^toWebViewBlock)(NSString *,NSInteger);

@interface readEarnView : UIView

@property(nonatomic,copy)BackBlock backBlock;
@property(nonatomic,copy)toWebViewBlock toWebView;

- (void)initCreat;

@end
