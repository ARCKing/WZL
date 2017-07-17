//
//  userProFitModel.m
//  发发啦
//
//  Created by gxtc on 16/10/19.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "userProFitModel.h"

@implementation userProFitModel



- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];

        self.title_ = self.title[@"title"];
        
//        float money = [dict[@"money"] floatValue];
        
        self.money = [NSString stringWithFormat:@"%@",dict[@"money"]];
        
        
    }
    return self;
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{

    return [[userProFitModel alloc]initWithDictionary:dict];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.id_ = value;
    }
    
}
@end
