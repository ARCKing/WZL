//
//  addArticletableHeadView.m
//  发发啦
//
//  Created by gxtc on 2017/7/17.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "addArticletableHeadView.h"


#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#define bt_w SCREEN_W/3

@implementation addArticletableHeadView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        
    }
    return self;
}



- (void)addUI{

    [self addSubview:self.BGimageView];
    
    [self addSubview:self.addLinkBt];
    
    [self addSubview:self.weiChatHeadNews];

    [self addSubview:self.weiChatSearchLink];
    
    
}


- (UIImageView *)BGimageView{


    if (!_BGimageView) {
        
        _BGimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _BGimageView.image = [UIImage imageNamed:@"post_bg"];
    }
    
    return _BGimageView;
}


- (UIButton *)addLinkBt{
    if (!_addLinkBt) {
        
        _addLinkBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addLinkBt setTitle:@"粘贴文章链接" forState:UIControlStateNormal];
        _addLinkBt.frame = CGRectMake(10, 20, SCREEN_W - 20, SCREEN_W/9);
        _addLinkBt.backgroundColor = [UIColor colorWithRed:60.0/255.0 green:179.0/255.0 blue:113.0/255.0 alpha:1.0];
        _addLinkBt.layer.cornerRadius = 2.0;
    }
    
    return _addLinkBt;
}



- (UIButton *)weiChatSearchLink{

    if (!_weiChatSearchLink) {
        
        _weiChatSearchLink = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weiChatSearchLink setTitle:@"微信文章搜索" forState:UIControlStateNormal];
        _weiChatSearchLink.frame = CGRectMake(SCREEN_W/2 -bt_w , SCREEN_W/9+20, bt_w, bt_w);
        
        [_weiChatSearchLink setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _weiChatSearchLink.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        [_weiChatSearchLink setImage:[UIImage imageNamed:@"img_search_article.jpg"] forState:UIControlStateNormal];

        
        _weiChatSearchLink.imageEdgeInsets = UIEdgeInsetsMake(-_weiChatSearchLink.titleLabel.intrinsicContentSize.height, 0, 0, - _weiChatSearchLink.titleLabel.intrinsicContentSize.width);
        
        _weiChatSearchLink.titleEdgeInsets = UIEdgeInsetsMake(_weiChatSearchLink.currentImage.size.height + _weiChatSearchLink.titleLabel.intrinsicContentSize.height, -_weiChatSearchLink.currentImage.size.width,0,0);

    }
    return _weiChatSearchLink;
}

- (UIButton *)weiChatHeadNews{
    
    if (!_weiChatHeadNews) {
        
        _weiChatHeadNews = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weiChatHeadNews setTitle:@"微信头条" forState:UIControlStateNormal];
        _weiChatHeadNews.frame = CGRectMake(SCREEN_W/2,SCREEN_W/9 + 20, bt_w, bt_w);
        
        [_weiChatHeadNews setImage:[UIImage imageNamed:@"img_weixin_tt"] forState:UIControlStateNormal];
        [_weiChatHeadNews setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _weiChatHeadNews.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        _weiChatHeadNews.imageEdgeInsets = UIEdgeInsetsMake(-_weiChatHeadNews.titleLabel.intrinsicContentSize.height, 0, 0, - _weiChatHeadNews.titleLabel.intrinsicContentSize.width);
        
        _weiChatHeadNews.titleEdgeInsets = UIEdgeInsetsMake(_weiChatHeadNews.currentImage.size.height + _weiChatHeadNews.titleLabel.intrinsicContentSize.height, -_weiChatHeadNews.currentImage.size.width,0,0);
    }
    
    return _weiChatHeadNews;
}
@end
