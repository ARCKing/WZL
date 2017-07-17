//
//  userInComeRankModel.h
//  发发啦
//
//  Created by gxtc on 16/10/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userInComeRankModel : NSObject
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * sum_money;
@property(nonatomic,copy)NSString * prentice_num;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
