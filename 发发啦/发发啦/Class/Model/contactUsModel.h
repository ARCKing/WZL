//
//  contactUsModel.h
//  发发啦
//
//  Created by gxtc on 16/11/2.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface contactUsModel : NSObject
@property(nonatomic,copy)NSString * qr;
@property(nonatomic,copy)NSString * wx_name;
@property(nonatomic,copy)NSString * service_tel;

@property(nonatomic,strong)NSArray * qq_group;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
