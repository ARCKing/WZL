//
//  articleModel.h
//  发发啦
//
//  Created by gxtc on 16/10/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface articleModel : NSObject

@property(nonatomic,copy)NSString * id_;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * thumb;
@property(nonatomic,copy)NSString * addtime;
@property(nonatomic,copy)NSString * view_count;
@property(nonatomic,copy)NSString * thumb_1;
@property(nonatomic,copy)NSString * thumb_2;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * share_count;
@property(nonatomic,copy)NSString * pic_num;
@property(nonatomic,copy)NSString * height_money;
@property(nonatomic,copy)NSString * detail;
@property(nonatomic,copy)NSString * ucshare;
@property(nonatomic,copy)NSString * read_price;

@property(nonatomic,copy)NSString * qqshare;
@property(nonatomic,copy)NSString * share;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
