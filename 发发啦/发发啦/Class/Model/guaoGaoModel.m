//
//  guaoGaoModel.m
//  发发啦
//
//  Created by gxtc on 16/12/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "guaoGaoModel.h"

@implementation guaoGaoModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        
        self.id_ = dict[@"id"];
        self.adtitle = dict[@"adtitle"];
        self.adthumb = dict[@"adthumb"];
        self.adurl = dict[@"adurl"];
        self.cname = dict[@"cname"];
        self.cdtitle = dict[@"cdtitle"];
        self.ctime = dict[@"ctime"];
    }

    return  self;
}



+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{

    return [[guaoGaoModel alloc]initWithDictionary:dict];;
}



@end
