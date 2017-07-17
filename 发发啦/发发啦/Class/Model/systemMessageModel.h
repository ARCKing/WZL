//
//  systemMessageModel.h
//  发发啦
//
//  Created by gxtc on 16/10/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface systemMessageModel : UIView

@property(nonatomic,copy)NSString * id_;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * ptime;
@property(nonatomic,copy)NSString * read;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;

@end
