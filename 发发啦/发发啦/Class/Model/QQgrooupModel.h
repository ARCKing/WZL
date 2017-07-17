//
//  QQgrooupModel.h
//  发发啦
//
//  Created by gxtc on 16/11/15.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQgrooupModel : NSObject
@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString * qq;
@property(nonatomic,copy)NSString * az_key;
@property(nonatomic,copy)NSString * ios_key;



- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
