//
//  newTaskModel.h
//  发发啦
//
//  Created by gxtc on 16/11/9.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newTaskModel : NSObject
@property(nonatomic,copy)NSString * member_id;
@property(nonatomic,copy)NSString * done_profile;
@property(nonatomic,copy)NSString * invite_friend;
@property(nonatomic,copy)NSString * sign_money;
@property(nonatomic,copy)NSString * share_article;
@property(nonatomic,strong)NSArray * articleArray;



- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
