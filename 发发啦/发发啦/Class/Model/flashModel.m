//
//  flashModel.m
//  发发啦
//
//  Created by gxtc on 16/11/9.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "flashModel.h"

@implementation flashModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.id_ = [NSString stringWithFormat:@"%@", dict[@"id"]];
        self.adtitle = [NSString stringWithFormat:@"%@", dict[@"adtitle"]];
        self.adthumb = [NSString stringWithFormat:@"%@", dict[@"adthumb"]];
        self.adurl = [NSString stringWithFormat:@"%@", dict[@"adurl"]];
        self.cname = [NSString stringWithFormat:@"%@", dict[@"cname"]];
        
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[flashModel alloc]initWithDictionary:dict];
    
    
}

@end
