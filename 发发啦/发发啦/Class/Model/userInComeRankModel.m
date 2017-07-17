//
//  userInComeRankModel.m
//  发发啦
//
//  Created by gxtc on 16/10/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "userInComeRankModel.h"

@interface userInComeRankModel()




@end

@implementation userInComeRankModel


- (instancetype)initWithDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        
        self.sum_money = dict[@"sum_money"];
        self.nickname = dict[@"nickname"];
        self.headimgurl = dict[@"headimgurl"];
        
        NSDictionary * dic = dict[@"level"];
        self.prentice_num = dic[@"prentice_num"];
        
    }
    
    return self;

}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{

    return [[userInComeRankModel alloc]initWithDictionary:dict];

}


@end
