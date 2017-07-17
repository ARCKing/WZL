//
//  EditViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/30.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "EditViewController.h"//键盘输入
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface EditViewController ()<UITextFieldDelegate>
@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UITextField * textField;
@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UIButton * enterButton;

@property(nonatomic,retain)NSString * messages;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"--------======-------%ld",_buttonTag);
    
    [self navViewCreat];
    [self textFieldCreat];
    [self enterButttonCreat];
}

#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self.view addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 40);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    self.titleLabel = titleLabel;
    
    
    if (_buttonTag == 2) {
        self.titleLabel.text = @"昵称";
    }else if (_buttonTag == 5) {
        self.titleLabel.text = @"所在地";
    }else if (_buttonTag == 6) {
        self.titleLabel.text = @"详细地址";

    }
    
}


#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 3000) {
        NSLog(@"3000");
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (button.tag == 9999) {
       NSLog(@"9999");
        
        [self.textField resignFirstResponder];
        
        self.sendMessageBlock(_messages);

        
        [self.navigationController popViewControllerAnimated:YES];
        
       
    }
}

#pragma mark-textFieldCreat
- (void)textFieldCreat{
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 65, SCREEN_W - 20, 45)];
    [self.view addSubview:_textField];

    self.textField.placeholder = @"  请在此输入";
    self.textField.delegate = self;
    self.textField.layer.borderWidth = 1;
    self.textField.layer.borderColor = [UIColor blackColor].CGColor;
    self.textField.layer.cornerRadius = 5;
}

#pragma mark- enterButtonCreat
- (void)enterButttonCreat{
    self.enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.enterButton.backgroundColor = [UIColor orangeColor];
    [self.enterButton setTitle:@"确认" forState:UIControlStateNormal];
#pragma mark- enterButton.tag-9999
    self.enterButton.tag = 9999;
    [self.enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.enterButton.frame = CGRectMake(20, CGRectGetMaxY(_textField.frame) + 30, SCREEN_W-40, 40);
    self.enterButton.layer.cornerRadius = 5;
    [self.enterButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_enterButton];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.textField resignFirstResponder];
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField {

    NSLog(@"输入结束=%@",textField.text);
    
    self.messages = textField.text;

}



@end
