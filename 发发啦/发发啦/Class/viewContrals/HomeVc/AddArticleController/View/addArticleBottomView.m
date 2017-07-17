//
//  addArticleBottomView.m
//  发发啦
//
//  Created by gxtc on 2017/7/17.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "addArticleBottomView.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width



@implementation addArticleBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addUI];
        
    }
    return self;
}



- (void)addUI{

    [self addSubview:self.addArticleButton];
}



- (UIButton *)addArticleButton{


    if (!_addArticleButton) {
        
        _addArticleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _addArticleButton.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:205.0/255.0 blue:170.0/255.0 alpha:1.0];
        [_addArticleButton setTitle:@"添加文章" forState:UIControlStateNormal];
        
        _addArticleButton.layer.cornerRadius = 3.0;
        
        _addArticleButton.frame = CGRectMake(10, 5, SCREEN_W - 20, 39);
    }
    return  _addArticleButton;
}

@end
