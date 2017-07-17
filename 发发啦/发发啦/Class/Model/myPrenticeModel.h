//
//  myPrenticeModel.h
//  发发啦
//
//  Created by gxtc on 16/11/23.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myPrenticeModel : NSObject
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * sum_money;
@property(nonatomic,copy)NSString * is_inviter_re;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * level;
@property(nonatomic,copy)NSString * inputtime;





- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;

@end
