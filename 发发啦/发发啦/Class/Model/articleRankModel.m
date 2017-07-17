//
//  articleRankModel.m
//  发发啦
//
//  Created by gxtc on 16/10/24.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "articleRankModel.h"

@implementation articleRankModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.id_ = dict[@"id"];
        self.title = dict[@"title"];
        self.thumb = dict[@"thumb"];
        self.addtime = dict[@"addtime"];
        self.detail = dict[@"detail"];
        self.view_count = [NSString stringWithFormat:@"%@",dict[@"view_count"]];
        self.share_count = [NSString stringWithFormat:@"%@",dict[@"share_count"]];
        
        self.ucshare = dict[@"ucshare"];
        self.qqshare = dict[@"qqshare"];
        self.share = dict[@"share"];

        self.video = [NSString stringWithFormat:@"%@",dict[@"video"]];
        
        self.duotu = [NSString stringWithFormat:@"%@",dict[@"duotu"]];
        
        if ([self.duotu isEqualToString:@"1"]) {
            
            NSArray * imgs = dict[@"img"];
            
            self.imgUrl1 = imgs[0];
            self.imgUrl2 = imgs[1];
            self.imgUrl3 = imgs[2];

        }
    }
    
    return self;
    
}



+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    return [[articleRankModel alloc]initWithDictionary:dict];
    
}

@end
