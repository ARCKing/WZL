//
//  searchBarModel.m
//  发发啦
//
//  Created by gxtc on 16/10/25.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "searchBarModel.h"

@implementation searchBarModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
       
        self.id_ = dict[@"id"];
        self.title = dict[@"title"];
        self.url = dict[@"url"];
        self.share_count = [NSString stringWithFormat:@"%@",dict[@"share_count"]];
        self.ucshare = [NSString stringWithFormat:@"%@",dict[@"ucshare"]];
        self.thumb = [NSString stringWithFormat:@"%@",dict[@"thumb"]];
        self.share = [NSString stringWithFormat:@"%@",dict[@"share"]];
        self.abstract = [NSString stringWithFormat:@"%@",dict[@"abstract"]];
        self.detail = dict[@"detail"];
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[searchBarModel alloc]initWithDictionary:dict];
    
    
}

@end
