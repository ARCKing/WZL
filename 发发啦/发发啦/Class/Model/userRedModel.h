//
//  userRedModel.h
//  发发啦
//
//  Created by gxtc on 16/10/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface userRedModel : NSObject

@property(nonatomic,copy)NSString * member_id;
@property(nonatomic,copy)NSString * money;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * title;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;

@end
