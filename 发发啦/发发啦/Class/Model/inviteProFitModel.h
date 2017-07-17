//
//  inviteProFitModel.h
//  发发啦
//
//  Created by gxtc on 16/11/3.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface inviteProFitModel : NSObject
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
@property (nonatomic,copy)NSString * nickname;
@property (nonatomic,copy)NSString * inviter_money;
@property (nonatomic,copy)NSString * title;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
