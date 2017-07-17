//
//  UserInfos.h
//  发发啦
//
//  Created by gxtc on 16/9/1.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfos : NSObject

@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * token;
//@property(nonatomic,copy)NSString * sex;
//@property(nonatomic,copy)NSString * city;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;

@end
