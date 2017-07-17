//
//  LogInViewController.m
//  TestDemo
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "LogInViewController.h"
#import "ResetCodeViewController.h"
#import "RegisterViewController.h"
#import "NetWork.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "MBProgressHUD.h"
#import <UMMobClick/MobClick.h>

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@property (weak, nonatomic) IBOutlet UIButton *regsiteButton;
@property (weak, nonatomic) IBOutlet UIButton *reSetCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *weiXingLogButton;


@property(nonatomic,copy)NSString * userName;
@property(nonatomic,copy)NSString * passWard;
@property(nonatomic,retain)NetWork * net;

@property(nonatomic,retain)UIAlertController * alertController;
@property(nonatomic,retain)MBProgressHUD * hud;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.net = [[NetWork alloc]init];
    
    

}


#pragma mark- 手机号输入框
- (IBAction)phoneNumberTextFieldDidBeginEditing:(id)sender {
    NSLog(@"beging");
}

- (IBAction)phoneNumberTextFieldEditingChanged:(id)sender {
    NSLog(@"change");
    
}

- (IBAction)phoneNumberTextFieldDidEndEditing:(id)sender {
    NSLog(@"end");
    self.userName = self.phoneNumberTextField.text;
}

#pragma mark- 密码输入框
- (IBAction)codeTextFieldDidBeginEding:(id)sender {
}


- (IBAction)codeTextFieldEdingChanged:(id)sender {
}

- (IBAction)codeTextFieldDidEndEding:(id)sender {
    self.passWard = self.codeTextField.text;
}


#pragma mark- 登录按钮
- (IBAction)logInButtonAction:(id)sender {
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    self.hud = hud;
    
    [self.phoneNumberTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
    [self.net userLogInWithUserName:_userName andPassWord:_passWard];
    
    
    __weak LogInViewController * weakSelf = self;

    self.net.messageLogInBlock = ^(NSString * code,NSString * message){
        
        [hud hideAnimated:YES];
        
        if ([code isEqualToString:@"1"]) {
            
            [weakSelf.net firstVcMessageGetOfNet];
            
            weakSelf.net.userInfoMessageB=^(NSString * message,BOOL bb){
            
            };
            
            [weakSelf dismissViewControllerAnimated:YES completion:nil];

#pragma mark- 账号登陆统计
            [MobClick profileSignInWithPUID:weakSelf.phoneNumberTextField.text];
            
        }else{
        
            [weakSelf addAleartViewWithLogInMessage:message];
//            [weakSelf dismissViewControllerAnimated:YES completion:nil];

        }
    };
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNumberTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
    [self.hud hideAnimated:YES];
}

#pragma mark- 取消按钮
- (IBAction)deleteButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"=====");
}


#pragma mark- 手机号注册

- (IBAction)phongNumberResignButtonAction:(id)sender {
    RegisterViewController * registerVc = [[RegisterViewController alloc]init];
    [self presentViewController:registerVc animated:YES completion:nil];

}


#pragma mark- 重置密码

- (IBAction)rSetCodeButtonAction:(id)sender {
    ResetCodeViewController * rsetCodeVc = [[ResetCodeViewController alloc]init];
    [self presentViewController:rsetCodeVc animated:YES completion:nil];

}



#pragma mark- 微信登录

- (IBAction)weixingLogInButtonAction:(id)sender {
    
    NSLog(@"我是微信登录");
    NSLog(@"%s",__func__);
    
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo" ;
        req.state = @"App";
        [WXApi sendReq:req];
    }
    else {
        [self setupAlertController];
    }
    
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneRegister:) name:@"openid" object:nil];
    
}



- (void)phoneRegister:(NSNotification *)notifiction{

    NSDictionary * dic = notifiction.userInfo;
    
            NSLog(@"%@",dic);
            RegisterViewController * registerVc = [[RegisterViewController alloc]init];
            registerVc.openId = dic[@"openid"];
            registerVc.access_token = dic[@"access_token"];
            NSLog(@"%@",registerVc.openId);
            [self presentViewController:registerVc animated:NO completion:nil];
    
    
}



//微信安装提示
- (void)setupAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark- 登录成功提示


- (void)addAleartViewWithLogInMessage:(NSString *)message{

    _alertController = [UIAlertController  alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [_alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:_alertController animated:YES completion:nil];

}



@end
