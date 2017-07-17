//
//  dayTaskModel.h
//  发发啦
//
//  Created by gxtc on 16/11/8.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dayTaskModel : NSObject
@property(nonatomic,copy)NSString * member_id;
@property(nonatomic,copy)NSString * day;
@property(nonatomic,copy)NSString * share_article;
@property(nonatomic,copy)NSString * invite;
@property(nonatomic,copy)NSString * read;
@property(nonatomic,copy)NSString * share;



- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
