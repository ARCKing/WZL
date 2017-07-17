//
//  ResetCodeViewController.m
//  TestDemo
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "ResetCodeViewController.h"
#import "NetWork.h"
#import "MBProgressHUD.h"

#import "UIImageView+WebCache.h"
#import "MD5Tool.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface ResetCodeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *setNewCodeTextField;

@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *achiveSecurityCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIButton *rsetButton;
@property (nonatomic,copy)NSString * phone;
@property(nonatomic,strong)NetWork * net;


@property (nonatomic,strong)UIView * imageCodeBGview;
@property (nonatomic,copy)NSString * imageCoder;
@property (nonatomic,strong)UIImageView * imageCodev;
@property (nonatomic,strong)UITextField * imageCodeField;
@property (nonatomic,strong)UIButton * imageCodeEnterBt;

@property(nonatomic,assign)int times;
@property(nonatomic,strong)NSTimer * timer;

@end

@implementation ResetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.times = 30;
    
    self.achiveSecurityCodeButton.backgroundColor = [UIColor lightGrayColor];
    self.achiveSecurityCodeButton.enabled = NO;

}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 5000) {
        NSLog(@"图片验证码=%@",textField.text);
        self.imageCoder = textField.text;
    }
}

#pragma mark- 返回按钮
- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hiddenKeyBoard{

    [self.phoneNumberTextField resignFirstResponder];
    [self.setNewCodeTextField resignFirstResponder];
    [self.securityCodeTextField resignFirstResponder];
    [self.imageCodeField resignFirstResponder];
    
    NSLog(@"%@",self.phoneNumberTextField.text);
    NSLog(@"%@",self.setNewCodeTextField.text);
    NSLog(@"%@",self.securityCodeTextField.text);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hiddenKeyBoard];

}

#pragma mark- 手机号
- (IBAction)phoneNumberDidBeginEditing:(id)sender {
    NSLog(@"手机号开始输入");
}

- (IBAction)phoneNumberDidEditingChanged:(id)sender {
    NSLog(@"手机号正在输入");
    
    NSLog(@"phone=%@",_phoneNumberTextField.text);
    
    if (_phoneNumberTextField.text.length == 11) {
        self.achiveSecurityCodeButton.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:224.0/255.0 blue:208.0/255.0 alpha:1.0];
        self.achiveSecurityCodeButton.enabled = YES;
        
        self.phone = _phoneNumberTextField.text;
        
    }else{
        self.achiveSecurityCodeButton.backgroundColor = [UIColor lightGrayColor];
        self.achiveSecurityCodeButton.enabled = NO;
        
    }
    
    
}

- (IBAction)phoneNumberDidEndEditing:(id)sender {
    NSLog(@"手机号结束输入");
}


- (IBAction)setNewCodeDidBeginEditing:(id)sender {
    NSLog(@"新密码开始输入");
}


- (IBAction)setNewCodeDidEditingChanged:(id)sender {
    NSLog(@"新密码正在输入");
}

- (IBAction)setNewCodeDidEndEditing:(id)sender {
    NSLog(@"新密码输入结束");
}
#pragma mark- 验证码

- (IBAction)securityCodeDidBeginEditing:(id)sender {
    NSLog(@"验证码开始输入");
}

- (IBAction)securityCodeDidEditingChange:(id)sender {
     NSLog(@"验证码正在输入");
}

- (IBAction)securityCodeDidEndEditing:(id)sender {
     NSLog(@"验证码结束输入");
}

#pragma mark- 获取验证码

- (IBAction)achiveSecurityCodeButtonAction:(id)sender {
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



/**获取图片*/
- (void)refreshImageCode{
    
    self.imageCodev.image = [UIImage imageNamed:@"load"];
    
    NSString * url = @"http://wz.lgmdl.com/App/Member/getyzm/phone/";
    
    NSString * URL = [NSString stringWithFormat:@"%@%@",url,self.phone];
    
//    [self.imageCodev sd_setImageWithURL:[NSURL URLWithString:URL]];
    
    SDWebImageManager * manger = [SDWebImageManager sharedManager];
    
    __weak ResetCodeViewController * weakSelf = self;
    
    [manger.imageDownloader downloadImageWithURL:[NSURL URLWithString:URL] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        weakSelf.imageCodev.image = image;
        
    }];
    
}


- (void)enterFinishAction{
    
    [self.imageCodeBGview removeFromSuperview];
    
    NSLog(@"图片验证码%@",self.imageCoder);
    
    NSString * code = self.imageCoder;
    NSString * phone = self.phone;
    NSString * type = @"find-password";
    NSString * key = @"9GM6&X3JG%GGfZuH1R0A3";
    
    NSString * sourceString = [NSString stringWithFormat:@"code=%@&phone=%@&type=%@&key=%@",code,phone,type,key];
    
    NSString * md5Code = [MD5Tool MD5ForUpper32Bate:sourceString];
    
    
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    [self.net userGetSmsWithPhoneNumber:self.phoneNumberTextField.text andType:@"find-password" andSign:md5Code andImageCode:code];
    
    __weak ResetCodeViewController * weakSelf = self;
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


- (void)addTimer{

    if (self.timer == nil) {
        
    NSTimer * time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secondsRecord) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSRunLoopCommonModes];
    self.timer = time;
        
    }
}


- (void)secondsRecord{

    self.times --;
    
    [self.achiveSecurityCodeButton setTitle:[NSString stringWithFormat:@"%ds",self.times] forState:UIControlStateNormal];

    self.achiveSecurityCodeButton.backgroundColor = [UIColor lightGrayColor];
    self.achiveSecurityCodeButton.enabled = NO;
    
    
    if (self.times == 0) {
        self.times = 30;
        [self stopTimer];
        [self.achiveSecurityCodeButton setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        
        self.achiveSecurityCodeButton.enabled = YES;

        self.achiveSecurityCodeButton.backgroundColor = [UIColor orangeColor];

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




#pragma mark- 重置
- (IBAction)rsetButtonAction:(id)sender {
    NSLog(@"重置");
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;

    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    NSLog(@"%@",self.phoneNumberTextField.text);
    NSLog(@"%@",self.setNewCodeTextField.text);
    NSLog(@"%@",self.securityCodeTextField.text);

    
    [self.net userFindOutPassWorldWithPhone:self.phoneNumberTextField.text andPassword:self.setNewCodeTextField.text andSnsCode:self.securityCodeTextField.text];
    
    __weak ResetCodeViewController * weakSelf = self;

    self.net.resetPassWord=^(NSString * message){
    
        [hud hideAnimated:YES];
        
        
        NSLog(@"重置密码状态= %@",message);
        
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
        
        [weakSelf performSelector:@selector(cancleAlraterReset:) withObject:label afterDelay:2];

        
    };
    
}


- (void)cancleAlraterReset:(UILabel *)label{
    [label removeFromSuperview];
    
    if ([label.text isEqualToString:@"找回成功"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
