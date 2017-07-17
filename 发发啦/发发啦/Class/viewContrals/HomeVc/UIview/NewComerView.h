//
//  NewComerView.h
//  ScrollviewDemo
//
//  Created by gxtc on 16/8/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^comerViewbackBlock)(void);
typedef void(^comerViewH5Block)(NSString *);


@interface NewComerView : UIView

@property(nonatomic,copy)comerViewbackBlock  backBlock;
@property(nonatomic,copy)comerViewH5Block h5Block;

- (void)initCreat;

@end
