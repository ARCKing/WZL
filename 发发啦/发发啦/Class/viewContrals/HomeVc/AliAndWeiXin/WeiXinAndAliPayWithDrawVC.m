//
//  WeiXinAndAliPayWithDrawVC.m
//  微信支付宝UI
//
//  Created by gxtc on 17/3/29.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "WeiXinAndAliPayWithDrawVC.h"
#import "AliPayCell.h"
#import "WithDrawRecordVC.h"
#import "NetWork.h"
#import "MBProgressHUD.h"

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



@interface WeiXinAndAliPayWithDrawVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UISegmentedControl * weixinsegmented;
@property (nonatomic,strong)UISegmentedControl * alipaysegmented;

@property (nonatomic,strong)NSMutableArray * moneyDataArray;

@property (nonatomic,copy)NSString * nicekName;
@property (nonatomic,copy)NSString * aliPayAccount;
@property (nonatomic,copy)NSString * appPassWorld;

@property (nonatomic,copy)NSString * weixinmoneyCount;
@property (nonatomic,copy)NSString * alipaymoneyCount;


@property (nonatomic,strong)UITextField * nickNameField;
@property (nonatomic,strong)UITextField * aliPayAccountField;
@property (nonatomic,strong)UITextField * appPassWorldField;

@property (nonatomic,strong)UILabel * currentMoneyLabel;

@property (nonatomic,strong)UITableView * weiXinTableView;
@property (nonatomic,strong)UITableView * aliPayTableView;

@property (nonatomic,assign)BOOL isWeiXinPay;
@property (nonatomic,strong)UIView * navView;

@property (nonatomic,strong)NSMutableArray * aliCashArray;
@property (nonatomic,strong)NSMutableArray * weiXinCashArray;

@property (nonatomic,strong)MBProgressHUD * HUD;
@end

@implementation WeiXinAndAliPayWithDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.isWeiXinPay = YES;
    
    [self navViewCreat];
    
    [self getWeiXinCashFromNet];
    
    [self getAliPayCashFromNet];
}

- (void)addUI{
    
   self.weiXinTableView = [self tableViewNew];
}



#pragma mark- 支付宝金额数量
- (void)getAliPayCashFromNet{
    
    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defaul objectForKey:@"usermessage"];
    
    NSString * uid = dict[@"uid"];
    NSString * token = dict[@"token"];
    
    NetWork * net = [[NetWork alloc]init];
    __weak WeiXinAndAliPayWithDrawVC * weakSelf = self;

    [net cashAboutAliPay:uid andToken:token];
    
    net.aliPayCash=^(NSArray * cash){
        
        if (cash.count > 0) {
            
            weakSelf.aliCashArray =[ NSMutableArray new];
            
            for (NSNumber * number in cash) {
                
                NSString * cash = [NSString stringWithFormat:@"%@",number];
                
                [weakSelf.aliCashArray addObject:cash];
            }
        }
        
    };
    
}






#pragma mark- 微信金额数量
- (void)getWeiXinCashFromNet{
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD = hud;
    
    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defaul objectForKey:@"usermessage"];
    
    NSString * uid = dict[@"uid"];
    NSString * token = dict[@"token"];
    
    NetWork * net = [[NetWork alloc]init];
    
    [net cashAboutWeiXin:uid andToken:token];
    
    __weak WeiXinAndAliPayWithDrawVC * weakSelf = self;
    
    net.weiXinCash=^(NSArray * cash,NSString * code,NSString *message){
        
        [hud hideAnimated:YES];
        
        if (cash.count > 0) {
            
            weakSelf.weiXinCashArray =[ NSMutableArray new];

            for (NSNumber * number in cash) {
                
                NSString * cash = [NSString stringWithFormat:@"%@",number];
                
                [weakSelf.weiXinCashArray addObject:cash];
            }
            
            
            
            
            [weakSelf addUI];
        }
    
    };
    
}






- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, ScreenWith, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self.view addSubview:button];
    button.tag = 3000;
    [button addTarget:self action:@selector(comeBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"提现";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(ScreenWith/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0,0, ScreenWith/4, 30);
    rightButton.center = CGPointMake(ScreenWith - ScreenWith/8, 45);
    [rightButton setTitle:@"提现记录" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    [rightButton addTarget:self action:@selector(withDrawRecoard) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)comeBackAction{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)withDrawRecoard{
    NSLog(@"提现记录");

    WithDrawRecordVC * vc =[[WithDrawRecordVC alloc]init];
    
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}






#pragma mark- MJReloadData
/**下拉刷新*/
- (void)MJReloadData{
    
    
}



- (UISegmentedControl *)addSegmentedControlNewWithLabel:(UILabel *)titleLabel{
    
    
    //    NSArray * titleArray = @[@"30",@"50",@"100",@"200"];
    //
    //    self.moneyDataArray = [NSMutableArray arrayWithArray:titleArray];
    
    
    if (self.isWeiXinPay) {
    
        self.moneyDataArray = [NSMutableArray arrayWithArray:self.weiXinCashArray];
        
        self.weixinmoneyCount = self.weiXinCashArray[0];
        
    }else{
    
        self.moneyDataArray = [NSMutableArray arrayWithArray:self.aliCashArray];
        
        self.alipaymoneyCount = self.aliCashArray[0];
    }
    
    
    
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithItems:self.moneyDataArray];
    
    segment.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame),(ScreenWith/6 - ScreenWith/13)/2, (ScreenWith * 2/3)/4 *(self.moneyDataArray.count), ScreenWith/13);
    
    segment.selectedSegmentIndex = 0;
    segment.tintColor = [UIColor colorWithRed:0.0 green:217.0/255.0 blue:225.0/255.0 alpha:1.0];
    [segment addTarget:self action:@selector(segmentedSelect:) forControlEvents:UIControlEventValueChanged];
    return segment;
}

- (void)segmentedSelect:(UISegmentedControl *)segmented{
    
    NSInteger index = segmented.selectedSegmentIndex;
    
    if (self.isWeiXinPay) {
        self.weixinmoneyCount = self.weiXinCashArray[index];

    }else{
        self.alipaymoneyCount = self.aliCashArray[index];

    }
    
    
    
    [self outOfFistRspond];
}


#pragma mark- tableViewNew

- (UITableView *)tableViewNew{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, ScreenWith, ScreenHeight - 64) style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = ScreenWith/6;
    
    [self.view addSubview:tableView];
    
    return tableView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AliPayCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[AliPayCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.isWeiXinPay) {
        
        UILabel * label = [cell addCellRootLabelNewWithFram:CGRectMake(15, 0, ScreenWith/4, ScreenWith/6) andBackGroundColor:[UIColor whiteColor] andTextColor:[UIColor blackColor] andFont:15 andTitle:@"提现金额:" andNSTextAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:label];

        
        UISegmentedControl * vc = [self addSegmentedControlNewWithLabel:label];
        self.weixinsegmented = vc;
        [cell.contentView addSubview:vc];
        
        return cell;

    }else{
    
        NSArray * titleArray = @[@"姓名:",@"支付宝账号:",@"提现金额:"];
        NSArray * placeHolderArray = @[@"你的支付宝实名",@"你的支付宝账号"];
    
    
        UILabel * label = [cell addCellRootLabelNewWithFram:CGRectMake(15, 0, ScreenWith/4, ScreenWith/6) andBackGroundColor:[UIColor whiteColor] andTextColor:[UIColor blackColor] andFont:15 andTitle:titleArray[indexPath.row] andNSTextAlignment:NSTextAlignmentLeft];
        [cell.contentView addSubview:label];
    
    
        if (indexPath.row != 2) {
        
            UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake(ScreenWith/4 +10, 0, ScreenWith*3/4 - 10, ScreenWith/6)];
            field.placeholder = placeHolderArray[indexPath.row];
            field.font = [UIFont systemFontOfSize:15];
            field.delegate = self;
            field.clearButtonMode = UITextFieldViewModeWhileEditing;
            [cell addSubview:field];
        
            if (indexPath.row == 0) {
            
                self.nickNameField = field;
            
            }else if (indexPath.row == 1){
            
                self.aliPayAccountField = field;
            
            }else{
            
                field.secureTextEntry = YES;
                self.appPassWorldField = field;
            }
        }
    
        if (indexPath.row == 2) {
        
            UISegmentedControl * vc = [self addSegmentedControlNewWithLabel:label];
            self.alipaysegmented = vc;
            [cell.contentView addSubview:vc];
        }
        return cell;

    }
    
}




- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    NSLog(@"1==>%@",self.nickNameField.text);
    NSLog(@"2==>%@",self.aliPayAccountField.text);
    NSLog(@"3==>%@",self.appPassWorldField.text);
    
    self.nicekName = self.nickNameField.text;
    self.aliPayAccount = self.aliPayAccountField.text;
    self.appPassWorld = self.appPassWorldField.text;
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self outOfFistRspond];
    return YES;
}

- (void)outOfFistRspond{
    
    [self.nickNameField resignFirstResponder];
    [self.aliPayAccountField resignFirstResponder];
    [self.appPassWorldField resignFirstResponder];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.HUD hideAnimated:YES];

    
    [self outOfFistRspond];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.isWeiXinPay == YES) {
        return 1;
    }else{
    
        return 3;
    }
}

#pragma mark- 分组高度
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScreenWith/8;//section头部高度
}


//section头部视图
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenWith/8)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton * aliPayBt = [self addRootButtonTypeTwoNewFram:CGRectMake(ScreenWith/2, 0, ScreenWith/2, ScreenWith/8) andImageName:@"zfbtx" andTitle:@"支付宝提现" andBackGround:[UIColor colorWithRed:0.0 green:150.0/255.0 blue:230.0/255.0 alpha:1] andTitleColor:[UIColor whiteColor] andFont:17.0 andCornerRadius:0.0];
    [aliPayBt addTarget:self action:@selector(aliPayWithDrawAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:aliPayBt];
    aliPayBt.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    
    UIButton * weiXinPayBt = [self addRootButtonTypeTwoNewFram:CGRectMake(0, 0, ScreenWith/2, ScreenWith/8) andImageName:@"wxtx" andTitle:@"微信提现" andBackGround:[UIColor colorWithRed:65.0/255.0 green:190.0/255.0 blue:30.0/255.0 alpha:1] andTitleColor:[UIColor whiteColor] andFont:17.0 andCornerRadius:0.0];
    [weiXinPayBt addTarget:self action:@selector(weixinWithDrawAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:weiXinPayBt];
    weiXinPayBt.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

    
    if (self.isWeiXinPay) {
        
        aliPayBt.backgroundColor = [UIColor lightGrayColor];
    }else{
    
        weiXinPayBt.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    
    return view ;
}


- (void)weixinWithDrawAction{

    NSLog(@"微信提现");
    
    self.isWeiXinPay = YES;

    [self.view addSubview:self.weiXinTableView];
    [self.aliPayTableView removeFromSuperview];


}

- (void)aliPayWithDrawAction{

    NSLog(@"支付宝提现");
    self.isWeiXinPay = NO;

    if (self.aliPayTableView == nil) {
        
        self.aliPayTableView = [self tableViewNew];
    }
    
    [self.view addSubview:self.aliPayTableView];
    [self.weiXinTableView removeFromSuperview];
}



//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    
    return ScreenHeight - 64 - ScreenWith/8 - ScreenWith/6 * 4;
    
}
//section底部视图
- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenHeight - 64 - ScreenWith/8 - ScreenWith/6 * 4)];
    view.backgroundColor = [UIColor clearColor];
    
    
    UILabel * titleLabel1 = [self addRootLabelWithfram:CGRectMake(20, 10, ScreenWith - 40, ScreenWith/10) andTitleColor:[UIColor lightGrayColor] andFont:14.0 andBackGroundColor:[UIColor clearColor] andTitle:@"*提现后将于5个工作日内到账"];
    
    
    UIButton * bt = [self addRootButtonTypeTwoNewFram:CGRectMake(20, CGRectGetMaxY(titleLabel1.frame) + 5, ScreenWith - 40, ScreenWith/10) andImageName:@"" andTitle:@"申请提现" andBackGround:[UIColor colorWithRed:0.0 green:210.0/255.0 blue:1.0 alpha:1] andTitleColor:[UIColor whiteColor] andFont:15.0 andCornerRadius:5.0];
    [bt addTarget:self action:@selector(AliPayWithDraw) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel2 = [self addRootLabelWithfram:CGRectMake(20, CGRectGetMaxY(bt.frame) + 10, ScreenWith - 40, 0) andTitleColor:[UIColor redColor] andFont:14.0 andBackGroundColor:[UIColor clearColor] andTitle:@"注意!\n提现规则:\n1.为保证平台的公平性，所有提现申请都将进行人工审核;非正常积分获取将被视为作弊行为,其提现申请将被拒绝\n2.为保障您的资金安全，提现申请审核通过后，将通过人工处理第三方支付平台汇入到您的账户\n3.提现到账期一般为三个工作日,法定节假日顺延,请注意查收"];
    titleLabel2.numberOfLines = 0;
    [titleLabel2 sizeToFit];
    
    [view addSubview:titleLabel1];
    [view addSubview:bt];
    [view addSubview:titleLabel2];
    
    
    return view;
}

- (UILabel *)addRootLabelWithfram:(CGRect)fram andTitleColor:(UIColor *)color andFont:(CGFloat)size andBackGroundColor:(UIColor *)backColor andTitle:(NSString *)text{
    
    UILabel * label = [[UILabel alloc]initWithFrame:fram];
    label.backgroundColor = backColor;
    label.textColor = color;
    label.text =  text;
    label.font = [UIFont systemFontOfSize:size];
    
    return label;
}


- (UIButton *)addRootButtonTypeTwoNewFram:(CGRect)fram andImageName:(NSString * )imageName andTitle:(NSString *)title
                            andBackGround:(UIColor *)color1 andTitleColor:(UIColor *)color2 andFont:(CGFloat)font
                          andCornerRadius:(CGFloat)radius{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = fram;
    button.backgroundColor = color1;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color2 forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.layer.cornerRadius = radius;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.clipsToBounds = YES;
    
    return button;
}

- (NSMutableAttributedString *)addRootInsertAttributedText1:(NSString *)text1 andText2:(NSString *)text2 andIndex:(NSUInteger)index andColor1:(UIColor *)color1
                                                  andColor2:(UIColor *)color2 andFont1:(CGFloat)font1 andFont2:(CGFloat)font2{
    
    NSMutableAttributedString * attributrdString1 = [[NSMutableAttributedString alloc]initWithString:text1];
    NSMutableAttributedString * attributrdString2 = [[NSMutableAttributedString alloc]initWithString:text2];
    
    
    NSRange range1 = [text1 rangeOfString:text1];
    NSRange range2 = [text2 rangeOfString:text2];
    
    [attributrdString1 addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, range1.length)];
    
    [attributrdString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font1] range:NSMakeRange(0, range1.length)];
    
    [attributrdString2 addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(0,range2.length)];
    [attributrdString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font2] range:NSMakeRange(0, range2.length)];
    
    
    [attributrdString1 insertAttributedString:attributrdString2 atIndex:index];
    
    return attributrdString1;
}



- (void)AliPayWithDraw{
    
    
    [self outOfFistRspond];
    
    NSLog(@"申请提现");
  
    
    NSInteger tag ;
    NSString * cash;
    
    if (self.isWeiXinPay) {
        
        NSLog(@"%@",self.weixinmoneyCount);
        cash = self.weixinmoneyCount;
        
        tag = 8889;
    }else{
    
        
        NSLog(@"%@",self.nicekName);
        NSLog(@"%@",self.aliPayAccount);
//        NSLog(@"%@",self.appPassWorld);

        NSLog(@"%@",self.alipaymoneyCount);
        cash= self.alipaymoneyCount;
        tag = 8888;
    }
    
    
    
    [self beginGetCashWithTag:tag andCash:cash];
    
    
}

#pragma mark- 申请提现

- (void)beginGetCashWithTag:(NSInteger)tag andCash:(NSString *)cash{
    
    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"usermessage"];
    
    NetWork * net = [[NetWork alloc]init];
    
    
    
    [net userWithDrawAboutAliPayWitUid:dict[@"uid"] andToken:dict[@"token"] andPrice:cash andAlipayAcount:self.aliPayAccount andRealName:self.nicekName angButtonTag:tag];
    
    
    
    net.aliPayMessage= ^(NSString * message){
        
        NSLog(@"支付宝提现回调信息 = %@",message);
        NSLog(@"微信提现回调信息 = %@",message);
        
        UILabel * messageLabel = [[UILabel alloc]init];
        messageLabel.frame = CGRectMake(0, 0, ScreenWith/2, ScreenWith/4);
        messageLabel.center = CGPointMake(ScreenWith/2, ScreenHeight/3);
        messageLabel.text = message;
        //        messageLabel.font = [UIFont systemFontOfSize:14];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor =[ UIColor blackColor];
        messageLabel.layer.cornerRadius = 5;
        messageLabel.clipsToBounds = YES;
        messageLabel.numberOfLines = 0;
        [messageLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
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
@end
