//
//  NetWork.h
//  发发啦
//
//  Created by gxtc on 16/8/24.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "redBigModel.h"
#import "contactUsModel.h"
#import "dayTaskModel.h"
#import "newTaskModel.h"
#import "shareEarnModel.h"
#import "VersionModel.h"

typedef void(^MessageFromNetComeBackBolck) (NSString *,NSString *);

typedef void(^DataFromNetComeBackBolck) (NSString *,NSString *,NSString *,NSArray * ,NSArray *);


typedef void(^messageBackLogInBolck) (NSString *,NSString *);
typedef void(^messageBackRegisterBolck) (NSString *,NSString *);
typedef void(^resetPassWordUnLoginBlock) (NSString *);
typedef void(^userIncomeRankBlock) (NSArray *);
typedef void(^fistVcArticleBlock) (NSArray *,NSArray*,NSArray*,NSString*,NSString*);
typedef void(^userProfitDetailMessageBlock) (NSArray *,NSString *);
typedef void(^userSignBlock) (NSString * ,NSString *);
typedef void(^aliPayCashBlock) (NSArray *);
typedef void(^weiXinPayCashBlock) (NSArray *,NSString *,NSString *);

typedef void(^cashDrawMessage) (NSString *);
typedef void(^articleClassBlock) (NSArray *);
typedef void(^searchBarBlock) (NSArray *);
typedef void(^systemMessageBlock) (NSArray *);

typedef void(^dataMessageBlock) (NSArray *);

typedef void(^shareLinkBlock) (NSString * , NSString *);

typedef void(^checkingUserTokenBlock) (NSString *);
typedef void(^awakeUpTuDiBlock) (NSString *);

typedef void(^userAddArticleCollectBlock) (NSString *,NSString *);

typedef void(^smsMessageBlock) (NSString *,NSString*);


typedef void(^dataMessageBlock3) (dayTaskModel *);
typedef void(^dataMessageBlock4) (newTaskModel *);

typedef void(^dataMessageBlock2) (contactUsModel *);
typedef void(^redBigModelBlock) (redBigModel *);
typedef void(^grabRedMoneyBlock) (NSString *);
typedef void(^shareEarnSucceedBlock) (NSString *,NSString *);
typedef void(^dayTaskFinishBlock) (NSString *,NSString *);

typedef void(^shoutuBlock) (NSString *,NSString *,NSString*,NSString*);

typedef void(^bangDingWeiXinBlock) (NSString *,NSString *);
typedef void(^bangDingWeiXinStatusDataBlock) (NSString *,NSString*,NSString*,NSString*);

typedef void(^HongBaoBlock) (NSString *,NSString *);

typedef void(^systemMessageDetailBlock) (NSString *,NSString *,NSString *);

typedef void(^userIconImageUpLoadBlock) (NSString *,BOOL);
typedef void(^userInfoMessageBlock) (NSString *,BOOL);

typedef void(^systemMessageReadAllBlock) (NSString *,NSString *);

typedef void(^LuckDrawBlock) (NSString *,NSString *);

typedef void(^readEarnMoneyBlock) (NSString *,NSString *);

typedef void(^userInfoChangeMessagesBlock) (NSString *);

typedef void(^readEarnFinishBlock) (NSString *);

typedef void(^heightPriceUCShareLinkBlock) (NSString *);

typedef void(^isHiddenWhenReViewBlock) (NSString *,BOOL);

typedef void(^activityNoticeBlock) (NSString * ,NSString * ,NSString *);

@interface NetWork : NSObject

/**版本更新*/
@property(nonatomic,copy)DataFromNetComeBackBolck checkNewVewsionBK;

/**淘宝折扣详情页*/
@property(nonatomic,copy)DataFromNetComeBackBolck taoBaoDiscountListDetailBk;

/**淘宝折扣分类*/
@property(nonatomic,copy)DataFromNetComeBackBolck taoBaoDiscountChannelClassifyBK;

/**淘宝折扣分类列表*/
@property(nonatomic,copy)DataFromNetComeBackBolck taoBaoDiscountChannelClassifyListBk;

/**我导入的文章*/
@property(nonatomic,copy)DataFromNetComeBackBolck customerImportArticleListBK;

/**导入文章链接*/
@property(nonatomic,copy)MessageFromNetComeBackBolck importArticleLinkBK;

/**导入文章标题*/
@property(nonatomic,copy)MessageFromNetComeBackBolck importArticleTitleBK;

/**一点资讯文章数据*/
@property(nonatomic,copy)DataFromNetComeBackBolck yiDiZiXunArticleListBK;


@property(nonatomic,copy)activityNoticeBlock activityNoticBK;

@property(nonatomic,copy)isHiddenWhenReViewBlock hiddenWhenReviewBK;

@property(nonatomic,copy)heightPriceUCShareLinkBlock heightPriceUCshareLinkBK;

@property(nonatomic,copy)heightPriceUCShareLinkBlock lociationLinkBK;


@property(nonatomic,copy)readEarnFinishBlock readEarnFinishB;

@property(nonatomic,copy)userInfoChangeMessagesBlock userInfoCMB;

@property(nonatomic,copy)readEarnMoneyBlock readEarnB;

@property(nonatomic,copy)LuckDrawBlock luckDrawB;
@property(nonatomic,copy)systemMessageReadAllBlock systemMessageReadAllB;

@property(nonatomic,copy)userIconImageUpLoadBlock iconUpLoadB;
@property(nonatomic,copy)userInfoMessageBlock userInfoMessageB;

@property(nonatomic,copy)messageBackLogInBolck messageLogInBlock;
@property(nonatomic,copy)messageBackRegisterBolck messageRegisterBlock;
@property(nonatomic,copy)resetPassWordUnLoginBlock resetPassWord;
@property(nonatomic,copy)resetPassWordUnLoginBlock changePassWordUnlogin;

@property(nonatomic,copy)userIncomeRankBlock incomeRankBlock;
@property(nonatomic,copy)fistVcArticleBlock fistVcBlock;

@property(nonatomic,copy)userProfitDetailMessageBlock userProfit;
@property(nonatomic,copy)userProfitDetailMessageBlock inviteProfit;

@property(nonatomic,copy)userSignBlock userSign;

@property(nonatomic,copy)aliPayCashBlock aliPayCash;
@property(nonatomic,copy)aliPayCashBlock weiXinPayCash;
@property(nonatomic,copy)weiXinPayCashBlock weiXinCash;


@property(nonatomic,copy)cashDrawMessage aliPayMessage;
@property(nonatomic,copy)cashDrawMessage weixinPayMessage;
@property(nonatomic,copy)articleClassBlock articleClass;
@property(nonatomic,copy)articleClassBlock articleList;

@property(nonatomic,copy)searchBarBlock searchBarResoult;
@property(nonatomic,copy)systemMessageBlock systemMessage;

@property(nonatomic,copy)dataMessageBlock dataMessage;
@property(nonatomic,copy)dataMessageBlock luckRedModel;

@property(nonatomic,copy)dataMessageBlock shareEarnBlock;
@property(nonatomic,copy)dataMessageBlock userArticleCollection;
@property(nonatomic,copy)dataMessageBlock myPrenticeList;


@property(nonatomic,copy)redBigModelBlock redBigBlock;
@property(nonatomic,copy)dataMessageBlock3 dayTaskStatusBlock;
@property(nonatomic,copy)dataMessageBlock4 newTaskStatusBlock;

@property(nonatomic,copy)dataMessageBlock2 contactUsModelBackBlock;
@property(nonatomic,copy)shareLinkBlock shareLinkBackBlock;
@property(nonatomic,copy)checkingUserTokenBlock checkingToken;
@property(nonatomic,copy)awakeUpTuDiBlock tuDiBlock;
@property(nonatomic,copy)grabRedMoneyBlock grabMoner;

@property(nonatomic,copy)userAddArticleCollectBlock addArticleCollect;
@property(nonatomic,copy)userAddArticleCollectBlock cancleArticleCollect;
@property(nonatomic,copy)shareEarnSucceedBlock shareEarnSucceed;
@property(nonatomic,copy)dayTaskFinishBlock dayTaskFinish;
@property(nonatomic,copy)dayTaskFinishBlock newTaskFinish;

@property(nonatomic,copy)shoutuBlock shoutu;
@property(nonatomic,copy)shoutuBlock shoutuGift;
@property(nonatomic,copy)bangDingWeiXinBlock weiXinBangDing;
@property(nonatomic,copy)bangDingWeiXinBlock weiXinGuanZhu;

@property(nonatomic,copy)bangDingWeiXinStatusDataBlock weixingStatusBangDing;

@property(nonatomic,copy)smsMessageBlock smsMessage;
@property(nonatomic,copy)HongBaoBlock hongBao;

@property(nonatomic,copy)systemMessageDetailBlock systemMessageDetail;



/** 活动公告*/
- (void)noticeOfActivity;

/** 用户注册*/
- (void)userRegisterWithUserName:(NSString *)userName
                     andPassWord:(NSString *)passWord
                   andRepassWord:(NSString *)repassWord
                   andSms_verify:(NSString *)sms_verify
                      andInviter:(NSString *)inviter
                       andOpenid:(NSString*)openid
                 andaccess_token:(NSString *)access_token
                     andDeviceId:(NSString *)deviceId;

/** 用户登录*/
- (void)userLogInWithUserName:(NSString *)userName andPassWord:(NSString *)passWord;


/** 获取验证码*/
- (void)userGetSmsWithPhoneNumber:(NSString *)phone andType:(NSString *)type andSign:(NSString *)sign andImageCode:(NSString *)code;

/** 修改用户信息*/
- (void)newUserInfoChangeWithDic:(NSDictionary *)userInfoDic;

/** 微信登陆*/
- (void)weiXinLogin:(NSString * )code;

/** 签到领红包*/
-  (void)customerSignGetMoney:(NSDictionary *)userInfoDic;

/** 抢红包*/
- (void)customerGrabMoney:(NSDictionary *)userInfoDic;

/** 首页信息用户*/
- (void)firstVcMessageGetOfNet;

/** 首页文章信息*/
- (void)firstVcMessageOfArticle;

/** 收入排行用户信息*/
- (void)userInComeRankDataSourceFromNet;

#pragma mark-登入下修改密码
/** 用户登录状态下修改密码*/
- (void)userChangePassWordWithNewCode:(NSString *)newCode
                         andreNewCode:(NSString *)reNweCode
                               andUid:(NSString *)uid
                             andToken:(NSString *)token
                           andOldCode:(NSString *)oldCode;

#pragma mark- 未登入下找回密码
/** 未登陆下-找回密码*/
- (void)userFindOutPassWorldWithPhone:(NSString *)phone
                 andPassword:(NSString *)passworld
                  andSnsCode:(NSString *)snsCode;

#pragma mark- upLoadIcon
/** 上传头像*/
- (void)userIconUpLoadToPhp:(NSData *)data;

/** 收益明细*/
- (void)userProfitDetailMessageWithUid:(NSString *)uid andToken:(NSString *)token andAction0:(NSString *)action0;
- (void)userProfitDetailMessageWithUid:(NSString *)uid andToken:(NSString *)token andAction1:(NSString *)action1;

#pragma mark- 支付宝提现金额
/** 支付宝提现金额 */
- (void)cashAboutAliPay:(NSString *)uid andToken:(NSString *)token;

#pragma mark- 请求支付宝-微信提现
/** 请求支付宝-微信提现 */
- (void)userWithDrawAboutAliPayWitUid:(NSString *)uid
                             andToken:(NSString *)token
                             andPrice:(NSString *)price
                      andAlipayAcount:(NSString *)aliPayAcount
                          andRealName:(NSString *)realName
                         angButtonTag:(NSInteger)tag;


#pragma mark- 提现记录
/** 提现记录 */
- (void)withDrawCashRecordWithUid:(NSString *)uid andToken:(NSString *)token;


#pragma mark- 文章分类
/** 文章分类 */
- (void)getArticleClassFromNet;


#pragma mark- 文章列表
/** 文章列表 */
- (void)articleListGetFromNetWithC_id:(NSInteger)c_id andPageIndex:(NSInteger)pageIndex;


#pragma mark- 文章排行网络请求
/** 文章排行网络请求*/
- (void)articleRankListGetFromNetWithTime:(NSInteger)time;

#pragma mark- 搜索框网络请求
/** 搜索框网络请求*/
- (void)searchBarGetDataFromNetWithTitle:(NSString *)title;

#pragma mark- 阅读计时任务完成
/**阅读计时任务完成*/
- (void)readeRecordTimeTaskFinish;

#pragma mark- 系统消息
/**系统消息*/
- (void)systemMessageGetFromNetWithPage:(NSInteger)page;

#pragma mark- 显示我的收藏
/**显示我的收藏*/
- (void)userCollectionArticleShow;

#pragma mark- 抢红包列表
- (void)grabRedDataMessage;

#pragma mark- 抢红包
- (void)starGrabRedMoneyWithHour:(NSString *)hour;

#pragma mark- 抢红包手气
- (void)luckListWithHour:(NSString *)hour;

#pragma mark- 联系我们
- (void)contactUSFromNet;

#pragma mark- 请求分享链接
- (void)getShareLinkFromNet;


#pragma mark-阅读赚开始阅读
- (void)readBeginStar;

#pragma mark-阅读赚结束阅读
- (void)readEnd;

#pragma mark- 分享次数统计
- (void)shareTimesRecoard:(NSString *)id_;

#pragma mark- 验证token
- (void)checkingUserToken;

#pragma mark-获取用户头像
- (void)getUserIconFromNet:(NSString *)url;

#pragma mark- 唤醒徒弟
- (void)wakeUpTuDi;

#pragma mark- 享立赚内容
- (void)shareEarn;

#pragma mark- 享立赚分享成功
- (void)shareEatnSucceeds:(shareEarnModel*)model;

#pragma mark- 添加收藏
- (void)addMyArticleCollectionWithAid:(NSString *)aid;

#pragma mark- 取消收藏
- (void)cancleMyArticleCollectionWithAid:(NSString *)aid;

#pragma mark- 每日任务达成状况
- (void)dayTaskAchiveStatus;
#pragma mark- 领取每日任务奖励
- (void)getTheDayTaskRewards;

#pragma mark-新手福利达成状况
- (void)newTaskFinishStatus;

#pragma mark-领取新手红包
- (void)getTheNewTaskRewards;

#pragma mark- 日月周收徒
- (void)shouTuOfType:(NSString *)type;

#pragma mark- 领取收徒奖励
- (void)shouTuGift:(NSString *)type;

#pragma mark- 绑定微信
- (void)bangDingWeiXinWithToken:(NSString *)access_token andOpinid:(NSString *)openid andUnionid:(NSString *)unionid;

#pragma mark- 微信绑定页数据
- (void)weiXingBangDingStatusData;

#pragma mark- 微信关注
- (void)weiXinGuanZhuStatues;

#pragma mark- 微信显示金额
- (void)cashAboutWeiXin:(NSString *)uid andToken:(NSString *)token;

#pragma  mark- 领新手红包
- (void)newUserHongBao;

#pragma mark- 系统消息详情
- (void)systemMessageDetail:(NSString *)id_;

#pragma mark- 收徒列表
- (void)myPrenticeWithPage:(NSInteger)page;

#pragma mark- 系统消息全部已读
- (void)systemMessageReadAll;

#pragma mark- 抽奖链接
- (void)luckDrawForNewUser;

#pragma mark- 高价分享
- (void)getHeightPriceUCshareLinkWithArticleID:(NSString *)aid andShareType:(NSString *)shareType;

#pragma mark-审核显示隐藏
- (void)isHiddenWhenReview;

#pragma mark- 原生分享链接
- (void)getLocationLinkWithArticleID:(NSString *)aid;

#pragma mark- 获取用户导入的文章
/**获取用户导入的文章*/
- (void)getCustomerAuditImportArticleWithPage:(NSInteger)page;

#pragma mark- 用户导入文章url
/**用户导入文章url*/
- (void)customerImportArticleURL:(NSString *)articleUrl andc_id:(NSString *)c_id;

#pragma mark- 微信搜狗采集
- (void)customerImportArticleTitle:(NSString *)articleTitle andc_id:(NSString *)c_id;

#pragma mark- 一点资讯数据请求
/** 一点资讯数据请求*/
- (void)YiDianZiXunGetArticleListWithCstart:(NSInteger)cstart
                                       Cend:(NSInteger)cend
                                    refresh:(NSString *)refresh
                                    addtime:(NSString *)addtime;

#pragma mark- 一点资讯采集文章
/**一点资讯采集文章*/
- (void)YiDianZiXunImportArticelWithTitle:(NSString *)title
                                    thumb:(NSString *)thumb
                                      _id:(NSString *)_id;

#pragma mark- 淘宝折扣分类
/**淘宝折扣分类*/
- (void)getTaoBaoDiscountChannelClassify;

#pragma mark- 淘宝折扣分类列表
/**淘宝折扣分类列表*/
- (void)getTaoBaoDiscountChannelClassifyListWithCat:(NSUInteger)cat andPage:(NSInteger)page;

#pragma mark- 淘宝折扣详情页数据
/**淘宝折扣详情页数据*/
- (void)getTaoBaoDiscountListDetailDataWithID:(NSString *)_id;


#pragma mark- 版本更新
/**版本更新*/
- (void)checkNewVersionFromNet;
@end
