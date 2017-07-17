//
//  WithdrawView.m
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "WithdrawView.h"
#import "NetWork.h"
#import "selectPickView.h"
#import "withDrawCashRecordModel.h"
//#import "inviateComeDetailCell.h"
#import "withDrawCashRecortCell.h"
#import "MJRefresh.h"


#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface WithdrawView ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)UIView * bgCashView;

@property(nonatomic,retain)UIView * scrollCubeView;

@property(nonatomic,retain)UIView * buttonBgview;
@property(nonatomic,retain)UIButton * sureButton;
@property(nonatomic,retain)withDrawCashRecortCell * myCell;
@property(nonatomic,retain)withDrawCashRecortCell * LastCell;

@property(nonatomic,assign)NSInteger currentPage;

@property(nonatomic,retain)UIView * tableHeadView;
@property(nonatomic,retain)UIScrollView * scrollCashView;

@property(nonatomic,retain)UIView * alipayBgView;
@property(nonatomic,retain)UIView * weiXinpayBgView;

@property(nonatomic,retain)UIView * payModelSelectView;

@property(nonatomic,strong)NSMutableArray * cashArray;
@property(nonatomic,strong)NSMutableArray * cashRecordArray;

@property(nonatomic,strong)UITextField * aliPayAcountTextField;
@property(nonatomic,strong)UITextField * aliPayNameTextField;
@property(nonatomic,strong)UITextField * aliPayCashTextField;

@property(nonatomic,strong)UITextField * weiXinPayTextField;

@property(nonatomic,strong)selectPickView * pickView;

@property(nonatomic,assign)NSInteger currentIndexRow;
@property(nonatomic,assign)NSInteger lastIndexRow;

@property(nonatomic,assign)BOOL isOpen;

@end

@implementation WithdrawView

- (void)initCreat:(NSInteger)page{
    
    self.currentIndexRow = 10000;
    self.lastIndexRow = 10000;
    
    self.backgroundColor = [UIColor lightGrayColor];
    self.cashArray = [NSMutableArray new];
    self.cashRecordArray = [NSMutableArray new];
    
    [self getAliPayCashFromNet];
    
    [self getCashRecordFromNet];
    
    self.currentPage = page;
    
    [self navViewCreat];
    [self twoButtonCreat];
    [self scrollViewCreat];
    [self bgcashViewWithAliAndWeiXinPayCreat];
    [self tableViewCreat];
}

#pragma mark- 获取提现记录
- (void)getCashRecordFromNet{
    
    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defaul objectForKey:@"usermessage"];
    
    NSString * uid = dict[@"uid"];
    NSString * token = dict[@"token"];
    NetWork * net = [[NetWork alloc]init];

    [net withDrawCashRecordWithUid:uid andToken:token];
   
    __weak WithdrawView * weakSelf = self;
    
    net.weiXinPayCash =^(NSArray * array){
    
        [weakSelf.tableView.mj_header endRefreshing];
        
        self.cashRecordArray = [NSMutableArray arrayWithArray:array];
        NSLog(@"%@",self.cashRecordArray);
        
        [self.tableView reloadData];
    };
    
}

#pragma mark- 支付宝金额数量
- (void)getAliPayCashFromNet{
    
    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defaul objectForKey:@"usermessage"];
    
    NSString * uid = dict[@"uid"];
    NSString * token = dict[@"token"];
    
    NetWork * net = [[NetWork alloc]init];
    
    [net cashAboutAliPay:uid andToken:token];
   
    net.aliPayCash=^(NSArray * cash){
    
        self.cashArray = [NSMutableArray arrayWithArray:cash];
    
        NSLog(@"cash =%@",_cashArray);
        
        selectPickView * selpickView = [[selectPickView alloc]initWithFrame:self.bounds];
        selpickView.aliAndWeiXinPayCashArray = [NSArray arrayWithArray:self.cashArray];
        self.pickView = selpickView;
        
    };

}


#pragma mark- 微信金额数量
- (void)getWeiXinCashFromNet{
    
    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defaul objectForKey:@"usermessage"];
    
    NSString * uid = dict[@"uid"];
    NSString * token = dict[@"token"];
    
    NetWork * net = [[NetWork alloc]init];
    
    [net cashAboutWeiXin:uid andToken:token];
    
    __weak WithdrawView * weakSelf = self;
    
    net.weiXinCash=^(NSArray * cash,NSString * code,NSString *message){
        
        weakSelf.cashArray = [NSMutableArray arrayWithArray:cash];
        
        NSLog(@"cash =%@",_cashArray);
        
        selectPickView * selpickView = [[selectPickView alloc]initWithFrame:weakSelf.bounds];
        selpickView.aliAndWeiXinPayCashArray = [NSArray arrayWithArray:weakSelf.cashArray];
        weakSelf.pickView = selpickView;
        
        if ([code isEqualToString:@"2"]) {
            
//            [weakSelf aleratShow:message];
            
            [weakSelf showTheAlterContral:message];
        }
    };

}


- (void)showTheAlterContral:(NSString *)message{

    self.WXBangDing(message);

}



- (void)aleratShow:(NSString *)message{
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.width/4)];
    label.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    label.layer.cornerRadius = 10;
    label.clipsToBounds = YES;
    
    //    [self performSelector:@selector(cancleAlraterReset:) withObject:label afterDelay:2];
    
    [UIView animateWithDuration:8 animations:^{
        
        label.alpha = 0;
    }];
    
}





- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self addSubview:button];
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"提现";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}

#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    NSLog(@"buttonAction");
    if (button.tag == 1000) {
        [button setSelected:YES];
        UIButton * bt = (UIButton *)[self viewWithTag:1001];
        [bt setSelected:NO];
        
        [UIView animateWithDuration:0.3 animations:^{
           
            self.scrollCubeView.frame = CGRectMake(10, SCREEN_W/8 - 4, SCREEN_W/2-10, 4);
        }];
        
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }else if(button.tag == 1001){
        [button setSelected:YES];
         UIButton * bt = (UIButton *)[self viewWithTag:1000];
        [bt setSelected:NO];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollCubeView.frame = CGRectMake(SCREEN_W/2, SCREEN_W/8 - 4, SCREEN_W/2-10, 4);
        }];
        [self.scrollView setContentOffset:CGPointMake(SCREEN_W, 0) animated:YES];
    }else if (button.tag == 7777 || button.tag == 9999) {
        
        NSLog(@"%ld",button.tag);
        [self hiddenKeyBoard];
        
        [self payModelViewCreat];
        
    }else if (button.tag == 8888 || button.tag == 8889) {
        
        [self hiddenKeyBoard];
        
        NSLog(@"%@ %@ %@",self.aliPayAcountTextField.text,self.aliPayNameTextField.text,self.aliPayCashTextField.text);
        [self beginGetCashWithTag:button.tag];
        NSLog(@"确认提现8888");
        
    }else if (button.tag == 6666) {
        
        NSLog(@"6666");
        
        [_payModelSelectView removeFromSuperview];
        
    }else if (button.tag == 6667) {
        
        NSLog(@"6667-支付宝支付");
        [self getAliPayCashFromNet];
        
        self.sureButton.tag = 8888;
        
        [self viewIteamAliPayCreat];
        
        [UIView animateWithDuration:0.3 animations:^{

        self.sureButton.frame = CGRectMake(20, CGRectGetMaxY(_alipayBgView.frame) + 10, SCREEN_W - 40, SCREEN_W/10);
        }];
        
        [self.weiXinpayBgView removeFromSuperview];
        
        [_payModelSelectView removeFromSuperview];

    }else if (button.tag == 6668) {
        NSLog(@"6668-微信支付");
        
        [self getWeiXinCashFromNet];
        
        
        [self viewIteamWWeiXinPayCreat];
        self.sureButton.tag = 8889;

        [UIView animateWithDuration:0.5 animations:^{
            
            self.sureButton.frame = CGRectMake(20, CGRectGetMaxY(_weiXinpayBgView.frame) + 10, SCREEN_W - 40, SCREEN_W/10);

        }];

        [self.alipayBgView removeFromSuperview];
        NSLog(@"6668-微信支付");
        
        [_payModelSelectView removeFromSuperview];

        
    }else if (button.tag == 6669) {
        
        NSLog(@"6669-取消");
        
    }else{
    
    self.backBlock();
    }
}

#pragma mark- scrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     UIButton * button1 = (UIButton *)[self viewWithTag:1000];
     UIButton * button2 = (UIButton *)[self viewWithTag:1001];
     NSLog(@"END");
    
    NSLog(@"scrollView.contentOffset.x = %f",scrollView.contentOffset.x);
    
    if (scrollView.contentOffset.x == 0 && scrollView.tag == 8888) {

         [button1 setSelected:YES];
         [button2 setSelected:NO];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollCubeView.frame = CGRectMake(10, SCREEN_W/8 - 4, SCREEN_W/2-10, 4);
        }];
        
    }else if(scrollView.contentOffset.x == SCREEN_W){
         [button2 setSelected:YES];
         [button1 setSelected:NO];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollCubeView.frame = CGRectMake(SCREEN_W/2, SCREEN_W/8 - 4, SCREEN_W/2-10, 4);
        }];
    }
}


#pragma mark- twoButtonCreat
- (void)twoButtonCreat{

    _buttonBgview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_W/8)];
    _buttonBgview.backgroundColor = [UIColor whiteColor];
    [self addSubview:_buttonBgview];
//    _buttonBgview.backgroundColor = [UIColor purpleColor];
    
    for (int i = 0; i < 2; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_W/2 * i , 0, SCREEN_W/2, SCREEN_W/9);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        button.tag = 1000+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        if (i == 0) {
        [button setTitle:@"我要提现" forState:UIControlStateNormal];
        }else{
        [button setTitle:@"提现记录" forState:UIControlStateNormal];
        
        }
        
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonBgview addSubview:button];
    }
    
    UIButton * bt1 = (UIButton *)[self viewWithTag:1000];
    UIButton * bt2 = (UIButton *)[self viewWithTag:1001];
    
#pragma mark- 页面选中
    if (_currentPage == 0) {
        
        [bt1 setSelected:YES];
    }else if (_currentPage == 1){
        [bt2 setSelected:YES];
    }

    [self scrollViewCubeCreat];
}


#pragma mark- scrollViewCube
- (void)scrollViewCubeCreat{
    
    if(_currentPage == 0){
    self.scrollCubeView = [[UIView alloc]initWithFrame:CGRectMake(10, SCREEN_W/8 - 4, SCREEN_W/2 - 10, 4)];
    }else{
    self.scrollCubeView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/2, SCREEN_W/8 - 4, SCREEN_W/2 - 10, 4)];
    }
    
    
    
    self.scrollCubeView.backgroundColor = [UIColor orangeColor];
    [self.buttonBgview addSubview:_scrollCubeView];
}



#pragma mark- scrollViewCreat
- (void)scrollViewCreat{
    
//    UITapGestureRecognizer *singtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)];

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_buttonBgview.frame) + 1, SCREEN_W, SCREEN_H - 109)];
    [self addSubview:_scrollView];
    
//    [self.scrollView addGestureRecognizer:singtap];
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(SCREEN_W * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    
    if (_currentPage == 0) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        self.scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
    }
#pragma mark- scrollView.tag-8888
    self.scrollView.tag = 8888;
    
}

#pragma mark- bgCashView
- (void)bgcashViewWithAliAndWeiXinPayCreat{
    
    UITapGestureRecognizer *singtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)];

    
    
    
    self.scrollCashView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64 - 44)];
    
    
    [self.scrollCashView addGestureRecognizer:singtap];
    
    
    
//    self.scrollCashView.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:_scrollCashView];
    
    self.scrollCashView.contentSize = CGSizeMake(0, SCREEN_H - 64 - 43);
    
    [self viewIteamAliPayCreat];
    
    
    [self sureButtonCreat];
}


#pragma mark- 提现说明
- (void)drawCashWithExplain{

    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.sureButton.frame) + 15, SCREEN_W/4, 30)];
    title.text = @"提现须知:";
    title.font = [UIFont systemFontOfSize:16];
    title.textColor = [UIColor blackColor];
    [self.scrollCashView addSubview:title];
    
    
    UITextView * detail = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(title.frame), SCREEN_W - 30, SCREEN_H/3)];
    detail.text = [NSString stringWithFormat:@"1.目前支持微信红包和支付宝两种方式\n\n2.微信红包提现需要关注微信公众号：微转啦资讯\n\n3.支付宝需要填写经过实名认证的名字\n\n4.三个工作日内到账(节假日顺延)"];
    detail.font = [UIFont systemFontOfSize:14];
    detail.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [self.scrollCashView addSubview:detail];


}


#pragma mark- 支付宝支付
- (void)viewIteamAliPayCreat{
    
    if (self.alipayBgView) {
        [self.scrollCashView addSubview:_alipayBgView];

        return;
    }
    
    NSMutableArray * textFieldArray = [NSMutableArray new];
    
    self.alipayBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W * 5/9)];
//    self.alipayBgView.backgroundColor = [UIColor redColor];
    [self.scrollCashView addSubview:_alipayBgView];
    
    NSArray * titleArray = @[@"提现方式",@"支付宝账号",@"真实姓名",@"提现金额"];
    
    NSArray * placeHolderArray = @[@"请输入您的支付宝账号",@"请输入您的支付宝认证真实姓名",@"请选择提现金额"];
    
    for (int i = 0; i < 4; i++) {
        
        UIView * bgView = [[UIView alloc]init];
        
        bgView.frame = CGRectMake(-1, 20 + (SCREEN_W/9 + 1)* i, SCREEN_W + 2, SCREEN_W/9);
        
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bgView.layer.borderWidth = 0.5;
        [self.alipayBgView addSubview:bgView];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W/4, SCREEN_W/9)];
        titleLabel.text = titleArray[i];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.textColor = [UIColor blackColor];
        [bgView addSubview:titleLabel];
        
        if (i != 0) {
            UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, SCREEN_W * 3 /4, SCREEN_W/9)];
            textField.delegate = self;
#pragma mark- textField.tag-5550+i
            textField.tag = 5550 + i;
            textField.placeholder = placeHolderArray[i - 1];
            textField.font = [UIFont systemFontOfSize:14];
            [textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];

            
            [bgView addSubview:textField];
            
            [textFieldArray addObject:textField];
            
        }
        
        if (i == 0) {
            
            UILabel * rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W - SCREEN_W/9/2, 0, SCREEN_W/9, SCREEN_W/9)];
            rightLabel.text = @">";
            [bgView addSubview:rightLabel];
            
            UIButton * modeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, SCREEN_W * 3 /4, SCREEN_W/9)];
            [modeButton setImage:[UIImage imageNamed:@"withdraw_icon_zhifubao.png"] forState:UIControlStateNormal];
            [modeButton setTitle:@"支付宝" forState:UIControlStateNormal];
            [modeButton setTitleColor:[UIColor colorWithRed:0 green:150/255.0 blue:230/255.0 alpha:1] forState:UIControlStateNormal];
            modeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            modeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            modeButton.titleLabel.font = [UIFont systemFontOfSize:15];
#pragma mark- modeButton.tag-7777
            modeButton.tag = 7777;
            [modeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:modeButton];
            
        }
        
        
        
    }
    
    self.aliPayAcountTextField = textFieldArray[0];
    self.aliPayNameTextField = textFieldArray[1];
    self.aliPayCashTextField = textFieldArray[2];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = self.aliPayCashTextField.bounds;
    [self.aliPayCashTextField addSubview:button];
    [button addTarget:self action:@selector(aliPayAndWeiXinPayCashButtonAction) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark- 微信支付
- (void)viewIteamWWeiXinPayCreat{
    
    if (self.weiXinpayBgView) {
        [self.scrollCashView addSubview:_weiXinpayBgView];

        return;
    }
    
    self.weiXinpayBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W * 3/9)];
    //    self.alipayBgView.backgroundColor = [UIColor redColor];
    [self.scrollCashView addSubview:_weiXinpayBgView];
    
    NSArray * titleArray = @[@"提现方式",@"提现金额"];
    
    NSArray * placeHolderArray = @[@"请选择提现金额"];
    
    for (int i = 0; i < 2; i++) {
        
        UIView * bgView = [[UIView alloc]init];
        
        bgView.frame = CGRectMake(-1, 20 + (SCREEN_W/9 + 1)* i, SCREEN_W + 2, SCREEN_W/9);
        
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bgView.layer.borderWidth = 0.5;
        [self.weiXinpayBgView addSubview:bgView];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W/4, SCREEN_W/9)];
        titleLabel.text = titleArray[i];
        titleLabel.textColor = [UIColor blackColor];
        [bgView addSubview:titleLabel];
        
        if (i != 0) {
            UITextField * textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, SCREEN_W * 3 /4, SCREEN_W/9)];
            textField.delegate = self;
#pragma mark- textField.tag-6550
            textField.tag = 6550;
            textField.placeholder = placeHolderArray[i - 1];
            textField.font = [UIFont systemFontOfSize:14];
            [textField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
            
            
            [bgView addSubview:textField];
            
            self.weiXinPayTextField = textField;
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = self.weiXinPayTextField.bounds;
            [self.weiXinPayTextField addSubview:button];
            [button addTarget:self action:@selector(aliPayAndWeiXinPayCashButtonAction) forControlEvents:UIControlEventTouchUpInside];

        }
        
        if (i == 0) {
            
            UILabel * rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W - SCREEN_W/9/2, 0, SCREEN_W/9, SCREEN_W/9)];
            rightLabel.text = @">";
            [bgView addSubview:rightLabel];
            
            UIButton * modeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, SCREEN_W * 3 /4, SCREEN_W/9)];
            [modeButton setImage:[UIImage imageNamed:@"withdraw02_icon_weixin.png"] forState:UIControlStateNormal];
            [modeButton setTitle:@"微信" forState:UIControlStateNormal];
            [modeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            modeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            modeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            modeButton.titleLabel.font = [UIFont systemFontOfSize:15];
#pragma mark- modeButton.tag-9999
            modeButton.tag = 9999;
            [modeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:modeButton];
            
        }
        
    }

}

#pragma mark- 隐藏键盘
- (void)hiddenKeyBoard{
    
    NSLog(@"隐藏键盘");
    
    [self.aliPayAcountTextField resignFirstResponder];
    [self.aliPayNameTextField resignFirstResponder];
    [self.aliPayCashTextField resignFirstResponder];
   
}


#pragma mark- 提现方式选择

- (void)payModelViewCreat{

    self.payModelSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    self.payModelSelectView.backgroundColor =[UIColor colorWithRed:36/255.0 green:38/255.0 blue:47/255.0 alpha:0.7];
    
    [self addSubview:_payModelSelectView];
    
    
    for (int i = 0;i < 4 ; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
#pragma mark- button.tag-6666 + i
        button.tag = 6666 + i;
        button.frame = CGRectMake(5, SCREEN_H - 46 - 46 * i, SCREEN_W - 10, 45);
        button.layer.cornerRadius = 6;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.payModelSelectView addSubview:button];
        
        if (i == 0) {
        
            [button setTitle:@"取消" forState:UIControlStateNormal];
        }else if (i == 3) {
            [button setTitle:@"选择提现方式" forState:UIControlStateNormal];
            button.selected = NO;
            
        }else if (i == 1) {
            [button setTitle:@"支付宝" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"withdraw_icon_zhifubao.png"] forState:UIControlStateNormal];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

        }else if (i == 2) {
            [button setTitle:@"微信" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"withdraw02_icon_weixin.png"] forState:UIControlStateNormal];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

        }

        
    }
    
    
    
}


#pragma mark- sureButtonCreat
- (void)sureButtonCreat{

    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.sureButton.frame = CGRectMake(20, CGRectGetMaxY(_alipayBgView.frame) + 10, SCREEN_W - 40, SCREEN_W/10);

    [self.sureButton setTitle:@"确认提现" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureButton.backgroundColor =[UIColor orangeColor];
    [self.scrollCashView addSubview:_sureButton];
    self.sureButton.layer.cornerRadius = 5;
#pragma mark- sureButton.tag- 8888
    self.sureButton.tag = 8888;
    [self.sureButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self drawCashWithExplain];

}



#pragma mark- tableViewCreat
- (void)tableViewCreat{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H - 109) style:UITableViewStylePlain];
//    self.tableView.backgroundColor =[UIColor redColor];
    [self.scrollView addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = SCREEN_W/7;
    [self tableHeadViewCreat];
    
    self.tableView.tableHeaderView = _tableHeadView;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getCashRecordFromNet)];
    
    
}


- (void)tableHeadViewCreat{

    self.tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/8)];
    self.tableHeadView.backgroundColor = [UIColor whiteColor];
  
    
    UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W/4-10, SCREEN_W/8)];
    timeLabel.text = @"时间";
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.backgroundColor = [UIColor whiteColor];
    [self.tableHeadView addSubview:timeLabel];
    
    UILabel * modeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/4, 0, SCREEN_W/4, SCREEN_W/8)];

    modeLabel.text = @"方式";
    modeLabel.textColor = [UIColor blackColor];
    [self.tableHeadView addSubview:modeLabel];
    modeLabel.backgroundColor = [UIColor whiteColor];
    modeLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * cashLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2 + SCREEN_W/16, 0, SCREEN_W/4, SCREEN_W/8)];

    cashLabel.text = @"金额(元)";
    cashLabel.textColor = [UIColor blackColor];
    [self.tableHeadView addSubview:cashLabel];
    cashLabel.backgroundColor = [UIColor whiteColor];

    UILabel * stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W -SCREEN_W/4 + 30 - 10, 0, SCREEN_W/4 -30, SCREEN_W/8)];
    [self.tableHeadView addSubview:stateLabel];
    stateLabel.text = @"状态";
    stateLabel.textColor = [UIColor blackColor];
    stateLabel.backgroundColor = [UIColor whiteColor];
    stateLabel.textAlignment = NSTextAlignmentRight;

    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_W/8, SCREEN_W, 1)];
    line.backgroundColor =[UIColor lightGrayColor];
    [self.tableHeadView addSubview:line];
    
}


#pragma mark- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.cashRecordArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    static NSString * cell_id = @"cell_id";
    self.myCell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (self.myCell == nil) {
        self.myCell = [[withDrawCashRecortCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
        
        self.myCell.selectionStyle = UITableViewCellSelectionStyleNone;
      
    }
    
    withDrawCashRecordModel * model = self.cashRecordArray[indexPath.row];

    if ([model.note isEqualToString:@""]) {
        
        self.myCell.reasonImgView.alpha = 0;
    }else{
    
        self.myCell.reasonImgView.alpha = 1;

    }
    
    self.myCell.cashModel = self.cashRecordArray[indexPath.row];
    return self.myCell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    withDrawCashRecordModel * model = self.cashRecordArray[indexPath.row];

    if ([model.note isEqualToString:@""]) {
        
        return;
    }
    
    
    
    withDrawCashRecortCell * cell = [tableView cellForRowAtIndexPath:indexPath];

    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];

    
    self.currentIndexRow = indexPath.row;
    
    if (cell.isShow == YES) {
        
        cell.isShow = !cell.isShow;
        
        cell.reasonLabel.alpha = 0;
        
        
        cell.reasonImgView.transform = CGAffineTransformIdentity;

        self.isOpen = NO;
        
    }else{
        
        cell.isShow = !cell.isShow;
        self.isOpen = YES;
        
        [UIView animateWithDuration:1 animations:^{
            cell.reasonLabel.alpha = 1;

        }];
        

        cell.reasonImgView.transform = CGAffineTransformIdentity;

        cell.reasonImgView.transform = CGAffineTransformMakeRotation(M_PI);

    }
    
    
    if (self.LastCell && self.LastCell != cell) {
        
        if (self.LastCell.isShow) {
            
            self.LastCell.reasonLabel.alpha = 0;
            
            self.LastCell.isShow = NO;
            
            self.LastCell.reasonImgView.transform = CGAffineTransformIdentity;

        }
        
    }

    
    self.LastCell = cell;

    
    [tableView beginUpdates];
    [tableView endUpdates];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    withDrawCashRecordModel * model = self.cashRecordArray[indexPath.row];
    
    
    
    if (self.currentIndexRow == indexPath.row) {
        
        
        if ((self.lastIndexRow == self.currentIndexRow || [model.note isEqualToString:@""])&&self.isOpen == NO) {
            
            self.lastIndexRow = 10000;

            return SCREEN_W/7;

        }else if (self.isOpen == NO && self.lastIndexRow == 10000){
        
            return SCREEN_W/7;

            
        } else{
        
            self.lastIndexRow = self.currentIndexRow;
            
            return SCREEN_W/5;
        }

    }else{

        return SCREEN_W/7;
    }
    
}



- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSLog(@"结束输入");
    NSLog(@"%@ %@ %@",self.aliPayAcountTextField.text,self.aliPayNameTextField.text,self.aliPayCashTextField.text);
}


#pragma mark- 确认提现

- (void)beginGetCashWithTag:(NSInteger)tag{

    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermessage"];
    
    NetWork * net = [[NetWork alloc]init];
    
    
    NSLog(@"==> %@",self.aliPayNameTextField.text);
    
    [net userWithDrawAboutAliPayWitUid:dict[@"uid"] andToken:dict[@"token"] andPrice:self.aliPayCashTextField.text andAlipayAcount:self.aliPayAcountTextField.text andRealName:self.aliPayNameTextField.text angButtonTag:tag];

    
    
    net.aliPayMessage= ^(NSString * message){
    
        NSLog(@"支付宝提现回调信息 = %@",message);
        NSLog(@"微信提现回调信息 = %@",message);

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
        [messageLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:messageLabel];
        
        [self performSelector:@selector(dissmissShowMessage:) withObject:messageLabel afterDelay:0.5];
    };
    
    
}


- (void)dissmissShowMessage:(UILabel *)view{

    
    [UIView animateWithDuration:1.0 animations:^{
        view.alpha = 0;
    }];
    
}

#pragma mark- 提现回调信息
- (void)showDrawWithCashMessage:(NSString *)message{

    self.cashMessage(message);

}


- (void)aliPayAndWeiXinPayCashButtonAction{
    
    [self hiddenKeyBoard];
    
    [self.pickView DidLoadWithTag:5555555];
    [self addSubview:self.pickView];
    
    
    __weak WithdrawView * weakSelf = self;
    self.pickView.messageBlock=^(NSString * message){
        
        weakSelf.aliPayCashTextField.text = message;
        weakSelf.weiXinPayTextField.text = message;
    };
    
}





//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
//
//    [textField resignFirstResponder];
//}
@end
