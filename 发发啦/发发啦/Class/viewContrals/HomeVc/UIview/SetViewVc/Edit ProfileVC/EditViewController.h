//
//  EditViewController.h
//  发发啦
//
//  Created by gxtc on 16/8/30.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sendMessageBlock)(NSString *);

@interface EditViewController : UIViewController

@property(nonatomic,assign)NSInteger buttonTag;
@property(nonatomic,strong)sendMessageBlock sendMessageBlock;



@end
