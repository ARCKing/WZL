//
//  UserInfos.m
//  发发啦
//
//  Created by gxtc on 16/9/1.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "UserInfos.h"

@interface UserInfos ()

@end

@implementation UserInfos


- (instancetype)initWithDictionary:(NSDictionary *)dict{

    
    if (self = [super init]) {
        self.uid = dict[@"uid"];
        self.token = dict[@"token"];
       
    }
    
    return self;

}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{


    return [[UserInfos alloc]initWithDictionary:dict];
    

}


@end
