//
//  userProFitModel.h
//  发发啦
//
//  Created by gxtc on 16/10/19.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userProFitModel : NSObject

@property (nonatomic,copy)NSString * id_;
@property (nonatomic,copy)NSString * member_id;
@property (nonatomic,copy)NSString * action;
@property (nonatomic,copy)NSString * money;
@property (nonatomic,copy)NSString * addtime;
@property (nonatomic,copy)NSString * remark;
@property (nonatomic,copy)NSString * re_member_id;
@property (nonatomic,copy)NSString * account_state;
@property (nonatomic,copy)NSString * status;
@property (nonatomic,copy)NSString * type;
@property (nonatomic,strong)NSDictionary * title;
@property (nonatomic,copy)NSString * title_;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
