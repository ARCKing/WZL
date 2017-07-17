//
//  systemMessageModel.m
//  发发啦
//
//  Created by gxtc on 16/10/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "systemMessageModel.h"




@implementation systemMessageModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.id_ = [NSString stringWithFormat:@"%@",dict[@"id"]];
        self.title = dict[@"title"];
        self.ptime = dict[@"ptime"];
        self.read = [NSString stringWithFormat:@"%@",dict[@"read"]];
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[systemMessageModel alloc]initWithDictionary:dict];
    
    
}


@end
