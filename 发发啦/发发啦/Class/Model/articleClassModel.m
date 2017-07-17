//
//  articleClassModel.m
//  发发啦
//
//  Created by gxtc on 16/10/21.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "articleClassModel.h"

@implementation articleClassModel



- (instancetype)initWithDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+ (instancetype)allocWithDictionary:(NSDictionary *)dict{


    return [[articleClassModel alloc]initWithDictionary:dict];

}





@end
