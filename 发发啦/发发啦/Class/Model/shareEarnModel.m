//
//  shareEarnModel.m
//  发发啦
//
//  Created by gxtc on 16/11/5.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "shareEarnModel.h"

@implementation shareEarnModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
       
        
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    return [[shareEarnModel alloc]initWithDictionary:dict];
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        self.id_ = value;
    }

}

@end
