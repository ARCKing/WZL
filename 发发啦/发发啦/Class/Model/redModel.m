//
//  redModel.m
//  发发啦
//
//  Created by gxtc on 16/10/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "redModel.h"

@implementation redModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.manArray = [NSMutableArray new];
        
        self.title = dict[@"title"];
        self.friendTime = dict[@"friendTime"];
        self.hour = dict[@"hour"];
        
        
        NSArray * array;
        
        if ([dict[@"top3"] isEqual:[NSNull null]]) {
            
            
            
        }else{
        
            array = [NSArray arrayWithArray:dict[@"top3"]];
            
            for (NSDictionary * dic in array) {
            
                userRedModel * model = [userRedModel allocWitehDictionary:dic];
            
                [self.manArray addObject:model];
            
            }
        }
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[redModel alloc]initWithDictionary:dict];
    
    
}
@end
