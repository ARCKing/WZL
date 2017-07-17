//
//  dayPupilView.h
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^backBlock) (void);

@interface dayPupilView : UIView

@property(nonatomic,strong)backBlock back;
@property(nonatomic,strong)NSString * type;


- (instancetype)initWithFrame:(CGRect)frame AndButtonTag:(NSInteger)tag andMoney:(NSString *)money andType:(NSString *)type;
@end
