//
//  userCollectionArticleModel.m
//  发发啦
//
//  Created by gxtc on 16/10/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "userCollectionArticleModel.h"

@implementation userCollectionArticleModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.id_ = [NSString stringWithFormat:@"%@",dict[@"id"]];
        self.title = dict[@"title"];
        self.addtime = [NSString stringWithFormat:@"%@",dict[@"addtime"]];
        self.thumb = dict[@"thumb"];
        self.view_count = [NSString stringWithFormat:@"%@",dict[@"view_count"]];
        self.url = dict[@"url"];
        self.share_count = [NSString stringWithFormat:@"%@",dict[@"share_count"]];
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[userCollectionArticleModel alloc]initWithDictionary:dict];
    
    
}
@end
