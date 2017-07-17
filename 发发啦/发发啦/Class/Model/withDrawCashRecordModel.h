//
//  withDrawCashRecordModel.h
//  发发啦
//
//  Created by gxtc on 16/10/20.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface withDrawCashRecordModel : NSObject
@property (nonatomic,copy)NSString * addtime;
@property (nonatomic,copy)NSString * bank_name;
@property (nonatomic,copy)NSString * cash_amount;
@property (nonatomic,copy)NSString * status;
@property (nonatomic,copy)NSString * note;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
