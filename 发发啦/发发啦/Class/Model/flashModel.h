//
//  flashModel.h
//  发发啦
//
//  Created by gxtc on 16/11/9.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface flashModel : NSObject
@property(nonatomic,copy)NSString * id_;
@property(nonatomic,copy)NSString * adtitle;
@property(nonatomic,copy)NSString * adthumb;
@property(nonatomic,copy)NSString * adurl;
@property(nonatomic,copy)NSString * cname;



- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;

@end
