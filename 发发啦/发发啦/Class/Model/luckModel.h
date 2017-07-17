//
//  luckModel.h
//  发发啦
//
//  Created by gxtc on 16/11/11.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface luckModel : NSObject
@property(nonatomic,copy)NSString * member_id;
@property(nonatomic,copy)NSString * money;
@property(nonatomic,copy)NSString * friendTime;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * nickname;



- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
