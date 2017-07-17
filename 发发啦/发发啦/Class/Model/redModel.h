//
//  redModel.h
//  发发啦
//
//  Created by gxtc on 16/10/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userRedModel.h"

@interface redModel : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * friendTime;
@property(nonatomic,copy)NSString * hour;

@property(nonatomic,strong)NSMutableArray * manArray;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;

@end
