//
//  articleOneTypeModel.h
//  发发啦
//
//  Created by gxtc on 16/10/21.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface articleOneTypeModel : NSObject

@property (nonatomic,copy)NSString * id_;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * c_id;
@property (nonatomic,copy)NSString * thumb;
@property (nonatomic,copy)NSString * view_count;
@property (nonatomic,copy)NSString * addtime;
@property (nonatomic,copy)NSString * video;
@property (nonatomic,copy)NSString * abstract;
@property (nonatomic,copy)NSString * share_count;
@property (nonatomic,copy)NSString * share;
@property(nonatomic,copy)NSString * height_money;
@property(nonatomic,copy)NSString * detail;

@property(nonatomic,copy)NSString * ucshare;
@property(nonatomic,copy)NSString * qqshare;
@property(nonatomic,copy)NSString * read_price;

@property (nonatomic,copy)NSString * duotu;
@property (nonatomic,copy)NSString * imgUrl1;
@property (nonatomic,copy)NSString * imgUrl2;
@property (nonatomic,copy)NSString * imgUrl3;

//广告
@property (nonatomic,copy)NSString * id_2;
@property (nonatomic,copy)NSString * adtitle;
@property (nonatomic,copy)NSString * adthumb;
@property (nonatomic,copy)NSString * adurl;
@property (nonatomic,copy)NSString * cname;
@property (nonatomic,copy)NSString * cdtitle;
@property (nonatomic,copy)NSString * ctime;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict;
@end
