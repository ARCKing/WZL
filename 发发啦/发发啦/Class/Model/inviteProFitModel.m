//
//  inviteProFitModel.m
//  发发啦
//
//  Created by gxtc on 16/11/3.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "inviteProFitModel.h"

@implementation inviteProFitModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
        
        
//        float money = [dict[@"money"] floatValue];
        self.money = [NSString stringWithFormat:@"%@",dict[@"money"]];
        
        
        if ([self.nickname isEqual:[NSNull null]]) {
            
            self.nickname =@"";
        }
        
        
        NSDictionary * title = dict[@"title"];
        self.title = title[@"title"];

        
    }
    return self;
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    return [[inviteProFitModel alloc]initWithDictionary:dict];
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"title"]) {
        
        NSDictionary * title = value;
        self.title = title[@"title"];

    }

    if ([key isEqualToString:@"id"]) {
        
        self.id_ = value;
    }

}

@end
