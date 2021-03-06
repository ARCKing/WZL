//
//  SelectImage_ShareView.m
//  发发啦
//
//  Created by gxtc on 2017/8/7.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "SelectImage_ShareView.h"
#import "UIImageView+WebCache.h"

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self

#define image_W_H (self.frame.size.height)


@interface SelectImage_ShareView()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * scrollView;

@end

@implementation SelectImage_ShareView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}


- (void)drawRect:(CGRect)rect{

    [self addSubview:self.scrollView];
    
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 0, ScreenWith - 40, image_W_H)];
        _scrollView.contentSize = CGSizeMake(self.imageUrlArr.count * image_W_H + (self.imageUrlArr.count - 1) * 10, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        [self addImageAndBt];
    }
    return _scrollView;
}



- (void)addImageAndBt{

    for (int i = 0; i < self.imageUrlArr.count ; i++) {
        
        UIImageView * imageView = [self addImageViewWithFram:CGRectMake((image_W_H + 10) * i, 0, image_W_H, image_W_H) andImage:self.imageUrlArr[i]];
        
        UIButton * bt = [self addSelectButtonWithFram:CGRectMake(0, 0, image_W_H, image_W_H)];
       
        bt.imageEdgeInsets = UIEdgeInsetsMake(-image_W_H/2 - image_W_H/4,image_W_H/2 + image_W_H/4, 0, 0);
        
        bt.tag = 3300 + i;
        
        [imageView addSubview:bt];
        
        [self.scrollView addSubview:imageView];
    }

}



- (UIImageView * )addImageViewWithFram:(CGRect)frame andImage:(NSString *)image{

    UIImageView * imageV = [[UIImageView alloc]initWithFrame:frame];
    [imageV sd_setImageWithURL:[NSURL URLWithString:image]];
    imageV.backgroundColor = [UIColor whiteColor];
    imageV.userInteractionEnabled = YES;
    return imageV;
}


- (UIButton *)addSelectButtonWithFram:(CGRect)frame{

    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor clearColor];
    bt.frame = frame;
    [bt setImage:[UIImage imageNamed:@"icon_u_select"] forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:@"icon_s_select"] forState:UIControlStateSelected];
    [bt addTarget:self action:@selector(btActionWithtBt:) forControlEvents:UIControlEventTouchUpInside];
    bt.selected = YES;
    return bt;
}


- (void)btActionWithtBt:(UIButton *)bt{

    NSInteger selectTag = bt.tag - 3300;
    
    NSLog(@"选择图片-----%ld",selectTag);

    bt.selected = !bt.selected;
    
    self.selectImageBK(selectTag, bt.selected);
    
}

@end
