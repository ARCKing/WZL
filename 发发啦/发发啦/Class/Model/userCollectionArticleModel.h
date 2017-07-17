//
//  userCollectionArticleModel.h
//  发发啦
//
//  Created by gxtc on 16/10/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userCollectionArticleModel : NSObject

@property(nonatomic,copy)NSString * id_;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * thumb;
@property(nonatomic,copy)NSString * addtime;
@property(nonatomic,copy)NSString * view_count;
@property(nonatomic,copy)NSString * url;
@property(nonatomic,copy)NSString * share_count;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;

@end
