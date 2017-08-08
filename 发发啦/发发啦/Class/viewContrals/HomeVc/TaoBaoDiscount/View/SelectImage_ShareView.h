//
//  SelectImage_ShareView.h
//  发发啦
//
//  Created by gxtc on 2017/8/7.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectImage_ShareViewBlock)(NSInteger,BOOL);

@interface SelectImage_ShareView : UIView

@property (nonatomic,strong)NSArray * imageArr;

@property (nonatomic,strong)NSArray * imageUrlArr;

@property (nonatomic,strong)SelectImage_ShareViewBlock selectImageBK;
@end
