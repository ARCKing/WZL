//
//  QQgrooupModel.m
//  发发啦
//
//  Created by gxtc on 16/11/15.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "QQgrooupModel.h"

@implementation QQgrooupModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
      
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[QQgrooupModel alloc]initWithDictionary:dict];
    
}
@end
