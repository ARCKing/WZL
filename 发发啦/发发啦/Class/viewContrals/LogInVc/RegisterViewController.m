//
//  RegisterViewController.m
//  TestDemo
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "RegisterViewController.h"
#import "NetWork.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "MD5Tool.h"
#import "GSKeyChainDataManager.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *inviteTextField;

@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *achieveCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *resigneButton;

@property(nonatomic,retain)NetWork * net;

@property (nonatomic,copy)NSString * username;
@property (nonatomic,copy)NSString * password;
@property (nonatomic,copy)NSString * repassword;
@property (nonatomic,copy)NSString * sms_verify;
@property (nonatomic,copy)NSString * inviter;


@property (nonatomic,strong)UIView * imageCodeBGview;
@property (nonatomic,copy)NSString * imageCoder;
@property (nonatomic,strong)UIImageView * imageCodev;
@property (nonatomic,strong)UITextField * imageCodeField;
@property (nonatomic,strong)UIButton * imageCodeEnterBt;



@property (nonatomic,copy)NSString * phone;
@property(nonatomic,assign)int times;
@property(nonatomic,strong)NSTimer * timer;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.times = 30;
    // Do any additional setup after loading the view from its nib.
    self.phoneNumberTextField.delegate = self;
    self.codeTextField.delegate = self;
    self.inviteTextField.delegate = self;
    self.securityCodeTextField.delegate = self;
    self.net = [[NetWork alloc]init];
    
    
    self.achieveCodeButton.backgroundColor = [UIColor lightGrayColor];
    self.achieveCodeButton.enabled = NO;

    
}


#pragma mark- 返回按钮
- (IBAction)backButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 1000) {
        NSLog(@"手机号码=%@",textField.text);
    }else if (textField.tag == 2000){
        NSLog(@"密码=%@",textField.text);
    }else if (textField.tag == 3000){
        NSLog(@"邀请码=%@",textField.text);
    }else if (textField.tag == 4000){
        NSLog(@"验证码=%@",textField.text);
    }else if (textField.tag == 5000){
        NSLog(@"验证码=%@",textField.text);
        self.imageCoder = textField.text;
        
        NSLog(@"验证码=%@", self.imageCoder);

    }


}


#pragma mark- 输入手机号
- (IBAction)phoneNumberTextFieldDidBegineEditing:(id)sender {
    NSLog(@"开始输入手机号");
}

- (IBAction)phoneNumberTextFieldEditingChanged:(id)sender {
    NSLog(@"手机号正在输入");
    NSLog(@"phone=%@",_phoneNumberTextField.text);

    if (_phoneNumberTextField.text.length == 11) {
        self.achieveCodeButton.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:224.0/255.0 blue:208.0/255.0 alpha:1.0];
        self.achieveCodeButton.enabled = YES;

        self.username = _phoneNumberTextField.text;
        self.phone = self.username;

    }else{
        self.achieveCodeButton.backgroundColor = [UIColor lightGrayColor];
        self.achieveCodeButton.enabled = NO;

    }
}

- (IBAction)phoneNumberTextFieldDidEndEditing:(id)sender {
    
    NSLog(@"手机号输入结束");
    NSLog(@"phone=%@",_phoneNumberTextField.text);
    self.username = _phoneNumberTextField.text;
    self.phone = self.username;
    
}

#pragma mark- 密码输入
- (IBAction)codeDidBegineEditing:(id)sender {
    NSLog(@"密码开始输入");
}

- (IBAction)codeDidEditingChanged:(id)sender {
    NSLog(@"密码正在输入");
}

- (IBAction)codeDidEndEditing:(id)sender {
    NSLog(@"密码输入结束");
    NSLog(@"code=%@",_codeTextField.text);
    self.password = _codeTextField.text;
}

#pragma mark- 邀请码
- (IBAction)inviteCodeDidBeginEditing:(id)sender {
    NSLog(@"开始输入邀请码");
}

- (IBAction)inviteCodeDidEditingChange:(id)sender {
    NSLog(@"正在输入邀请码");
}

- (IBAction)inviteCodeDidEndEditing:(id)sender {
    NSLog(@"邀请码输入结束");
    NSLog(@"invite=%@",_inviteTextField.text);
    self.inviter = _inviteTextField.text;
}


#pragma markk- 获取验证码
- (IBAction)achieveCodeButtonAction:(id)sender {
    NSLog(@"获取验证码");
    
    [self getImageCoderFromNet];
    
}

/**图片验证码*/
- (void)getImageCoderFromNet{

//    NSString * url = @"http://wz.lgmdl.com/App/Member/getyzm";
    
    
    UIView * imageCodeBgView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/6, SCREEN_W/3, SCREEN_W*2/3, SCREEN_W*2/3)];
    imageCodeBgView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:imageCodeBgView];
    imageCodeBgView.layer.cornerRadius = 5.0;
    self.imageCodeBGview = imageCodeBgView;
    
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_W*2/3 - 30, SCREEN_W/4)];
//    [imageV sd_setImageWithURL:[NSURL URLWithString:url]];
    [imageCodeBgView addSubview:imageV];
    imageV.userInteractionEnabled = YES;
    self.imageCodev = imageV;
    [self refreshImageCode];
    
    
    UIButton * refreshBt = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBt.frame = CGRectMake(0, 0, SCREEN_W*2/3 - 30, SCREEN_W/4);
    refreshBt.backgroundColor = [UIColor clearColor];
    [imageV addSubview:refreshBt];
    [refreshBt addTarget:self action:@selector(refreshImageCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * placeHolder = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame), SCREEN_W *2/3, SCREEN_W/10)];
    placeHolder.backgroundColor = [UIColor clearColor];
    placeHolder.text = @"看不清？点击图片刷新";
    placeHolder.textAlignment = NSTextAlignmentCenter;
    placeHolder.textColor = [UIColor blackColor];
    placeHolder.font = [UIFont systemFontOfSize:15];
    [imageCodeBgView addSubview:placeHolder];
    
    UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(placeHolder.frame), SCREEN_W*2/3 - 30, SCREEN_W/11)];
    field.placeholder = @"请输入图片上的验证码";
    field.backgroundColor = [UIColor whiteColor];
    field.textAlignment = NSTextAlignmentCenter;
    field.layer.cornerRadius = 3.0;
    field.delegate = self;
    field.tag = 5000;
    self.imageCodeField = field;
    [field becomeFirstResponder];
    [imageCodeBgView addSubview:field];
    
    
    UIButton * cancleBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBt setTitle:@"确定" forState:UIControlStateNormal];
    cancleBt.frame = CGRectMake(15, CGRectGetMaxY(field.frame) + SCREEN_W/20, SCREEN_W*2/3 - 30, SCREEN_W/10);
    [imageCodeBgView addSubview:cancleBt];
    cancleBt.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:205.0/255.0 blue:170.0/255.0 alpha:1.0];
    cancleBt.layer.cornerRadius = 3.0;
    [cancleBt addTarget:self action:@selector(enterFinishAction) forControlEvents:UIControlEventTouchUpInside];
    self.imageCodeEnterBt = cancleBt;
    
    
}


- (void)enterFinishAction{

    [self.imageCodeBGview removeFromSuperview];
    
    NSLog(@"图片验证码%@",self.imageCoder);
    
    NSString * code = self.imageCoder;
    NSString * phone = self.phone;
    NSString * type = @"register";
    NSString * key = @"9GM6&X3JG%GGfZuH1R0A3";

    NSString * sourceString = [NSString stringWithFormat:@"code=%@&phone=%@&type=%@&key=%@",code,phone,type,key];
    
    NSString * md5Code = [MD5Tool MD5ForUpper32Bate:sourceString];
    
    [_phoneNumberTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [_securityCodeTextField resignFirstResponder];
    [_inviteTextField resignFirstResponder];
    [self.net userGetSmsWithPhoneNumber:_username andType:@"register" andSign:md5Code andImageCode:code];
    
    __weak RegisterViewController * weakSelf = self;
    self.net.smsMessage=^(NSString * message,NSString * code){
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width / 2, self.view.bounds.size.width/3)];
        label.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        label.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        [weakSelf.view addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = message;
        label.font = [UIFont systemFontOfSize:14];
        label.layer.cornerRadius = 10;
        label.clipsToBounds = YES;
        
        [weakSelf performSelector:@selector(cancleAlrater:) withObject:label afterDelay:1];
        
        /*
         if ([code isEqualToString:@"1"]) {
         
         [weakSelf addTimer];
         
         }
         */
    };



}



/**获取图片*/
- (void)refreshImageCode{

    self.imageCodev.image = [UIImage imageNamed:@"load"];
    
    NSString * url = @"http://wz.lgmdl.com/App/Member/getyzm/phone/";
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",url,self.phone];
    
//    [self.imageCodev sd_setImageWithURL:[NSURL URLWithString:URL]];
    
    SDWebImageManager * manger = [SDWebImageManager sharedManager];
    
    __weak RegisterViewController * weakSelf = self;
    
    [manger.imageDownloader downloadImageWithURL:[NSURL URLWithString:URL] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        weakSelf.imageCodev.image = image;
        
    }];
    
}

- (void)addTimer{
    
    if (self.timer == nil) {
        
        NSTimer * time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondsRecord) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
        self.timer = time;
        
    }
}


- (void)secondsRecord{
    
    self.times --;
    
    [self.achieveCodeButton setTitle:[NSString stringWithFormat:@"%ds",self.times] forState:UIControlStateNormal];
    
    self.achieveCodeButton.backgroundColor = [UIColor lightGrayColor];
    self.achieveCodeButton.enabled = NO;
    
    
    if (self.times == 0) {
        self.times = 30;
        [self stopTimer];
        [self.achieveCodeButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        
        self.achieveCodeButton.enabled = YES;
        
        self.achieveCodeButton.backgroundColor = [UIColor orangeColor];
        
    }
    
}

- (void)stopTimer{
    
    [self.timer invalidate];
    self.timer = nil;
    
}







- (void)cancleAlrater:(UILabel *)label{
    
    [UIView animateWithDuration:2 animations:^{
        
        label.alpha = 0;
        
    }];
    
    
}




#pragma markk- 输入验证码

- (IBAction)securityCodeTextFieldDidBeginEditing:(id)sender {
    NSLog(@"开始输入验证码");
}

- (IBAction)securityCodeTextFieldDidEditingChange:(id)sender {
    NSLog(@"正在输入验证码");
}

- (IBAction)securityCodeTextFieldDidEndEditing:(id)sender {
    NSLog(@"结束输入验证码");
    NSLog(@"securty=%@",_securityCodeTextField.text);
    self.sms_verify = _securityCodeTextField.text;
}

#pragma mark- 注册按钮
- (IBAction)resigneButtonAction:(id)sender {
    
    
    NSString * deviceId = [self GetDeciceUUID];

    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;

    
    NSLog(@"注册");
    [_phoneNumberTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [_securityCodeTextField resignFirstResponder];
    [_inviteTextField resignFirstResponder];
    
    [self.net userRegisterWithUserName:self.username andPassWord:self.password andRepassWord:self.password andSms_verify:self.sms_verify andInviter:self.inviter andOpenid:self.openId andaccess_token:self.access_token andDeviceId:deviceId];
    
    
    __weak UIViewController * weakSelf = self;
    
    self.net.messageRegisterBlock=^(NSString * code,NSString * message){
        
        [hud hideAnimated:YES];
        
        if ([code isEqualToString:@"1"]) {
            
         [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
        
            NSLog(@"error = 0");
            
            UILabel * messageLabel = [[UILabel alloc]init];
            messageLabel.frame = CGRectMake(0, 0, SCREEN_W/2, SCREEN_W/4);
            messageLabel.center = CGPointMake(SCREEN_W/2, SCREEN_H/3);
            messageLabel.text = message;
            //        messageLabel.font = [UIFont systemFontOfSize:14];
            messageLabel.textColor = [UIColor whiteColor];
            messageLabel.backgroundColor =[ UIColor blackColor];
            messageLabel.layer.cornerRadius = 5;
            messageLabel.clipsToBounds = YES;
            messageLabel.numberOfLines = 0;
            [messageLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
            messageLabel.textAlignment = NSTextAlignmentCenter;
            [weakSelf.view addSubview:messageLabel];
            
            [weakSelf performSelector:@selector(dissmissShowMessage:) withObject:messageLabel afterDelay:0.5];

            
        }
    
    };
    
}

- (void)dissmissShowMessage:(UILabel *)view{
    
    
    [UIView animateWithDuration:1.0 animations:^{
        view.alpha = 0;
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    [_phoneNumberTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    [_securityCodeTextField resignFirstResponder];
    [_inviteTextField resignFirstResponder];
    
    [self.imageCodeField resignFirstResponder];
}




#pragma mark-设备标识号
- (NSString *)GetDeciceUUID{
    
    NSString * uuid = [GSKeyChainDataManager readUUID];
    
    NSLog(@"GSKeyChainDataManager = %@",uuid);
    
    if (!uuid) {
        
        NSString *deviceUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        [GSKeyChainDataManager saveUUID:deviceUUID];
        
        uuid = deviceUUID;
        
        NSLog(@"GSKeyChainDataManager = %@",[GSKeyChainDataManager readUUID]);
        
    }
    
    return uuid;
}



@end
