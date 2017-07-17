//
//  myPrenticeModel.m
//  发发啦
//
//  Created by gxtc on 16/11/23.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "myPrenticeModel.h"

@implementation myPrenticeModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];

    }
    
    return self;
    
}




- (void)setValue:(id)value forUndefinedKey:(NSString *)key{


}


+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[myPrenticeModel alloc]initWithDictionary:dict];
    
    
}




@end

