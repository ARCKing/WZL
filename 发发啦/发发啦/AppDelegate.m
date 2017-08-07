//
//  AppDelegate.m
//  发发啦
//
//  Created by gxtc on 16/8/15.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "AppDelegate.h"
#import "TabViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "NetWork.h"
#import "UMessage.h"
#import <UserNotifications/UserNotifications.h>
#import <UMSocialCore/UMSocialCore.h>
#import "webViewController.h"
#import "AFNetworking.h"
#import <UMMobClick/MobClick.h>
#import "HomeNextViewController.h"
#import "VersionModel.h"

#define IOS_VERSION_10 (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_x_Max)?(YES):(NO)

#define UMAppKeyEnterprise @"595f3ec0ae1bf82a7d001143"

@interface AppDelegate ()<WXApiDelegate,UNUserNotificationCenterDelegate>
@property (nonatomic, retain) UIImageView *customSplashView;
@property (nonatomic, strong) UIButton * closeButton;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
      [WXApi registerApp:@"wxeb07f2b9056ab6d3"];
//        [WXApi registerApp:@"3baf1193c85774b3fd9d18447d76cab0"];

    
    
    
    NSArray * className = @[@"Home_ViewController",@"Money_ViewController",@"Invite_ViewController",@"Article_ViewController"];
    NSArray * classTitleName = @[@"首页",@"热门",@"推荐",@"文章"];
    NSArray * picArray = @[@"tab_home_nor.png",@"fire_usel.png",@"star_usel.png",@"tab_article_nor.png"];
    NSArray * selectArray = @[@"tab_home_slt.png",@"fire_sel.png",@"star_sel.png",@"tab_article_slt.png"];
    
    TabViewController * tab = [[TabViewController alloc]init];
    
    NSArray *  array = [tab getClassNameWithArray:className andPicArray:picArray andClassTitleName:classTitleName andselectPic:selectArray];
    
    [tab setViewControllers:array];
    self.window.rootViewController = tab;
    
    
    //=======================================
    //===============百度广告=================
    
    [self.window makeKeyAndVisible];
    
    
    [self checkNewVersion];
    
    //========友盟统计============
    
    
//    UMConfigInstance.appKey = @"582ff0c6aed1795db1001c91";
    
    UMConfigInstance.appKey = UMAppKeyEnterprise;
    
    
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
//    [MobClick setLogEnabled:YES];//去掉这句代码，并删除测试设备，后台就能统计到，不然是集成测试；
    UMConfigInstance.ePolicy = BATCH;// 启动app就发送
    
    
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    //=========Ushare============
    //打开调试日志
    
    
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
//    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57d77a46e0f55afe6800294d"];582ff0c6aed1795db1001c91
    
    //personal
//    [[UMSocialManager defaultManager] setUmSocialAppkey:@"582ff0c6aed1795db1001c91"];
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppKeyEnterprise];

    

    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
//    //设置微信的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1104813601"  appSecret:@"x10AmoNNwG2dujRM" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    
    
    //============Upush==========
    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
//    [UMessage startWithAppkey:@"572d57a5e0f55a3a6d003a84" launchOptions:launchOptions];
    
    //personal
//        [UMessage startWithAppkey:@"582ff0c6aed1795db1001c91" launchOptions:launchOptions];
    [UMessage startWithAppkey:UMAppKeyEnterprise launchOptions:launchOptions];

    
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
            
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    
    
   
    
    
    NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfo) {
        
        //实现杀死下，打开指定页面！
        
        NSLog(@"%@",userInfo);
//        
//        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//        
//        NSString * push = @"push";
//        
//        [defaults setObject:push forKey:@"push"];
        
        self.userDic = userInfo;
        
    }else{
        
        
        
    }

    
    
    
    
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];

    
#pragma mark- 监听网络
    [self isNetWorking];
    
    return YES;
}



-(void)isNetWorking{
    
    //开启网络指示器，开始监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
    }];
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:self];
    
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        return result;

    }else{
    
        return [WXApi handleOpenURL:url delegate:self];

    }
    
    

    
    
    
}


//授权后回调 WXApiDelegate
-(void)onResp:(BaseReq *)resp
{
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    SendAuthResp *aresp = (SendAuthResp *)resp;

    
    if ([resp isKindOfClass:[SendAuthResp class]]&& [aresp.state isEqualToString:@"App"]) //判断是否为授权请求，否则与微信支付等功能发生冲突
    {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        
        if (aresp.errCode== 0)
        {
            NSLog(@"[ code = %@ ]",aresp.code);
            
            NSLog(@"%@",aresp.code);
            
            
            NetWork * net = [[NetWork alloc]init];
            
            [net weiXinLogin:aresp.code];
            
            
            
            }
    }
}


-(void) onReq:(BaseReq*)req{

    if([req isKindOfClass:[LaunchFromWXReq class]]){
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }


}




//=============Upush=================

//iOS10以下使用这个方法接收通知//app在  [前台或者后台] 的时候用didReceiveRemoteNotification：
//                              【杀死下，不走这个方法！】
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    self.userDic = userInfo;
    
    NSLog(@"%@",userInfo);
    
    
    //    关闭友盟推送弹出框
    [UMessage setAutoAlert:NO];
    
    [UMessage didReceiveRemoteNotification:userInfo];
    
    if([UIApplication sharedApplication].applicationState == UIApplicationStateInactive){
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
        
        
//        NSDictionary * dic = self.userDic[@"aps"];
//        NSString * alert_my = dic[@"alert"];//标题
//        
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送"
//                                                         message:alert_my
//                                                        delegate:self
//                                               cancelButtonTitle:@"取消"
//                                               otherButtonTitles:@"确定",nil];
//        [alert show];

        
        NSDictionary * dic = self.userDic[@"aps"];
        
        NSString * badge = [NSString stringWithFormat:@"%@",dic[@"badge"]];
        
        if ([badge isEqualToString:@"2"]) {
            
            //push
            UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
            UINavigationController  *nvc = tab.selectedViewController;
            UIViewController *vc = nvc.visibleViewController;
            
            HomeNextViewController * homeNext = [[HomeNextViewController alloc]init];
            homeNext.buttonTag = 101;
            
            vc.hidesBottomBarWhenPushed = YES;
            [vc.navigationController pushViewController:homeNext animated:YES];
            vc.hidesBottomBarWhenPushed = NO;


            
    
        }else{
        
            NSDictionary * content_available = dic[@"content-available"];
        
            NSString * id_ = content_available[@"id"];//ID
        
            NSString * img = content_available[@"img"];
            
            NSString * share = content_available[@"share"];
            
            NSString * share_count = [NSString stringWithFormat:@"%@",content_available[@"share_count"]];
            
            NSString * title = content_available[@"title"];
                        
            NSString * url = [NSString stringWithFormat:@"%@",content_available[@"url"]];
        
            NSString * ucShare = [NSString stringWithFormat:@"%@",content_available[@"ucshare"]];

        
            webViewController * web = [[webViewController alloc]init];
            
            web.urlString = url;
            web.share_count = share_count;
            web.shareUrl = share;
            web.id_ = id_;
            web.thumbimg = img;
            web.bigTitle = title;
            web.abstract = title;
            web.ucshare = ucShare;
            [self.window.rootViewController presentViewController:web animated:YES completion:nil];
            
        }
        
    }

    
    NSDictionary * dic = userInfo[@"aps"];
    
    NSString * alert_my = dic[@"alert"];//标题
//    NSString * sound = dic[@"sound"];//链接
    
    
    //判断是前台
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送"
                                                         message:alert_my
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定",nil];
        [alert show];
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        NSLog(@"000");

    }else if (buttonIndex == 1){
        NSLog(@"111");
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:self.userDic];

        
        
        
        NSDictionary * dic = self.userDic[@"aps"];
        
        
        NSString * badge = [NSString stringWithFormat:@"%@",dic[@"badge"]];
        
        if ([badge isEqualToString:@"2"]) {
            
            //push
            UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
            UINavigationController  *nvc = tab.selectedViewController;
            UIViewController *vc = nvc.visibleViewController;
        
            HomeNextViewController * homeNext = [[HomeNextViewController alloc]init];
            homeNext.buttonTag = 101;
            
            vc.hidesBottomBarWhenPushed = YES;
            [vc.navigationController pushViewController:homeNext animated:YES];
            vc.hidesBottomBarWhenPushed = NO;

        
        }else{
        
        
            NSDictionary * content_available = dic[@"content-available"];
            
            NSString * id_ = content_available[@"id"];//ID
            
            NSString * img = content_available[@"img"];
            
            NSString * share = content_available[@"share"];
            
            NSString * share_count = [NSString stringWithFormat:@"%@",content_available[@"share_count"]];
            
            NSString * title = content_available[@"title"];
            
            NSString * url = [NSString stringWithFormat:@"%@",content_available[@"url"]];
            
            NSString * ucShare = [NSString stringWithFormat:@"%@",content_available[@"ucshare"]];

            
            webViewController * web = [[webViewController alloc]init];
            
            web.urlString = url;
            web.share_count = share_count;
            web.shareUrl = share;
            web.id_ = id_;
            web.thumbimg = img;
            web.bigTitle = title;
            web.abstract = title;
            web.ucshare = ucShare;
        [self.window.rootViewController presentViewController:web animated:YES completion:nil];
            
        }
    }

    
    
    
    if (alertView.tag == 111111) {
        
        if (buttonIndex == 1) {
            
            NSLog(@"下载");
            
            //            NSString * url = @"https://itunes.apple.com/us/app/%E7%9F%A5%E4%BA%86-%E9%98%85%E8%AF%BB%E8%B5%84%E8%AE%AF/id1221771642?l=zh&ls=1&mt=8";
            
            
            //http://zqw.2662126.com/Web/show/app.html
            
            NSString * url = @"http://wz.lgmdl.com/Web/show/app.html";
            
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            
        }else{
            
            NSLog(@"忽略");
            
        }
        
        
        return;
    }

    
}


//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //必须加这句代码
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
        self.userDic = userInfo;

        [UMessage setAutoAlert:NO];

        [UMessage didReceiveRemoteNotification:userInfo];
        
        /*
        NSDictionary * dic = userInfo[@"aps"];
        
        NSString * alert_my = dic[@"alert"];//标题
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送"
                                                         message:alert_my
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定",nil];
        [alert show];

        
        
        */
        
        
        
        
        
        
        
    }else{
        //应用处于前台时的本地推送接受
    }
    
}

//iOS10新增：处理后台点击通知的代理方法//杀死下也走这个方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
        [UMessage setAutoAlert:NO];

        [UMessage didReceiveRemoteNotification:userInfo];
        
        
        
        NSDictionary * dic = self.userDic[@"aps"];
        
        NSString * badge = [NSString stringWithFormat:@"%@",dic[@"badge"]];
        
        if ([badge isEqualToString:@"2"]) {
            
            //push
            UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
            UINavigationController  *nvc = tab.selectedViewController;
            UIViewController *vc = nvc.visibleViewController;
            
            HomeNextViewController * homeNext = [[HomeNextViewController alloc]init];
            homeNext.buttonTag = 101;
            
            vc.hidesBottomBarWhenPushed = YES;
            [vc.navigationController pushViewController:homeNext animated:YES];
            vc.hidesBottomBarWhenPushed = NO;

        
        }else{
            NSDictionary * content_available = dic[@"content-available"];
            
            NSString * id_ = content_available[@"id"];//ID
            
            NSString * img = content_available[@"img"];
            
            NSString * share = content_available[@"share"];
            
            NSString * share_count = [NSString stringWithFormat:@"%@",content_available[@"share_count"]];
            
            NSString * title = content_available[@"title"];
            
            NSString * url = [NSString stringWithFormat:@"%@",content_available[@"url"]];
            
            NSString * ucShare = [NSString stringWithFormat:@"%@",content_available[@"ucshare"]];
            
            webViewController * web = [[webViewController alloc]init];
            
            web.urlString = url;
            web.share_count = share_count;
            web.shareUrl = share;
            web.id_ = id_;
            web.thumbimg = img;
            web.bigTitle = title;
            web.abstract = title;
            web.ucshare = ucShare;
        
        [self.window.rootViewController presentViewController:web animated:YES completion:nil]; 
        
        }
        
    }else{
        //应用处于后台时的本地推送接受
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"deviceToken=%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
}


//==============百度广告===============
- (NSString *)publisherId {
        return @"a6cbb950";
    
//    return @"ccb60059";
    
}



/**
 *  展示结束or展示失败后, 手动移除splash和delegate
 */
- (void) removeSplash {
   
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showHongBao" object:nil];
    
}



#pragma mark- 版本更新提示
//===版本更新提示======

- (void)checkNewVersion{
    
    //CFBundleShortVersionString - version
    //CFBundleVersion - Build
    
    
    NSString * currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSLog(@"[当前版本号:%@]",currentVersion);
    
    NetWork * net = [[NetWork alloc]init];
    
    [net checkNewVersionFromNet];
    
    net.checkNewVewsionBK=^(NSString * code,NSString * message,NSString * str,NSArray * dataArray,NSArray * arr){
        
        if (dataArray.count > 0) {
            
            VersionModel * model = dataArray[0];
            
            NSString * newVersion = model.version_number;
            
            
            
            if ([currentVersion compare: newVersion] == NSOrderedAscending) {
                
                UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"有新版本啦!"
                                                                message:model.remarks
                                                               delegate:self
                                                      cancelButtonTitle:@"忽略"
                                                      otherButtonTitles:@"去更新", nil];
                alter.tag = 111111;
                
                [alter show];
            }
            
            
        }
        
    };
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


//杀死下不走
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    NSLog(@"33333 我从后台回来啦！");
//    
//    
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"第三"
//                                                     message:@"从后台回来啦啦啦"
//                                                    delegate:self
//                                           cancelButtonTitle:@"取消"
//                                           otherButtonTitles:nil,nil];
//    [alert show];

}


//杀死下不走
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
//    NSLog(@"111 我要=>从后台回来啦！");
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"第二"
//                                                     message:@"要从后台回来啦"
//                                                    delegate:self
//                                           cancelButtonTitle:@"取消"
//                                           otherButtonTitles:nil,nil];
//    [alert show];
    
}


//杀死也走
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
#pragma mark- 在此方法进行点击图标，查找推送信息

    //在此方法进行点击图标，查找推送信息
    
//    NSLog(@"2222 我活了");
//    
//    
//    NSInteger bandage = application.applicationIconBadgeNumber;
//    
//    NSString * notys = [NSString stringWithFormat:@"通知:%ld",bandage];
//    
//    
//    
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"新消息"
//                                                     message:notys
//                                                    delegate:self
//                                           cancelButtonTitle:@"取消"
//                                           otherButtonTitles:nil,nil];
//
//    
//    [alert show];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "xqp.___" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"___" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"___.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


//程序异常监听
void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    
    NSLog(@"exception type : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr);
}




@end
