//
//  NetWork.m
//  发发啦
//
//  Created by gxtc on 16/8/24.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "NetWork.h"
#import "AFNetworking.h"
#import "UserInfos.h"
#import "userInComeRankModel.h"
#import "articleModel.h"
#import "userProFitModel.h"
#import "withDrawCashRecordModel.h"
#import "articleClassModel.h"
#import "articleOneTypeModel.h"
#import "articleRankModel.h"
#import "searchBarModel.h"
#import "systemMessageModel.h"
#import "redModel.h"
#import "redBigModel.h"
#import "inviteProFitModel.h"
#import "userCollectionArticleModel.h"
#import "flashModel.h"
#import "luckModel.h"
#import "memberModel.h"
#import "myPrenticeModel.h"
#import "guaoGaoModel.h"
#import "JSONModel.h"
#import "ImportArticleModel.h"

#define KURL @"http://wz.lgmdl.com"

@interface NetWork ()
@property(nonatomic,retain)UserInfos * userInfo;

@end


@implementation NetWork

#pragma mark- 用户注册
/** 用户注册*/
- (void)userRegisterWithUserName:(NSString *)userName
                     andPassWord:(NSString *)passWord
                   andRepassWord:(NSString *)repassWord
                   andSms_verify:(NSString *)sms_verify
                      andInviter:(NSString *)inviter
                       andOpenid:(NSString*)openid
                 andaccess_token:(NSString *)access_token
                     andDeviceId:(NSString *)deviceId{
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
//    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"phone"] = userName;
    dic[@"password"] = passWord;
    dic[@"code"] = sms_verify;
    dic[@"inviter"] = inviter;
    dic[@"openid"] = openid;
    dic[@"access_token"] = access_token;
    dic[@"deviceId"] = deviceId;
    NSLog(@"%@",dic);
    
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/register",KURL];
    
    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        self.messageRegisterBlock(code,responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];

    

}

#pragma mark-登入下修改密码
/** 用户登录状态下修改密码*/
- (void)userChangePassWordWithNewCode:(NSString *)newCode
                         andreNewCode:(NSString *)reNweCode
                               andUid:(NSString *)uid
                             andToken:(NSString *)token
                           andOldCode:(NSString *)oldCode{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    NSDictionary * dataDic = @{@"password":newCode,@"repassword":reNweCode,@"uid":uid,@"token":token,@"oldpassword":oldCode};
    NSLog(@"%@",dataDic);
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/editPassword",KURL];

    
    [manger POST:urls parameters:dataDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = responseObject[@"code"];
        NSString * message = responseObject[@"message"];
        
        NSLog(@"密码修改成功=%@,%@",code,message);
        
        self.changePassWordUnlogin(message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"密码修改失败！");
        NSLog(@"%@",error);
        
    }];
    

}

#pragma mark- 未登入下找回密码
/** 未登陆下-找回密码*/
- (void)userFindOutPassWorldWithPhone:(NSString *)phone
                 andPassword:(NSString *)passworld
                  andSnsCode:(NSString *)snsCode{

    NSLog(@"%@",phone);
    NSLog(@"%@",passworld);
    
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    NSDictionary * dataDic = @{@"phone":phone,@"password":passworld,@"code":snsCode};
    
    NSLog(@"%@",dataDic);
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/findPassword",KURL];

    [manger POST:urls parameters:dataDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = responseObject[@"code"];
        NSString * message = responseObject[@"message"];
        
        NSLog(@"找回密码成功=%@,%@",code,message);
        
        self.resetPassWord(message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"找回密码失败！");
        NSLog(@"%@",error);
        
    }];

}

#pragma mark- 用户登入
/** 用户登录*/
- (void)userLogInWithUserName:(NSString *)userName andPassWord:(NSString *)passWord{

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"phone"] = userName;
    dic[@"password"] = passWord;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/login",KURL];

    
    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        self.userInfo = [UserInfos allocWitehDictionary:responseObject[@"data"]];
//        
//        NSLog(@"userInfo = %@",_userInfo);
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        NSLog(@"%@",responseObject);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
        if ([code isEqualToString:@"1"]) {
            
            self.userInfo = [UserInfos allocWitehDictionary:responseObject[@"data"]];
            
            NSLog(@"userInfo => %@",self.userInfo.uid);
            NSLog(@"userInfo => %@",self.userInfo.token);
    
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        
            
            if ([userDefaults objectForKey:@"usermessage"] == nil) {
                NSMutableDictionary * dics = [NSMutableDictionary new];
//                dics[@"iconPath"] = nil;
                dics[@"uid"] = _userInfo.uid;
                dics[@"token"] = _userInfo.token;
               
                
                NSDictionary * dic = [NSDictionary dictionaryWithDictionary:dics];
                NSString * isLogIn = @"1";
                
                [userDefaults setObject:isLogIn forKey:@"isLogIn"];
                [userDefaults setObject:dic forKey:@"usermessage"];
                
                [userDefaults synchronize];
                
            }else{
            
                NSMutableDictionary * dics = [NSMutableDictionary dictionaryWithDictionary:[userDefaults objectForKey:@"usermessage"]];
               
                NSLog(@"dics=>%@",dics);
                
                NSLog(@"userInfo =>> %@",self.userInfo.uid);
                NSLog(@"userInfo =>> %@",self.userInfo.token);
                
                dics[@"uid"] = _userInfo.uid;
                dics[@"token"] = _userInfo.token;
                
                
                NSDictionary * dic = [NSDictionary dictionaryWithDictionary:dics];
                
                NSLog(@"%@",dic);
                
                NSString * isLogIn = @"1";
                
                [userDefaults setObject:isLogIn forKey:@"isLogIn"];
                [userDefaults setObject:dic forKey:@"usermessage"];
                
                [userDefaults synchronize];
            
                NSLog(@"userDefaul ==>>>%@",[userDefaults objectForKey:@"usermessage"]);
                
                
                
            
            }
            NSLog(@"[usermessage = %@]",[userDefaults objectForKey:@"usermessage"]);
            NSLog(@"[isLogIn = %@]",[userDefaults objectForKey:@"isLogIn"]);
            
        }
        
        
        self.messageLogInBlock(code,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}


#pragma mark- 获取验证码
/** 获取验证码*/
- (void)userGetSmsWithPhoneNumber:(NSString *)phone andType:(NSString *)type andSign:(NSString *)sign andImageCode:(NSString *)code{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    dic[@"phone"] = phone;
    dic[@"type"] = type;
    dic[@"sign"] = sign;
    dic[@"code"] = code;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/sendSms",KURL];

    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
        self.smsMessage(message,code);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        NSLog(@"%@",error);
    }];
    
}


#pragma mark- 获取微信token openId
- (void)weiXinLogin:(NSString * )code{
//http://wezula.oicp.net/Api/ApiV2/articleLists
    
    NSString * appid = @"wxeb07f2b9056ab6d3";
    NSString * secret = @"67ea944b14f9f4b548603cb0bb9076d0";
    
    
    NSString * url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",appid,secret,code];

    NSLog(@"%@",url);
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
#pragma mark- //如果报接受类型不一致请替换一致text/plain或别的
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];

    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSString * access_token = responseObject[@"access_token"];
        NSString * openid = [NSString stringWithFormat:@"%@",responseObject[@"openid"]];
        NSString * refresh_token = responseObject[@"refresh_token"];
        NSString * unionid = responseObject[@"unionid"];
        
        NSLog(@"%@\n%@\n%@\n%@",access_token,openid,refresh_token,unionid);
        
        
        if (access_token && openid &&unionid) {
        
            NSDictionary * dict = @{@"openid":openid,@"access_token":access_token,@"unionid":unionid};
            NSLog(@"%@",dict);

            [[NSNotificationCenter defaultCenter] postNotificationName:@"openid" object:nil userInfo:dict];
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bangDingWeiXin" object:nil userInfo:dict];

        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"token 获取失败！");
        NSLog(@"%@",error);
    }];
    
    
    

}



#pragma mark- 绑定微信
- (void)bangDingWeiXinWithToken:(NSString *)access_token andOpinid:(NSString *)openid andUnionid:(NSString *)unionid{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    dict[@"access_token"] = access_token;
    dict[@"openid"] = openid;
    dict[@"unionid"] = unionid;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/wxbinding",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Member/wxbinding"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
        
        self.weiXinBangDing(code,message);
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];



}


#pragma mark- 微信关注
- (void)weiXinGuanZhuStatues{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/subscribeBind",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Member/subscribeBind"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
        self.weiXinGuanZhu(code,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}

#pragma mark- 重新获取access_token
/**重新获取 access_token*/
- (void)access_tokenRefresh:(NSString *)refresh_token{


}


#pragma mark- 修改用户信息
/** 修改用户信息*/
- (void)newUserInfoChangeWithDic:(NSDictionary *)userInfoDic{

    NSLog(@"%@",userInfoDic);

    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    dict[@"uid"] = userInfoDic[@"uid"];
    dict[@"token"] = userInfoDic[@"token"];
    dict[@"nickname"] = userInfoDic[@"nickname"];
    dict[@"province"] = userInfoDic[@"province"];
    dict[@"city"] = userInfoDic[@"city"];
    dict[@"address"] = userInfoDic[@"address"];
    dict[@"industry"] = userInfoDic[@"industry"];
    dict[@"age"] = userInfoDic[@"age"];
    dict[@"monthly_income"] = userInfoDic[@"monthly_income"];

    NSString * sex = userInfoDic[@"sex"];

    
    if ([sex isEqualToString:@"男"]) {
        dict[@"sex"] = @"1";
    }else if([sex isEqualToString:@"女"]) {
        dict[@"sex"] = @"2";
    }else{
        dict[@"sex"] = @"0";
    }
    
    NSLog(@"%@",dict);
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/changeMember",KURL];

    
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger POST:urls parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSLog(@"修改信息=>message=%@",responseObject[@"message"]);
        NSLog(@"responseObject=>%@",responseObject);

        //提示框
        if ([code isEqualToString:@"1"]) {
            NSLog(@"1");
            NSLog(@"%@",responseObject[@"message"]);

            
            
            [self firstVcMessageGetOfNet];
            
            self.userInfoMessageB=^(NSString * message,BOOL bb){
            
                NSLog(@"%@",message);
                
            };
            
            
            self.userInfoCMB(code);
            
            
            
        }else{
            NSLog(@"0");
        
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];
    
}

#pragma mark- 签到领红包
/** 签到领红包*/
-  (void)customerSignGetMoney:(NSDictionary *)userInfoDic{

    
    NSLog(@"%@",userInfoDic);
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/sign",KURL];

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger POST:urls parameters:userInfoDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        NSLog(@"签到金额%@",responseObject[@"amount"]);
        
        self.userSign(responseObject[@"amount"],responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];

}

#pragma mark- 抢红包
/** 抢红包*/
- (void)customerGrabMoney:(NSDictionary *)userInfoDic{

    NSLog(@"%@",userInfoDic);
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger POST:@"http://vzlnew.8836561.cn/index.php?m=Apinews&c=MemberPublic&a=sign&id=$id" parameters:userInfoDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        NSLog(@"签到回调！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];

    
}

#pragma mark- 收益明细
/** 任务收益*/
- (void)userProfitDetailMessageWithUid:(NSString *)uid andToken:(NSString *)token andAction0:(NSString*)action0{

//    NSInteger uics = [uid integerValue];
//    NSInteger actions = [action integerValue];
//    
//    NSNumber * u = [NSNumber numberWithInteger:uics];
//    NSNumber * a = [NSNumber numberWithInteger:actions];
    NSMutableArray * dataArray = [NSMutableArray new];
    
    NSDictionary * dic = @{@"uid":uid,@"token":token,@"action":@"0"};
    
    NSLog(@"%@",dic);
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Profit/ProfitList",KURL];

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger POST:urls parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        NSArray * data = responseObject[@"data"];
        
        NSLog(@"code = %@",code);
        NSLog(@"message = %@",message);
        NSLog(@"data = %@",data);
        
//        NSString * task_income =  responseObject[@"task_income"];
        
        NSNumber * task_income = responseObject[@"task_income"];

        NSLog(@"%.2f",[task_income floatValue]);

        NSString * taskIncome = [NSString stringWithFormat:@"%.2f",[task_income floatValue]];
        
        if ([taskIncome isEqual:[NSNull null]]) {
            
            taskIncome = @"0";
        }else if(taskIncome == nil){
            
            taskIncome = @"0";
            
        }
        
        
        
        
        for (NSDictionary * dic in data) {
            
            userProFitModel * model = [userProFitModel allocWitehDictionary:dic];
            [dataArray addObject:model];
        }
        
        NSLog(@"%@",dataArray);
        
        self.userProfit(dataArray,taskIncome);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];

}

/** 邀请收益*/
- (void)userProfitDetailMessageWithUid:(NSString *)uid andToken:(NSString *)token andAction1:(NSString*)action1{
    
    //    NSInteger uics = [uid integerValue];
    //    NSInteger actions = [action integerValue];
    //
    //    NSNumber * u = [NSNumber numberWithInteger:uics];
    //    NSNumber * a = [NSNumber numberWithInteger:actions];
    NSMutableArray * dataArray = [NSMutableArray new];
    
    NSDictionary * dic = @{@"uid":uid,@"token":token,@"action":@"1"};
    
    NSLog(@"%@",dic);
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Profit/ProfitList",KURL];

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger POST:urls parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        NSArray * data = responseObject[@"data"];
        
        NSLog(@"code = %@",code);
        NSLog(@"message = %@",message);
        NSLog(@"data = %@",data);
        
        NSString * invite_income = responseObject[@"invite_income"];
        
        if ([invite_income isEqual:[NSNull null]]) {
            
            invite_income = @"0";
        }else if(invite_income == nil){
            
            invite_income = @"0";
            
        }else{
            
            invite_income = [NSString stringWithFormat:@"%@",invite_income];
        }

        
        for (NSDictionary * dic in data) {
            
            inviteProFitModel * model = [inviteProFitModel allocWitehDictionary:dic];
            [dataArray addObject:model];
        }
        
        NSLog(@"%@",dataArray);
        
        self.inviteProfit(dataArray,invite_income);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];
    
}



#pragma mark- 首页用户信息
/** 首页用户信息*/
- (void)firstVcMessageGetOfNet{

    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"usermessage"]];
    NSString * token = dic[@"token"];
    NSString * uid = dic[@"uid"];
    
    //危险
//    NSDictionary * dict = @{@"token":token,@"uid":uid};
    
    //这样初始化！！！！
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          uid, @"uid",
                          token, @"token",
                          nil ];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Index/index",KURL];

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger POST:urls parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        NSDictionary * data = responseObject[@"data"];
        NSDictionary * member = data[@"member"];
        NSDictionary * mission = data[@"mission"];
        if ([code isEqualToString:@"0"] || mission == nil) {
            return ;
        }
        NSLog(@"code = %@;message = %@",code,message);
        
        NSLog(@"member = %@",member);
//==============
        memberModel * model = [memberModel allocWithDict:responseObject[@"data"][@"member"]];
        
        NSNumber * taskMoney = model.task_Money;
        
        NSString * task_Money = [NSString stringWithFormat:@"%.2f",[taskMoney floatValue ]];
        
        
        dic[@"is_wach"] = [NSString stringWithFormat:@"%@",model.is_wach];
        
        dic[@"task_Money"] = task_Money;
        dic[@"level"] = model.levels;
        dic[@"id"] = model.id_;
        dic[@"uc_id"] = model.uc_id;
        dic[@"integral"] = model.integral;
        dic[@"sum_money"] = model.sum_money;
        dic[@"residue_money"] = model.residue_money;
        dic[@"duobao"] = model.duobao;
        dic[@"prentice_sum_money"] = model.prentice_sum_money;
        dic[@"openid"] = model.openid;
        dic[@"is_auth"] = model.is_auth;
        dic[@"is_bind"] = model.is_bind;
        dic[@"phone"] = model.phone;
        dic[@"nickname"] = model.nickname;
        dic[@"sex"] = model.sex;
        dic[@"province"] = model.province;
        dic[@"city"] = model.city;
        dic[@"country"] = model.country;
        dic[@"headimgurl"] = model.headimgurl;
        dic[@"privilege"] = model.privilege;
        dic[@"unionid"] = model.unionid;
        dic[@"state"] = model.state;
        dic[@"inputtime"] = model.inputtime;
        dic[@"lasttime"] = model.lasttime;
        dic[@"inviter"] = model.inviter;
        dic[@"new_hb"] = model.my_new_hb;
        dic[@"new_jiaochen"] = model.my_new_jiaochen;
        dic[@"ouid"] = model.ouid;
        dic[@"oiv"] = model.oiv;
        dic[@"is_inviter_re"] = model.is_inviter_re;
        dic[@"password"] = model.password;
        dic[@"salt"] = model.salt;
        dic[@"regip"] = model.regip;
        dic[@"address"] = model.address;
        dic[@"industry"] = model.industry;
        dic[@"age"] = model.age;
        dic[@"monthly_income"] = model.monthly_income;
        dic[@"new_member_task"] = model.my_new_member_task;
        dic[@"member_id"] = model.member_id;
        dic[@"avatar_100"] = model.avatar_100;
        dic[@"avatar_200"] = model.avatar_200;
        dic[@"day"] = model.day;
        dic[@"today_income"] = model.today_income;
        dic[@"today_prentice"] = model.today_prentice;
        dic[@"yesterDay_income"] = model.yesterDay_income;
        dic[@"member_auth"] = model.member_auth;
        dic[@"level"] = model.level;
        dic[@"rate"] = model.rate;
        dic[@"prentice_num"] = model.prentice_num;
        dic[@"task_income_sum_"] = model.task_income_sum_;
        dic[@"invite_income_sum_"] = model.invite_income_sum_;
        dic[@"shoutu_url"] = model.shoutu_url;
        dic[@"app_shoutu_url"] = model.app_shoutu_url;



//        [dic setObject:isShowNewUserGift forKey:@"isShowNewUserGift"];

        
        NSDictionary * userData = [NSDictionary dictionaryWithDictionary:dic];
        
        [defaults setObject:userData forKey:@"usermessage"];
        
        
       BOOL save =  [defaults synchronize];
        
        
        if (save == YES) {
            
            NSLog(@"保存成功");

        }else{
            NSLog(@"保存失败");

        
        }
        
        
        NSLog(@"userData = %@",userData);
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"userInfo" object:nil];
        
        self.userInfoMessageB(message,save);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];


}

#pragma mark- 首页文章-广告-文章信息
/** 首页文章信息*/
//@"http://wzlwz.mdngx.com/App/Index/index"


- (void)firstVcMessageOfArticle{

    NSString * urls = [NSString stringWithFormat:@"%@/App/Index/index",KURL];

    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dic = [defaul objectForKey:@"usermessage"];
    
    NSString * uid = dic[@"uid"];
    NSString * token = dic[@"token"];
    
    if (uid == nil) {
        
        uid = @"1";
    }
    
    
    
#warning !!!!!
    //这样初始化！！！！
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                         uid, @"uid",
                         token, @"token",
                          nil ];
    NSLog(@"%@",dict);
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger POST:urls parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //文章
        NSMutableArray * array = [NSMutableArray new];
        //flash
        NSMutableArray * array2 = [NSMutableArray new];
        //广告
        NSMutableArray * array1 = [NSMutableArray new];

        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        NSLog(@"code = %@",responseObject[@"code"]);
        NSLog(@"message %@",responseObject[@"message"]);
        NSString * type;
        NSString * img_url;
        
        
        
        NSLog(@"---------->%@",responseObject);
        
        
        if ([code isEqualToString:@"1"]) {
            
            NSDictionary * dict = responseObject[@"data"];
        
            
            type = [NSString stringWithFormat:@"%@",dict[@"type"]];
            img_url = dict[@"img_url"];

            
            if (dict[@"article"] != [NSNull null]) {
                
                if (dict[@"article"] != nil) {
            
                    for (NSDictionary * dic in dict[@"article"]) {
            
                        articleModel * model = [articleModel allocWitehDictionary:dic];
            
                        [array addObject:model];
                    }
                }
            }
            
            
            NSDictionary * ad = dict[@"ad"];
            
            if (ad[@"flash"] != [NSNull null]) {
                
                if (ad[@"flash"] != nil) {
                    
                    for (NSDictionary * dic in ad[@"flash"]) {
                    
                        flashModel * model = [[flashModel alloc]initWithDictionary:dic];
            
                        [array2 addObject:model];
                    }
                }
        
            }
            
            
            BOOL isNull = [ad[@"baidu"] isEqual:[NSNull null]];
            
            if (isNull == NO ) {
                
                NSArray * array0 = ad[@"baidu"];

                for (NSDictionary * dic in array0) {
                    guaoGaoModel * model = [guaoGaoModel allocWitehDictionary:dic];
                    [array1 addObject:model];
                }
                
            }
            
            
        }
      
        
        NSLog(@"%@",array1);
        
        self.fistVcBlock(array,array2,array1,type,img_url);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];

}



#pragma mark- 收入排行用户信息
/** 收入排行用户信息*/
- (void)userInComeRankDataSourceFromNet{

    NSString * urls = [NSString stringWithFormat:@"%@/App/Index/Ranking",KURL];

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
[manger GET:urls parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    NSLog(@"%@",responseObject[@"code"]);
    NSLog(@"%@",responseObject[@"message"]);
    
    NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
    
    if ([code isEqualToString:@"1"]) {
    NSArray * array = responseObject[@"data"];
        NSMutableArray * data = [NSMutableArray new];
        for (NSDictionary * dic in array) {
            userInComeRankModel * userIncome = [userInComeRankModel allocWitehDictionary:dic];
            [data addObject:userIncome];
        }
    
        NSLog(@"%@",data);
        
        
        self.incomeRankBlock(data);
    }
    
    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
}];
    
}


#pragma mark- 头像上传
- (void)userIconUpLoadToPhp:(NSData *)data{
    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * dic = [defaul objectForKey:@"usermessage"];
    
    NSString * uid = dic[@"uid"];
    NSString * token = dic[@"token"];
    
    NSDictionary * dict = @{@"uid":uid,@"token":token,};
    NSLog(@"%@",dict);
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/member/avatar",KURL];

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger POST:urls parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /**
         *  appendPartWithFileData   //  指定上传的文件
         *  name                    //  指定在服务器中获取对应文件或文本时的key
         *  fileName                //  指定上传文件的原始文件名
         *  mimeType                //  指定文件的类型
         */
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         NSLog(@"Success: %@", responseObject[@"code"]);

         NSLog(@"Success: %@", responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        BOOL succeeds = NO;
        
        if ([code isEqualToString:@"1"]) {
            
            succeeds = YES;
        }
        
        self.iconUpLoadB(responseObject[@"message"],succeeds);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
    }];
    
}

#pragma mark- 支付宝显示金额
- (void)cashAboutAliPay:(NSString *)uid andToken:(NSString *)token{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"uid"] = uid;
    dic[@"token"] = token;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Exchange/alipay",KURL];

    
    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        
        if ([code isEqualToString:@"1"]) {
        NSArray * data = responseObject[@"data"];
        NSLog(@"data = %@",data);
        self.aliPayCash(data);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}

#pragma mark- 微信显示金额
- (void)cashAboutWeiXin:(NSString *)uid andToken:(NSString *)token{
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"uid"] = uid;
    dic[@"token"] = token;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Exchange/wxpay",KURL];

    
    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];

        
        if ([code isEqualToString:@"1"] || [code isEqualToString:@"2"]) {
            NSArray * data = responseObject[@"data"];
            NSLog(@"data = %@",data);
            
            self.weiXinCash(data,code,message);
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}




#pragma mark- 请求支付宝-微信提现
- (void)userWithDrawAboutAliPayWitUid:(NSString *)uid
                             andToken:(NSString *)token
                             andPrice:(NSString *)price
                       andAlipayAcount:(NSString *)aliPayAcount
                          andRealName:(NSString *)realName angButtonTag:(NSInteger)tag{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    NSString * urls1 = [NSString stringWithFormat:@"%@/App/Exchange/handleWxpay",KURL];
    
    NSString * urls2 = [NSString stringWithFormat:@"%@/App/Exchange/handleAlipay",KURL];

    
    NSString * url;
    
    if (tag == 8889) {
        
        dic[@"uid"] = uid;
        dic[@"token"] = token;
        dic[@"price"] = price;
        
        url = urls1;
        
    }else if (tag == 8888) {
       dic[@"uid"] = uid;
       dic[@"token"] = token;
       dic[@"price"] = price;
       dic[@"alipay"] = aliPayAcount;
       dic[@"realname"] = realName;
        
        url = urls2;
    }
    
    [manger POST:url parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        self.aliPayMessage(responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}

#pragma mark- 提现记录
- (void)withDrawCashRecordWithUid:(NSString *)uid andToken:(NSString *)token{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Exchange/record"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Exchange/record",KURL];

    
    dic[@"uid"] = uid;
    dic[@"token"] = token;
    
    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * dataArray = [NSMutableArray new];
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([code isEqualToString:@"1"]) {
            
            NSArray * data = responseObject[@"data"];
        
            for (NSDictionary * dic in data) {
            
                withDrawCashRecordModel * model = [withDrawCashRecordModel allocWitehDictionary:dic];
            
                [dataArray addObject:model];
            
            }
        }
        
        NSLog(@"%@",dataArray);
        
        self.weiXinPayCash(dataArray);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}


#pragma mark- 文章频道分类
- (void)getArticleClassFromNet{
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Article/getClass",KURL];

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:urls parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        NSMutableArray * array = [NSMutableArray new];
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
    
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        
        if ([code isEqualToString:@"1"]) {
            
        NSArray * data = responseObject[@"data"];

            
        for (NSDictionary * dic in data) {
            articleClassModel * model = [articleClassModel allocWithDictionary:dic];
            [array addObject:model];
        }
        
        NSLog(@"%@",array);

        self.articleClass(array);
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        NSLog(@"error = %@",error);
        
    }];

}


#pragma mark- 文章列表
/** 文章列表 */
- (void)articleListGetFromNetWithC_id:(NSInteger)c_id andPageIndex:(NSInteger)pageIndex{

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];

    NSString * isLogIn = [userDefaults objectForKey:@"isLogIn"];
    
    NSDictionary * userDic = [userDefaults objectForKey:@"usermessage"];
    
    NSLog(@"%@",userDic);
    
    NSString * is_wach = @"0";
    NSString * uid = @"0";
    
    if ([isLogIn isEqualToString:@"1"]) {
        
        is_wach = userDic[@"is_wach"];
        uid = userDic[@"uid"];
        
    }
   
    
    
       
    NSString * cid = [NSString stringWithFormat:@"%ld",c_id];
    NSString * page = [NSString stringWithFormat:@"%ld",pageIndex];
    
    NSDictionary * dic = @{@"c_id":cid,@"pageIndex":page,@"is_wach":is_wach,@"uid":uid};
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Article/article",KURL];

    
    [manger GET:urls parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * array = [NSMutableArray new];
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        
        if ([code isEqualToString:@"1"]) {
            
            NSArray * data = responseObject[@"data"];
            
            
            for (NSDictionary * dic in data) {
                
                articleOneTypeModel * model = [articleOneTypeModel allocWitehDictionary:dic];
                [array addObject:model];
            }
            
            NSLog(@"%@",array);
            
        }
        
        self.articleList(array);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


#pragma mark- 文章排行网络请求
- (void)articleRankListGetFromNetWithTime:(NSInteger)time{
    NSString * tim = [NSString stringWithFormat:@"%ld",time];
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Article/getclickban",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Article/getclickban"];
    dic[@"time"] = tim;
    
    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * dataArray = [NSMutableArray new];
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([code isEqualToString:@"1"]) {
            NSArray * data = responseObject[@"data"];
            
            for (NSDictionary * dic in data) {
            articleRankModel * model = [articleRankModel allocWitehDictionary:dic];
            [dataArray addObject:model];
            
            }
        }
        
        NSLog(@"%@",dataArray);
        
        self.articleList(dataArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}


#pragma mark- 搜索框网络请求
- (void)searchBarGetDataFromNetWithTitle:(NSString *)title{
    
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Article/search",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Article/search"];
    dic[@"title"] = title;
    
    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * dataArray = [NSMutableArray new];
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([code isEqualToString:@"1"]) {
            NSArray * data = responseObject[@"data"];
            
            for (NSDictionary * dic in data) {
                searchBarModel * model = [searchBarModel allocWitehDictionary:dic];
                [dataArray addObject:model];
            }
        }
        
        NSLog(@"%@",dataArray);
        
        self.searchBarResoult(dataArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}

#pragma mark- 阅读计时任务完成
- (void)readeRecordTimeTaskFinish{


    
}

#pragma mark- 系统消息
- (void)systemMessageGetFromNetWithPage:(NSInteger)page{

    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermessage"];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    dic[@"token"] = dict[@"token"];
    dic[@"uid"] = dict[@"uid"];
    dic[@"page"] = [NSString stringWithFormat:@"%ld",page];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Notice/index",KURL];

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:urls parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * array = [NSMutableArray new];
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        
        if ([code isEqualToString:@"1"]) {
            
            NSArray * data = responseObject[@"data"];
            
            
            for (NSDictionary * dic in data) {
                
                systemMessageModel * model = [systemMessageModel allocWitehDictionary:dic];
                [array addObject:model];
            }
            
            NSLog(@"%@",array);
            
        }
        
        self.systemMessage(array);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];


}


#pragma mark- 抢红包列表
- (void)grabRedDataMessage{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"]=dic[@"token"];
    dict[@"uid"]=dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/moneygift/giftlist",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/moneygift/giftlist"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * dataArray = [NSMutableArray new];
        NSMutableArray * articleMuArray = [NSMutableArray new];
        redBigModel * bigModel = [[redBigModel alloc]init];

        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([code isEqualToString:@"1"]) {
            NSDictionary * data = responseObject[@"data"];
            
            if ((int)data.count > 0) {
                
                if (!data[@"list"]) {
                    return ;
                }
                
                for (NSDictionary * dict in data[@"list"]) {
                    
                    
                    
                    
                    redModel * model = [redModel allocWitehDictionary:dict];
                    
                    [dataArray addObject:model];
                }

                
                bigModel.next = data[@"next"];
                
                
                NSArray * articleArray = data[@"article"];
                
                for (NSDictionary * dictionary in articleArray) {
                    
                    articleModel * model = [articleModel allocWitehDictionary:dictionary];
                    
                    [articleMuArray addObject:model];
                }
                
                bigModel.articleModelArray = [NSArray arrayWithArray:articleMuArray];
                bigModel.redModelArray = [NSArray arrayWithArray:dataArray];
                
            }
        }
        
        NSLog(@"%@",bigModel);
        
        self.redBigBlock(bigModel);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}


#pragma mark- 抢红包
- (void)starGrabRedMoneyWithHour:(NSString *)hour{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"]=dic[@"token"];
    dict[@"uid"]=dic[@"uid"];
    dict[@"h"] = hour;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/moneygift/catchMoney",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/moneygift/catchMoney"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];

        NSString * data;
        if ([code isEqualToString:@"0"]) {
            
            data = message;
            
        }else{
        
            data = [NSString stringWithFormat:@"获得%@元",responseObject[@"data"]];
            
        }
        
        self.grabMoner(data);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}


#pragma mark- 抢红包手气
- (void)luckListWithHour:(NSString *)hour{
 
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"]=dic[@"token"];
    dict[@"uid"]=dic[@"uid"];
    dict[@"hour"] = hour;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/moneygift/viewDetail",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/moneygift/viewDetail"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        NSMutableArray * dataArray = [NSMutableArray new];
        
        
        if ([code isEqualToString:@"1"]) {
            
            if (responseObject[@"data"] != [NSNull null]){
            
                NSArray * data = [NSArray arrayWithArray:responseObject[@"data"]];

            
                for (NSDictionary * dic in data) {
                
                    luckModel * model = [[luckModel alloc]initWithDictionary:dic];
                    [dataArray addObject:model];
                
                }
                
            }
        }
        
        self.luckRedModel(dataArray);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}


#pragma mark- 联系我们
- (void)contactUSFromNet{

    NSString * urls = [NSString stringWithFormat:@"%@/App/Connect/index",KURL];

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:urls parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        
        if ([code isEqualToString:@"1"]) {
            
            NSDictionary * data = responseObject[@"data"];
            
            contactUsModel * model = [[contactUsModel alloc]initWithDictionary:data];
        
            self.contactUsModelBackBlock(model);
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];


}

#pragma mark- 请求分享链接
- (void)getShareLinkFromNet{

    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermessage"];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    dic[@"token"] = dict[@"token"];
    dic[@"uid"] = dict[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Prentice/getInviterUrl",KURL];

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:urls parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * url = [NSString new];
        NSString * imgUrl = [NSString new];
        
        NSLog(@"code=%@",responseObject[@"code"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([code isEqualToString:@"1"]) {
            
            url = responseObject[@"url"];
            imgUrl = responseObject[@"imgUrl"];
        }
        
        self.shareLinkBackBlock(url,imgUrl);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];


}



#pragma mark-阅读赚开始阅读
- (void)readBeginStar{

    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermessage"];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    dic[@"token"] = dict[@"token"];
    dic[@"uid"] = dict[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Mission/beginRead",KURL];

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:urls parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"【开始阅读】code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);

        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        self.readEarnB(code,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];

}


#pragma mark-阅读赚结束阅读
- (void)readEnd{

    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermessage"];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    dic[@"token"] = dict[@"token"];
    dic[@"uid"] = dict[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Mission/endRead",KURL];

    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:urls parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"【阅读赚结束】code=%@",responseObject[@"code"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        NSLog(@"message=%@",responseObject[@"message"]);
        
        self.readEarnFinishB(code);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];


}


#pragma mark- 分享次数统计
- (void)shareTimesRecoard:(NSString *)id_{
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"id"] = id_;
    NSLog(@"%@",id_);
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Article/addShare",KURL];

    [manger GET:urls parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];

}


#pragma mark- 验证token

- (void)checkingUserToken{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"]=dic[@"token"];
    dict[@"uid"]=dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Collection/index",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Collection/index"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        NSLog(@"code = %@",code);
        
        self.checkingToken(code);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}

//获取用户头像
- (void)getUserIconFromNet:(NSString *)url{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"message=%@",responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


//唤醒徒弟
- (void)wakeUpTuDi{
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"]=dic[@"token"];
    dict[@"uid"]=dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/wakePrentice",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Member/wakePrentice"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];

        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        NSLog(@"code = %@",code);
        
        self.tuDiBlock(message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];



}



#pragma mark- 享立赚内容
- (void)shareEarn{

    NSString * urls = [NSString stringWithFormat:@"%@/App/Index/shareList",KURL];

//    NSString * url = @"http://wz.lefei.com/App/Index/shareList";
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:urls parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
        NSLog(@"code = %@ message = %@",code,message);
        
        NSMutableArray * dataArray = [NSMutableArray new];
        
        if ([code isEqualToString:@"1"]) {
            
            NSArray * arr = responseObject[@"data"];
            
            for (NSDictionary * dict in arr) {
                
                shareEarnModel * model = [[shareEarnModel alloc]initWithDictionary:dict];
                
                [dataArray addObject:model];
            }
            
            
        }
        
        self.shareEarnBlock(dataArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    

}

#pragma mark- 享立赚分享成功
- (void)shareEatnSucceeds:(shareEarnModel *)model{

    NSString * urls = [NSString stringWithFormat:@"%@/App/Mission/share_now",KURL];

//    NSString * url = @"http://wz.lefei.com/App/Mission/share_now";
    
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"]=dic[@"token"];
    dict[@"uid"]=dic[@"uid"];
    dict[@"id"]=model.id_;
    dict[@"money"] = model.money;
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:urls parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
        if (message == nil) {
            
            message = @"error";
        }
        
        NSLog(@"code = %@ message = %@",code,message);
        
        
        self.shareEarnSucceed(code,message);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];


}


#pragma mark- 显示我的收藏
- (void)userCollectionArticleShow{
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"]=dic[@"token"];
    dict[@"uid"]=dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Collection/index",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Collection/index"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * dataArray = [NSMutableArray new];
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([code isEqualToString:@"1"]) {
            NSArray * data = responseObject[@"data"];
            
            if (data) {
                for (NSDictionary * dic in data) {
                    userCollectionArticleModel * model = [userCollectionArticleModel allocWitehDictionary:dic];
                    [dataArray addObject:model];
                }
            }
        }
        
        NSLog(@"%@",dataArray);
        
        self.userArticleCollection(dataArray);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}



#pragma mark- 添加收藏
- (void)addMyArticleCollectionWithAid:(NSString *)aid{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    dict[@"aid"] = aid;
    dict[@"deviceid"] = @"ios";
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Collection/addMemberCollection",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Collection/addMemberCollection"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];

       
        self.addArticleCollect(code,message);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}

#pragma mark- 取消收藏
- (void)cancleMyArticleCollectionWithAid:(NSString *)aid{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    dict[@"aid"] = aid;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Collection/cancelMemberCollection",KURL];

    
//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Collection/cancelMemberCollection"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        
        self.cancleArticleCollect(code,message);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}


#pragma mark- 每日任务达成状况
- (void)dayTaskAchiveStatus{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Mission/dayMission",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Mission/dayMission/"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        NSDictionary * data = responseObject[@"data"];
        
        if ([code isEqualToString:@"1"] && data) {
            
            dayTaskModel * model = [[dayTaskModel alloc]initWithDictionary:data];
            
            self.dayTaskStatusBlock(model);
            
        }else{
    
            self.dayTaskStatusBlock(nil);
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}


#pragma mark- 领取每日任务奖励
- (void)getTheDayTaskRewards{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Mission/TaskDay",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Mission/TaskDay"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        self.dayTaskFinish(code,message);
       
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}


#pragma mark-新手福利达成状况
- (void)newTaskFinishStatus{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Mission/newMemMission",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Mission/newMemMission/"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        NSDictionary * data = responseObject[@"data"];
        
        if ([code isEqualToString:@"1"] && data) {
            
            
            newTaskModel * model = [[newTaskModel alloc]initWithDictionary:data];
            
            self.newTaskStatusBlock(model);

        }else{
        
            self.newTaskStatusBlock(nil);
        }
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}

#pragma mark-领取新手红包
- (void)getTheNewTaskRewards{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Mission/TaskNew",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Mission/TaskNew"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
        self.newTaskFinish(code,message);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}


#pragma mark- 日月周收徒
- (void)shouTuOfType:(NSString *)type{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    dict[@"time"] = type;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Prentice/prenticeCount",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Prentice/prenticeCount"];
    
    [manger GET:urls parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        NSString * message = responseObject[@"message"];
        
        NSString * count = [NSString stringWithFormat:@"%@",responseObject[@"count"]];
        NSString * num = [NSString stringWithFormat:@"%@",responseObject[@"num"]];
        NSString * money = [NSString stringWithFormat:@"%@",responseObject[@"money"]];
        NSString * youxiao = [NSString stringWithFormat:@"%@",responseObject[@"youxiao"]];

        
        
        if ([num isEqual:[NSNull null]] || num == nil) {
            
            num = @"0";
        }
        
        
        if ([money isEqual:[NSNull null]] || money == nil) {
            
            money = @"0";
        }
        
        
        if ([count isEqual:[NSNull null]] || count == nil) {
            
            num = @"0";
        }
        
        
        if ([youxiao isEqual:[NSNull null]] || youxiao == nil) {
            
            money = @"0";
        }
        
        
        if ([code isEqualToString:@"0"]) {
            count = @"0";
            num = @"0";
            money = @"0";
            youxiao = @"0";
        }
        
        
        self.shoutu(count,num,money,youxiao);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];

}

#pragma mark- 领取收徒奖励

- (void)shouTuGift:(NSString *)type{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    dict[@"time"] = type;

    NSString * urls = [NSString stringWithFormat:@"%@/App/Prentice/getPrenticeMoney",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Prentice/getPrenticeMoney"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
        
        if ([code isEqualToString:@"1"]) {
            
            NSString * money = responseObject[@"money"];
            
            if ([money isEqual:[NSNull null]]) {
            
                money = @"0";
            }

            
            self.shoutuGift(message,money,nil,nil);
            
        }else{
        
            self.shoutuGift(message,nil,nil,nil);
        
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];



}


#pragma mark- 微信绑定页数据
- (void)weiXingBangDingStatusData{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/bind",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Member/bind"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        NSString * message = responseObject[@"message"];
        
        NSDictionary * data = responseObject[@"data"];
        
        if ([code isEqualToString:@"1"] &&data) {
            

            NSString * bind = [NSString stringWithFormat:@"%@",data[@"bind"]];
            NSString * exchange_publicno = [NSString stringWithFormat:@"%@",data[@"exchange_publicno"]];
            NSString * wxbind = [NSString stringWithFormat:@"%@", data[@"wxbind"]];
            
            self.weixingStatusBangDing(code,bind,wxbind,exchange_publicno);
            
        }else{
        
            self.weixingStatusBangDing(code,nil,nil,nil);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];


}



#pragma  mark- 领新手红包
- (void)newUserHongBao{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/lingqu",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Member/lingqu"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
        self.hongBao(code,message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];



}



#pragma mark- 系统消息详情
- (void)systemMessageDetail:(NSString *)id_{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    dict[@"id"] = id_;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Notice/detail",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Notice/detail"];
    
    [manger GET:urls parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        NSString * message = responseObject[@"message"];
        NSDictionary * data = responseObject[@"data"];
        
        if ([code isEqualToString:@"1"] && data) {
            
            NSString * title = data[@"title"];
            NSString * ptime = data[@"ptime"];
            NSString * content = data[@"content"];
            
            self.systemMessageDetail(title,ptime,content);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];


}


#pragma mark- 收徒列表
- (void)myPrenticeWithPage:(NSInteger)page{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    dict[@"page"] = [NSString stringWithFormat:@"%ld",page];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Prentice/getInviterList",KURL];

//    NSString * url = [NSString stringWithFormat:@"http://wz.lefei.com/App/Prentice/getInviterList"];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        NSString * message = responseObject[@"message"];
        NSArray * data = responseObject[@"data"];
        
        NSMutableArray * array = [NSMutableArray new];
        
        if ([code isEqualToString:@"1"] && (int)data.count > 0  ) {
            
            for (NSDictionary * dic in data) {
                myPrenticeModel * model = [myPrenticeModel allocWitehDictionary:dic];
                
                [array addObject:model];

            }
            
            
        }
        
        self.myPrenticeList(array);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}


#pragma mark- 系统消息全部已读
- (void)systemMessageReadAll{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
      NSString * urls = [NSString stringWithFormat:@"%@/App/Notice/readAll",KURL];

    [manger GET:urls parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = responseObject[@"message"];
        
    
        self.systemMessageReadAllB(message,code);
        
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];

}


#pragma mark- 抽奖链接
- (void)luckDrawForNewUser{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Member/getdrawUrl",KURL];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
//        NSLog(@"code=%@",responseObject[@"code"]);
//        NSLog(@"message=%@",responseObject[@"message"]);
//        
//        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        NSString * message = responseObject[@"message"];
        
        NSString * url = [NSString stringWithFormat:@"%@",responseObject[@"url"]];
        NSString * imgUrl = [NSString stringWithFormat:@"%@",responseObject[@"imgurl"]];
        
        self.luckDrawB (url,imgUrl);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    

}



#pragma mark- 高价分享
- (void)getHeightPriceUCshareLinkWithArticleID:(NSString *)aid andShareType:(NSString *)shareType{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
//    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    dict[@"id"] = aid;
    dict[@"type"] = shareType;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Article/gshare",KURL];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * dataUrl = @"0";
        
        if ([code isEqualToString:@"1"]) {
            
            dataUrl = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
        }
        
        self.heightPriceUCshareLinkBK(dataUrl);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}



#pragma mark- 原生分享链接
- (void)getLocationLinkWithArticleID:(NSString *)aid{
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    //    dict[@"token"] = dic[@"token"];
    dict[@"uid"] = dic[@"uid"];
    dict[@"id"] = aid;
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Article/fx",KURL];
    
    [manger POST:urls parameters:dict  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"code=%@",responseObject[@"code"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * dataUrl = @"0";
        
        if ([code isEqualToString:@"1"]) {
            
            dataUrl = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
        }
        
        self.lociationLinkBK(dataUrl);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}





#pragma mark-审核显示隐藏
- (void)isHiddenWhenReview{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSString * urls = [NSString stringWithFormat:@"%@/App/Index/get_state",KURL];
    
    [manger GET:urls parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        NSString * message = responseObject[@"message"];
        
        BOOL isHidden = YES;
        
        if ([code isEqualToString:@"1"]) {
            
            NSString * data = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            
            if ([data isEqualToString:@"1"]) {
                
                isHidden = NO;
            }
        }
        
        self.hiddenWhenReviewBK(code, isHidden);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];

}



/** 活动公告*/
- (void)noticeOfActivity{

    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSString * urls = [NSString stringWithFormat:@"%@/App/Index/get_hd",KURL];
    
    [manger POST:urls parameters:nil  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        //        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        NSString * imgUrl = @"0";
        NSString * wz = @"0";
        
        if ([code isEqualToString:@"1"]) {
            
            NSDictionary * data = responseObject[@"data"];
            
            imgUrl = [NSString stringWithFormat:@"%@",data[@"imgUrl"]];
            wz = [NSString stringWithFormat:@"%@",data[@"wz"]];
        }
        
        self.activityNoticBK(code, imgUrl, wz);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}




#pragma mark- 获取用户导入的文章
/**获取用户导入的文章*/
- (void)getCustomerAuditImportArticleWithPage:(NSInteger)page{
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSDictionary * dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"uid"] = dict[@"uid"];
    dic[@"token"] = dict[@"token"];
    dic[@"page"] = [NSString stringWithFormat:@"%ld",page];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Collection/UserCaiData",KURL];
    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        NSLog(@"responseObject=%@",responseObject);
        
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        NSMutableArray * dataModelArr = [NSMutableArray new];
        if ([code isEqualToString:@"1"]) {
            
            NSArray * data = [NSArray arrayWithArray:responseObject[@"data"]];
            
            if (data.count > 0) {
                
                for (NSDictionary * modelDic in data) {
                    
                    ImportArticleModel * model = [[ImportArticleModel alloc]initWithDictionary:modelDic error:nil];
                    
                    [dataModelArr addObject:model];
                }
            }
            
        }
        
        self.customerImportArticleListBK(code, message, nil, dataModelArr, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}

#pragma mark- 用户导入文章url
/**用户导入文章url*/
- (void)customerImportArticleURL:(NSString *)articleUrl andc_id:(NSString *)c_id{
    
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSDictionary * dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    dic[@"uid"] = dict[@"uid"];
    dic[@"c_id"] = c_id;
    dic[@"url"] = [NSString stringWithFormat:@"%@",articleUrl];
    
    NSString * urls = [NSString stringWithFormat:@"%@/App/Wxcai/wxCollect",KURL];
    [manger POST:urls parameters:dic  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"code=%@",responseObject[@"code"]);
        NSLog(@"message=%@",responseObject[@"message"]);
        NSLog(@"responseObject=%@",responseObject);
        NSString * code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        NSString * message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
        
        self.importArticleLinkBK(code, message);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
}



@end
