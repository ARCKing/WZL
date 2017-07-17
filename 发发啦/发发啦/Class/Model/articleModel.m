//
//  articleModel.m
//  发发啦
//
//  Created by gxtc on 16/10/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "articleModel.h"

@implementation articleModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.id_ = dict[@"id"];
        self.title = dict[@"title"];
        self.thumb = dict[@"thumb"];
        self.addtime = dict[@"addtime"];
        self.view_count = [NSString stringWithFormat:@"%@",dict[@"view_count"]];
        self.share_count = [NSString stringWithFormat:@"%@",dict[@"share_count"]];
        self.thumb_1 = dict[@"thumb_1"];
        self.thumb_2 = dict[@"thumb_2"];
        self.url = dict[@"url"];
        self.pic_num = [NSString stringWithFormat:@"%@",dict[@"pic_num"]];
        self.height_money = [NSString stringWithFormat:@"%@",dict[@"height_money"]];
        self.detail = dict[@"detail"];
        self.ucshare = dict[@"ucshare"];
        self.qqshare = dict[@"qqshare"];
        self.share = dict[@"share"];
        self.read_price = [NSString stringWithFormat:@"%@",dict[@"read_price"]];
        
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[articleModel alloc]initWithDictionary:dict];
    
    
}
@end
