//
//  shareEarnModel.h
//  发发啦
//
//  Created by gxtc on 16/11/5.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shareEarnModel : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * state;
@property(nonatomic,copy)NSString * share_count;
@property(nonatomic,copy)NSString * money;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * id_;
@property(nonatomic,copy)NSString * sort;
@property(nonatomic,copy)NSString * thumb;
@property(nonatomic,copy)NSString * addtime;



- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
