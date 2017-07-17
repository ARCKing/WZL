//
//  articleRankModel.h
//  发发啦
//
//  Created by gxtc on 16/10/24.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface articleRankModel : NSObject

@property (nonatomic,copy)NSString * id_;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * thumb;
@property (nonatomic,copy)NSString * view_count;
@property (nonatomic,copy)NSString * addtime;
@property (nonatomic,copy)NSString * video;
@property (nonatomic,copy)NSString * share_count;
@property (nonatomic,copy)NSString * detail;

@property (nonatomic,copy)NSString * duotu;
@property (nonatomic,copy)NSString * imgUrl1;
@property (nonatomic,copy)NSString * imgUrl2;
@property (nonatomic,copy)NSString * imgUrl3;

@property (nonatomic,copy)NSString * ucshare;
@property (nonatomic,copy)NSString * qqshare;
@property (nonatomic,copy)NSString * share;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;

@end
