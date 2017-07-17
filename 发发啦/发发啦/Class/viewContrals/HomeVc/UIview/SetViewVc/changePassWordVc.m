//
//  changePassWordVc.m
//  发发啦
//
//  Created by gxtc on 16/10/20.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "changePassWordVc.h"
#import "NetWork.h"
#import "MBProgressHUD.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface changePassWordVc ()

@property (weak, nonatomic) IBOutlet UITextField *oldPassWorldTextField;

@property (weak, nonatomic) IBOutlet UITextField *passworldNew;

@property (weak, nonatomic) IBOutlet UITextField *passWorldNewAgain;

@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@end

@implementation changePassWordVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)changePassWorldButtonACTION:(id)sender {
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;

    [self.passworldNew resignFirstResponder];
    [self.passWorldNewAgain resignFirstResponder];
    [self.oldPassWorldTextField resignFirstResponder];

    NSLog(@"修改密码!");
    
    
    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermessage"];
    
    NetWork * net = [[NetWork alloc]init];
    
    [net userChangePassWordWithNewCode:self.passworldNew.text andreNewCode:self.passWorldNewAgain.text andUid:dict[@"uid"] andToken:dict[@"token"] andOldCode:self.oldPassWorldTextField.text];
    
    net.changePassWordUnlogin=^(NSString * message){
    
        [hud hideAnimated:YES];
        
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
        [self.view addSubview:messageLabel];
        
        [self performSelector:@selector(dissmissShowMessage:) withObject:messageLabel afterDelay:0.5];
        
    };
}

- (void)dissmissShowMessage:(UILabel *)view{
    
    
    [UIView animateWithDuration:1.0 animations:^{
        view.alpha = 0;
    }];
    
}


- (IBAction)backButtonAction:(id)sender {
    
    NSLog(@"返回");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.passworldNew resignFirstResponder];
    [self.passWorldNewAgain resignFirstResponder];
    [self.oldPassWorldTextField resignFirstResponder];
}






@end
