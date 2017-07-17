//
//  articleClassModel.h
//  发发啦
//
//  Created by gxtc on 16/10/21.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface articleClassModel : NSObject

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * c_id;
@property(nonatomic,copy)NSString * bgColor;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWithDictionary:(NSDictionary *)dict;

@end
