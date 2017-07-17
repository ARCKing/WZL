//
//  userRedModel.m
//  发发啦
//
//  Created by gxtc on 16/10/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "userRedModel.h"

@implementation userRedModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.title = dict[@"title"];
        self.type = dict[@"type"];
        self.money = dict[@"money"];
        self.member_id = dict[@"member_id"];
        
        NSString * nickName = dict[@"nickname"];
        
        if ([nickName isEqual:[NSNull null]]) {
            
            nickName = @"佚名";
        }
        
        self.nickname = nickName;
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[userRedModel alloc]initWithDictionary:dict];
    
    
}
@end
