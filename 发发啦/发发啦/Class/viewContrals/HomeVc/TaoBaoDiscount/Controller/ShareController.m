//
//  ShareController.m
//  发发啦
//
//  Created by macos on 2017/8/6.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ShareController.h"

@interface ShareController ()
@property (weak, nonatomic) IBOutlet UILabel *selectNumLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *weiChatBt;

@property (weak, nonatomic) IBOutlet UIButton *friendBt;

@property (weak, nonatomic) IBOutlet UIButton *weiBoBt;

@property (weak, nonatomic) IBOutlet UIButton *QQBt;

@property (weak, nonatomic) IBOutlet UIButton *QZoneBt;

@end

@implementation ShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)popBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)coppButtonAction:(id)sender {
    
    
    NSLog(@"复制文案");
}



- (IBAction)weiChatBtAction:(id)sender {
    NSLog(@"微信分享");
}



- (IBAction)friendBtAction:(id)sender {

    NSLog(@"朋友圈分享");
}



- (IBAction)weiboBtAction:(id)sender {

    NSLog(@"微博分享");
}



- (IBAction)QQBtAction:(id)sender {
    
    NSLog(@"QQ分享");
}



- (IBAction)qzoneBtAction:(id)sender {
    
    NSLog(@"QQ空间分先");
}


@end
