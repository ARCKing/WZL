//
//  luckModel.m
//  发发啦
//
//  Created by gxtc on 16/11/11.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "luckModel.h"

@implementation luckModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.member_id = [NSString stringWithFormat:@"%@", dict[@"member_id"]];
        self.money = [NSString stringWithFormat:@"%@", dict[@"money"]];
        self.friendTime = [NSString stringWithFormat:@"%@", dict[@"friendTime"]];
        self.title = [NSString stringWithFormat:@"%@", dict[@"title"]];
        self.headimgurl = [NSString stringWithFormat:@"%@", dict[@"headimgurl"]];
        
        if ([self.headimgurl isEqual:[NSNull null]]) {
            self.headimgurl = @"";
        }
        
        self.nickname = [NSString stringWithFormat:@"%@", dict[@"nickname"]];

        if ([self.nickname isEqual:[NSNull null]]) {
            
            self.nickname = @"";
        }
        
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[luckModel alloc]initWithDictionary:dict];
    
    
}
@end
