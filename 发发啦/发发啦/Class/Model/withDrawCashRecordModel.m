//
//  withDrawCashRecordModel.m
//  发发啦
//
//  Created by gxtc on 16/10/20.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "withDrawCashRecordModel.h"

@implementation withDrawCashRecordModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        
      
        self.addtime = dict[@"addtime"];
        self.bank_name = dict[@"bank_name"];
        self.cash_amount = dict[@"cash_amount"];
        self.status = dict[@"status"];
        self.note = dict[@"note"];
    }
    return self;
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    return [[withDrawCashRecordModel alloc]initWithDictionary:dict];
    
}

@end
