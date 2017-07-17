//
//  guaoGaoModel.h
//  发发啦
//
//  Created by gxtc on 16/12/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface guaoGaoModel : NSObject

@property(nonatomic,copy)NSString * id_;
@property(nonatomic,copy)NSString * adtitle;
@property(nonatomic,copy)NSString * cdtitle;
@property(nonatomic,copy)NSString * adthumb;
@property(nonatomic,copy)NSString * adurl;
@property(nonatomic,copy)NSString * cname;
@property(nonatomic,copy)NSString * ctime;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;


@end
