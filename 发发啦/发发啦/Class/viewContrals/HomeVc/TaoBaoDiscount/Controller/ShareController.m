//
//  ShareController.m
//  发发啦
//
//  Created by macos on 2017/8/6.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ShareController.h"
#import <Social/Social.h>
#import "SelectImage_ShareView.h"

#import <UMSocialCore/UMSocialCore.h>


#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self



//分享类型
typedef NS_ENUM(NSInteger, ShareHelperShareType)
{
    ShareHelperShareTypeOthers,//其他
    ShareHelperShareTypeWeChat,//微信
    ShareHelperShareTypeQQ,//腾讯QQ
    ShareHelperShareTypeSina,//新浪微博
    
};



@interface ShareController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *selectNumLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *weiChatBt;

@property (weak, nonatomic) IBOutlet UIButton *friendBt;

@property (weak, nonatomic) IBOutlet UIButton *weiBoBt;

@property (weak, nonatomic) IBOutlet UIButton *QQBt;

@property (weak, nonatomic) IBOutlet UIButton *QZoneBt;


@property (nonatomic,copy)NSString * taokouling;

@property (nonatomic,strong)SelectImage_ShareView * selectImageView;
@property (weak, nonatomic) IBOutlet UILabel *selectImageLabel;

@property (weak, nonatomic) IBOutlet UILabel *editieLabel;

@property (strong,nonatomic)NSMutableArray * selectImageArr;

@end

@implementation ShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.selectImageArr = [NSMutableArray new];
    
    [self btSetImageAndTitle];
    
    self.taokouling = [NSString stringWithFormat:@"【品名】%@\n--------\n【在售价】%@元\n--------\n【内部价】%@元\n--------\n【推荐】%@\n--------\n 抢购流程\n复制这条信息,%@,打开【手机淘宝】即可领券下单",self.model.itemtitle,self.model.itemprice,self.model.itemendprice,self.model.guide_article,self.model.taokouling];
    
    self.textView.delegate = self;
    self.textView.text = self.taokouling;
    
    [self.view addSubview:self.selectImageView];
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.taokouling;
}


- (SelectImage_ShareView *)selectImageView{

    if (!_selectImageView) {
        
        CGFloat H = ScreenWith/4;

        if (ScreenWith < 375.0) {
            
            H = ScreenWith/6;
        }else if ( ScreenWith > 375.0){
        
            H = ScreenWith/3;
        }
       
        
        _selectImageView = [[SelectImage_ShareView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectImageLabel.frame)+8, ScreenWith, H)];
        _selectImageView.imageArr = self.imageArr;
        _selectImageView.imageUrlArr = self.imageUrlArr;
    }

    WEAK_SELF;
    _selectImageView.selectImageBK = ^(NSInteger tag, BOOL isSelect) {
      
        if (isSelect) {
            
            [weakSelf.selectImageArr addObject:weakSelf.imageArr[tag]];
            
        }else{
        
            [weakSelf.selectImageArr removeObject:weakSelf.imageArr[tag]];
        
        }
        
        
        weakSelf.selectNumLabel.text = [NSString stringWithFormat:@"已选%ld张",weakSelf.selectImageArr.count];
    };
    
    return _selectImageView;
}


- (void)btSetImageAndTitle{

    NSArray * array = [NSArray arrayWithObjects:self.weiChatBt,self.friendBt,self.weiBoBt,self.QQBt,self.QZoneBt, nil];
    
    for (UIButton * bt in array) {
        
        [bt setImageEdgeInsets:UIEdgeInsetsMake(-bt.titleLabel.intrinsicContentSize.height, 0, 0, -bt.titleLabel.intrinsicContentSize.width)];
        [bt setTitleEdgeInsets:UIEdgeInsetsMake(bt.currentImage.size.height + bt.titleLabel.intrinsicContentSize.height, -bt.currentImage.size.width, 0, 0)];
        
        bt.titleLabel.font = [UIFont systemFontOfSize:16.0];
    }

}


-(void)textViewDidEndEditing:(UITextView *)textView{
    self.taokouling = textView.text;
}


- (IBAction)popBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)coppButtonAction:(id)sender {
    
    NSLog(@"复制文案");
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.taokouling;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(ScreenWith/2,ScreenHeight*2/3 + ScreenWith/10);
    if (pasteboard.string != nil) {
        label.text = @" 复制成功 ";
        
    }else{
        label.text = @" 复制失败 ";
    
    }
    
    [label sizeToFit];
    [self.view addSubview:label];
    
    [self performSelector:@selector(dismissAlter:) withObject:label afterDelay:1.5];
}


- (void)dismissAlter:(UILabel *)label{

    [label removeFromSuperview];

}


- (IBAction)weiChatBtAction:(id)sender {
    NSLog(@"微信分享");
    
//    [self SlcomposeShareWithImageArr:self.selectImageArr andImageUrlArr:self.imageUrlArr andShareType:ShareHelperShareTypeWeChat andTitle:self.model.itemtitle andUrl:self.model.couponurl];

    
    [self UMShareDataWithPlatform:UMSocialPlatformType_WechatSession isSina:NO isWeiChat:YES];
}



- (IBAction)friendBtAction:(id)sender {

    NSLog(@"朋友圈分享");
    
    [self WeiFriendSlcomposeShareWithImageArr:self.selectImageArr andImageUrlArr:self.imageUrlArr andShareType:ShareHelperShareTypeWeChat andTitle:self.model.itemtitle andtaoKouling:self.model.taokouling];
}



- (IBAction)weiboBtAction:(id)sender {

    NSLog(@"微博分享");
//    [self SlcomposeShareWithImageArr:self.selectImageArr andImageUrlArr:self.imageUrlArr andShareType:ShareHelperShareTypeSina andTitle:self.model.itemtitle andUrl:self.model.couponurl];

    [self UMShareDataWithPlatform:UMSocialPlatformType_Sina isSina:YES isWeiChat:NO];

}



- (IBAction)QQBtAction:(id)sender {
    
    NSLog(@"QQ分享");
//    [self SlcomposeShareWithImageArr:self.selectImageArr andImageUrlArr:self.imageUrlArr andShareType:ShareHelperShareTypeQQ andTitle:self.model.itemtitle andUrl:self.model.couponurl];

    [self UMShareDataWithPlatform:UMSocialPlatformType_QQ isSina:NO isWeiChat:NO];

}



- (IBAction)qzoneBtAction:(id)sender {
    
    NSLog(@"QQ空间分先");
   // [self SlcomposeShareWithImageArr:self.selectImageArr andImageUrlArr:self.imageUrlArr andShareType:ShareHelperShareTypeQQ andTitle:self.model.itemtitle andUrl:self.model.couponurl];

    
    [self WeiFriendSlcomposeShareWithImageArr:self.selectImageArr andImageUrlArr:self.imageUrlArr andShareType:ShareHelperShareTypeQQ andTitle:self.model.itemtitle andtaoKouling:self.model.taokouling];

}

//==================================

//朋友圈
- (void)WeiFriendSlcomposeShareWithImageArr:(NSArray *)imageArr andImageUrlArr:(NSArray *)imageUrlArr andShareType:(ShareHelperShareType)type andTitle:(NSString *)title andtaoKouling:(NSString *)taokouling{
    
    //创建分享内容编辑控制器，指定类型为新浪微博
    SLComposeViewController *compose =
    [SLComposeViewController composeViewControllerForServiceType:[self serviceTypeWithType:type]];
    //设置分享内容
    [compose setInitialText:[NSString stringWithFormat:@"%@%@",title,taokouling]];
    
    
    if (imageArr.count == 0) {
        
        imageArr = [NSArray arrayWithObject:self.imageArr[0]];
    }
    
    // 添加要分享的图片
    for ( id obj in imageArr){
        
        if ([obj isKindOfClass:[UIImage class]]){
            [compose addImage:(UIImage *)obj];
        }
    }
    
    
    /*
     //设置超链接
     for (id obj in imageUrlArr) {
     
     NSURL * url = [NSURL URLWithString:obj];
     
     if ([url isKindOfClass:[NSURL class]]){
     [compose addURL:(NSURL *)url];
     }
     }
     */
    
    //设置分享图片
    //    [compose addImage:self.imageArr[0]];

    //NSString * taobao = [NSString stringWithFormat:@"taobao://item.taobao.com/item.htm?id=%@",self.model.itemid];

    //设置超链接
    //[compose addURL:[NSURL URLWithString:taobao]];
    
    
    
    //设置回调
    __block SLComposeViewController *blockController = compose;
    compose.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultDone) {
            NSLog(@"发送完成");
        }else{
            NSLog(@"发送失败");
        }
        //弹回
        [blockController dismissViewControllerAnimated:YES completion:nil];
    };
    
    
    @try{
        
        //弹出控制器
        [self presentViewController:compose animated:YES completion:nil];
        
    } @catch (NSException *exception){
        NSLog(@"没有安装");
        
    } @finally {
        
    }
    
}


//调用原生分享
- (void)SlcomposeShareWithImageArr:(NSArray *)imageArr andImageUrlArr:(NSArray *)imageUrlArr andShareType:(ShareHelperShareType)type andTitle:(NSString *)title andUrl:(NSString *)url{

    //创建分享内容编辑控制器，指定类型为新浪微博
    SLComposeViewController *compose =
    [SLComposeViewController composeViewControllerForServiceType:[self serviceTypeWithType:type]];
    //设置分享内容
    [compose setInitialText:title];
    
    
    // 添加要分享的图片
    for ( id obj in imageArr){
        
        if ([obj isKindOfClass:[UIImage class]]){
            [compose addImage:(UIImage *)obj];
        }
    }
    
    /*
    //设置超链接
    for (id obj in imageUrlArr) {
        
        NSURL * url = [NSURL URLWithString:obj];
        
        if ([url isKindOfClass:[NSURL class]]){
            [compose addURL:(NSURL *)url];
        }
    }
    */
    
    //设置分享图片
//    [compose addImage:self.imageArr[0]];
    
    //设置超链接
    [compose addURL:[NSURL URLWithString:url]];
  
    
    
    //设置回调
    __block SLComposeViewController *blockController = compose;
    compose.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultDone) {
            NSLog(@"发送完成");
        }else{
            NSLog(@"发送失败");
        }
        //弹回
        [blockController dismissViewControllerAnimated:YES completion:nil];
    };
    
    
    @try{
        
        //弹出控制器
        [self presentViewController:compose animated:YES completion:nil];
        
    } @catch (NSException *exception){
        NSLog(@"没有安装");
        
    } @finally {
        
    }

}


#pragma mark - 返回分享类型
- (NSString *)serviceTypeWithType:(ShareHelperShareType)type{
    //这个方法不再进行校验,传入就不等于0.这里做一个转换
    NSString * serviceType;
    if ( type!= 0){
        switch (type){
            case ShareHelperShareTypeWeChat:
                serviceType = @"com.tencent.xin.sharetimeline";
                break;
            case ShareHelperShareTypeQQ:
                serviceType = @"com.tencent.mqq.ShareExtension";
                break;
            case ShareHelperShareTypeSina:
                serviceType = @"com.apple.share.SinaWeibo.post";
                break;
            default:
                break;
        }
    }
    return serviceType;
}


//===================UMshare===============
//直接分享
- (void)UMShareDataWithPlatform:(UMSocialPlatformType)platformType isSina:(BOOL)isSina isWeiChat:(BOOL)isWeiChat
{
    
    UMSocialMessageObject *messageObject;
    
    
    if (isSina) {
        
        messageObject = [self creatMessageObjectWithSinaWeiBoWithTitle:self.model.itemtitle andAbstract:self.model.guide_article taokouling:self.model.taokouling url:self.model.couponurl andImage:self.imageArr[0]];
        
    }else{
        messageObject = [self creatMessageObjectWithTitle:self.model.itemtitle andAbstract:self.model.guide_article taokouling:self.model.taokouling url:self.model.couponurl andImage:self.imageArr[0] isWeiChat:isWeiChat];
    }
    
    //调用分享接口
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        }
        else{
            if (error) {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                
                switch (error.code) {
                    case UMSocialPlatformErrorType_Unknow:
                        message = @"未知错误";
                        break;
                    case UMSocialPlatformErrorType_NotSupport:
                        message = @"不支持（url scheme 没配置，或者没有配置-ObjC， 或则SDK版本不支持或则客户端版本不支持";
                        break;
                    case UMSocialPlatformErrorType_AuthorizeFailed:
                        message = @"授权失败";
                        break;
                    case UMSocialPlatformErrorType_ShareFailed:
                        message = @"分享失败";
                        break;
                    case UMSocialPlatformErrorType_RequestForUserProfileFailed:
                        message = @"请求用户信息失败";
                        break;
                    case UMSocialPlatformErrorType_ShareDataNil:
                        message = @"分享内容为空";
                        break;
                    case UMSocialPlatformErrorType_ShareDataTypeIllegal:
                        message = @"分享内容不支持";
                        break;
                    case UMSocialPlatformErrorType_CheckUrlSchemaFail:
                        message = @"schemaurl fail";
                        break;
                    case UMSocialPlatformErrorType_NotInstall:
                        message = @"应用未安装";
                        break;
                    case UMSocialPlatformErrorType_Cancel:
                        message = @"您已取消分享";
                        break;
                    case UMSocialPlatformErrorType_NotNetWork:
                        message = @"网络异常";
                        break;
                    case UMSocialPlatformErrorType_SourceError:
                        message = @"第三方错误";
                        break;
                    case UMSocialPlatformErrorType_ProtocolNotOverride:
                        message = @"对应的  UMSocialPlatformProvider的方法没有实现";
                        break;
                    case 2:
                        message = @"未安装该应用,无法分享!";
                        break ;
                        
                    default:
                        break;
                        
                }
                NSLog(@"message = %@",message);
                
            }
            else{
                message = [NSString stringWithFormat:@"分享失败"];
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享状态"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    
}

//创建新浪分享内容对象
- (UMSocialMessageObject *)creatMessageObjectWithSinaWeiBoWithTitle:(NSString *)title andAbstract:(NSString *)abstract taokouling:(NSString *)taoKouling url:(NSString *)url andImage:(UIImage *)image{

    NSString * str = [NSString stringWithFormat:@"%@\n%@",title,taoKouling];

    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = [NSString stringWithFormat:@"转//#微转啦#<<%@>>\n%@",str,url];
    
    //创建图片对象
    UMShareImageObject *shareImgObject = [[UMShareImageObject alloc]init];
    [shareImgObject setShareImage:image];
    messageObject.shareObject = shareImgObject;
    return messageObject;
    
}


//创建分享内容对象
- (UMSocialMessageObject *)creatMessageObjectWithTitle:(NSString *)title andAbstract:(NSString *)abstract taokouling:(NSString *)taoKouling url:(NSString *)url andImage:(UIImage *)image isWeiChat:(BOOL)isWeiChat{
    
    /*
//    NSString * str = [NSString stringWithFormat:@"%@%@",title,taoKouling];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:taoKouling thumImage:image];
    
    [shareObject setWebpageUrl:url];

    messageObject.shareObject = shareObject;
    
    return messageObject;
     */
    
    
    if (isWeiChat) {
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建图片对象
        UMShareImageObject *shareImgObject = [[UMShareImageObject alloc]init];
        [shareImgObject setShareImage:image];
        messageObject.shareObject = shareImgObject;
        return messageObject;
        

    }else{
//        NSString * str = [NSString stringWithFormat:@"%@\n%@",title,taoKouling];
    
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
//        messageObject.text = [NSString stringWithFormat:@"{%@}\n%@",str,url];
    
        messageObject.text = self.taokouling;
        
        return messageObject;
    }

    
    
    
}


@end
