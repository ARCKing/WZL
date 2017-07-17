//
//  searchBarModel.h
//  发发啦
//
//  Created by gxtc on 16/10/25.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchBarModel : NSObject

@property(nonatomic,copy)NSString * id_;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * share_count;
@property(nonatomic,copy)NSString * ucshare;
@property(nonatomic,copy)NSString * thumb;
@property(nonatomic,copy)NSString * share;
@property(nonatomic,copy)NSString * abstract;
@property(nonatomic,copy)NSString * detail;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
