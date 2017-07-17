//
//  memberModel.h
//  数据解析
//
//  Created by root on 16/11/13.
//  Copyright © 2016年 root. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface memberModel : NSObject
//
//"id": "2520030",
//"uc_id": "30000001",
//"integral": "0.000",
//"sum_money": "33.200",
//"residue_money": "33.200",
//"duobao": "0",
//"prentice_sum_money": "0.000",
//"openid": "",
//"is_auth": "0",
//"is_bind": "0",
//"phone": "18276406340",
//"nickname": "Ddd",
//"sex": "0",
//"province": "广西壮族自治区",
//"city": "南宁市",
//"country": null,
//"headimgurl": "http://imgwzl1.lefei.com/photo/20161112/58269ee97689b.jpg",
//"privilege": null,
//"unionid": null,
//"state": "1",
//"inputtime": "1476432859",
//"lasttime": "1479009003",
//"inviter": "30000002",
//"new_hb": "0",
//"new_jiaochen": "0",
//"ouid": null,
//"oiv": "0",
//"is_inviter_re": "1",
//"password": "5eb4f33438d1d957fe98b533bada454b",
//"salt": "810882",
//"regip": "219.159.71.137",
//"address": "Gig",
//"industry": "其他",
//"age": "18",
//"monthly_income": "3001-4999",
//"new_member_task": "0",
//"member_id": "30000001",
//"avatar_100": "http://imgwzl1.lefei.com/photo/20161112/58269ee97689b.jpg",
//"avatar_200": "http://imgwzl1.lefei.com/photo/20161112/58269ee97689b.jpg",
//"day": "30",
//"today_info": {},
//"yesterDay_info": {},
//"member_auth": null,
//"level": "1",
//"rate": "0.16",
//"prentice_num": "0",
//"task_income": {},
//"invite_income": {},
//"shoutu_url": "http://wz.lefei.com/shoutu?u=30000001",
//"app_shoutu_url": "http://lalalaa.vicp.hk/shoutu?u=30000001"



@property(nonatomic ,copy)NSString * id_;
@property(nonatomic ,copy)NSString * uc_id;
@property(nonatomic ,copy)NSString * integral;
@property(nonatomic ,copy)NSString * sum_money;
@property(nonatomic ,copy)NSString * residue_money;
@property(nonatomic ,copy)NSString * duobao;
@property(nonatomic ,copy)NSString * prentice_sum_money;
@property(nonatomic ,copy)NSString * openid;
@property(nonatomic ,copy)NSString * is_auth;
@property(nonatomic ,copy)NSString * is_bind;
@property(nonatomic ,copy)NSString * phone;
@property(nonatomic ,copy)NSString * nickname;
@property(nonatomic ,copy)NSString * sex;
@property(nonatomic ,copy)NSString * province;
@property(nonatomic ,copy)NSString * city;
@property(nonatomic ,copy)NSString * country;
@property(nonatomic ,copy)NSString * headimgurl;
@property(nonatomic ,copy)NSString * privilege;
@property(nonatomic ,copy)NSString * unionid;
@property(nonatomic ,copy)NSString * state;
@property(nonatomic ,copy)NSString * inputtime;
@property(nonatomic ,copy)NSString * lasttime;
@property(nonatomic ,copy)NSString * inviter;
@property(nonatomic ,copy)NSString * my_new_hb;
@property(nonatomic ,copy)NSString * my_new_jiaochen;
@property(nonatomic ,copy)NSString * ouid;
@property(nonatomic ,copy)NSString * oiv;
@property(nonatomic ,copy)NSString * is_inviter_re;
@property(nonatomic ,copy)NSString * password;
@property(nonatomic ,copy)NSString * salt;
@property(nonatomic ,copy)NSString * regip;
@property(nonatomic ,copy)NSString * address;
@property(nonatomic ,copy)NSString * industry;
@property(nonatomic ,copy)NSString * age;
@property(nonatomic ,copy)NSString * monthly_income;
@property(nonatomic ,copy)NSString * my_new_member_task;
@property(nonatomic ,copy)NSString * member_id;
@property(nonatomic ,copy)NSString * avatar_100;
@property(nonatomic ,copy)NSString * avatar_200;
@property(nonatomic ,copy)NSString * day;

@property(nonatomic ,copy)NSDictionary * today_info;
@property(nonatomic ,copy)NSString * today_income;
@property(nonatomic ,copy)NSString * today_prentice;


@property(nonatomic ,copy)NSDictionary * yesterDay_info;
@property(nonatomic ,copy)NSString * yesterDay_income;


@property(nonatomic ,copy)NSString * member_auth;
@property(nonatomic ,copy)NSString * level;
@property(nonatomic ,copy)NSString * rate;
@property(nonatomic ,copy)NSString * prentice_num;

@property(nonatomic ,copy)NSDictionary * task_income;
@property(nonatomic ,copy)NSString * task_income_sum_;

@property(nonatomic ,copy)NSDictionary * invite_income;
@property(nonatomic ,copy)NSString * invite_income_sum_;

@property(nonatomic ,copy)NSString * shoutu_url;
@property(nonatomic ,copy)NSString * app_shoutu_url;
@property(nonatomic ,copy)NSNumber * task_Money;

@property(nonatomic ,copy)NSString * levels;

@property(nonatomic ,copy)NSString * is_wach;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)allocWithDict:(NSDictionary *)dict;
@end
