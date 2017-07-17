//
//  dayTaskModel.m
//  发发啦
//
//  Created by gxtc on 16/11/8.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "dayTaskModel.h"

@implementation dayTaskModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.member_id = [NSString stringWithFormat:@"%@", dict[@"member_id"]];
        self.day = [NSString stringWithFormat:@"%@", dict[@"day"]];
        self.share_article = [NSString stringWithFormat:@"%@", dict[@"share_article"]];
        self.invite = [NSString stringWithFormat:@"%@", dict[@"invite"]];
        self.share = [NSString stringWithFormat:@"%@", dict[@"share"]];
        self.read = [NSString stringWithFormat:@"%@", dict[@"read"]];

    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[dayTaskModel alloc]initWithDictionary:dict];
    
    
}

@end
