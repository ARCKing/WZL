//
//  memberModel.m
//  数据解析
//
//  Created by root on 16/11/13.
//  Copyright © 2016年 root. All rights reserved.
//

#import "memberModel.h"

@implementation memberModel

- (instancetype)initWithDict:(NSDictionary *)dict{

    NSLog(@"%@",dict);
    
    [self setValuesForKeysWithDictionary:dict];
    
    
    if (self.invite_income) {
        
        self.invite_income_sum_ = self.invite_income[@"invite_income_sum_"];
        
    }else{
    
        self.invite_income_sum_ = @"0";

        
    }
    
    
    if (self.task_income) {
        
        self.task_income_sum_ = self.task_income[@"task_income_sum_"];
        
    }else{
    
        self.task_income_sum_ = @"0";

    }
    
    
    
    if (self.today_info) {
        
        self.today_income = self.today_info[@"today_income"];
        self.today_prentice = self.today_info[@"today_prentice"];

    }else {
    
        self.today_income = @"0";
        self.today_prentice = @"0";
    }
    
    
    if (self.yesterDay_info) {
        
        self.yesterDay_income = self.yesterDay_info[@"yesterDay_income"];
        
    }else{
    
        self.yesterDay_income = @"0";

    }
    
    
    
    return self;
}


+ (instancetype)allocWithDict:(NSDictionary *)dict{

    return [[memberModel alloc]initWithDict:dict];

}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        
        self.id_ = value;
        
    } else if ([key isEqualToString:@"new_hb"]) {
        
        self.my_new_hb = value;
        
    } else if ([key isEqualToString:@"new_jiaochen"]) {
        
        self.my_new_jiaochen = value;
        
    } else if ([key isEqualToString:@"new_member_task"]) {
        
        self.my_new_member_task = value;
        
    }else if ([key isEqualToString:@"level"]) {
        
        self.levels = value;
    }
}


@end
