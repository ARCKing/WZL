//
//  TaoBaoIteamDetailController.m
//  发发啦
//
//  Created by gxtc on 2017/8/5.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "TaoBaoIteamDetailController.h"
#import "TaoBaoListDetailCell.h"
#import "NetWork.h"
#import "MBProgressHUD.h"
#import "HeadAdvScrollerView.h"
#import "UIImageView+WebCache.h"
#import "ShareController.h"

#define ScreenWith [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK_SELF __typeof(self) __weak weakSelf = self

@interface TaoBaoIteamDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)UIView * footView;
@property (nonatomic,strong)NetWork * net;

@property (nonatomic,strong)MBProgressHUD * hud;

@property (nonatomic,strong)HeadAdvScrollerView * headScrollView;

@property (nonatomic,strong)NSMutableArray * imageArr;
@end

@implementation TaoBaoIteamDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.imageArr = [NSMutableArray new];
    
    [self tableViewInit];
    
    [self addButtons];
    
    [self getIteamDetailWithID:self._id];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.hud hideAnimated:YES];
}



- (void)downloadImageViewWithURLArray:(NSArray *)urlArr{

    
    dispatch_group_t imageGroup = dispatch_group_create();
    
    for (NSString * url in urlArr) {
        
        dispatch_group_enter(imageGroup);
        
        SDWebImageManager * manger = [SDWebImageManager sharedManager];
        [manger downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
    
            [self.imageArr addObject:image];
            
            dispatch_group_leave(imageGroup);
        }];
    }
    
    
    dispatch_group_notify(imageGroup,  dispatch_get_main_queue(),^{
       
        NSLog(@"下载完成");
        
        self.tableView.tableHeaderView = self.headScrollView;
        
    });
}




#pragma mark- 获取商品详情
- (void)getIteamDetailWithID:(NSString *)_id{
    WEAK_SELF;

    [self.net getTaoBaoDiscountListDetailDataWithID:self._id];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.hud = hud;
    
    self.net.taoBaoDiscountListDetailBk = ^(NSString *code, NSString *message, NSString *str, NSArray * arr1, NSArray *arr2) {
        
        [hud hideAnimated:YES];
        
        if (arr1.count > 0) {
            
            weakSelf.model = arr1[0];
            
            [weakSelf downloadImageViewWithURLArray:weakSelf.model.imagArr];
            
            [weakSelf.tableView reloadData];
            
            
            
        }
    };
    
}



- (HeadAdvScrollerView *)headScrollView{

    if (!_headScrollView) {
        
        _headScrollView = [[HeadAdvScrollerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenWith)];
        _headScrollView.imageArr = self.imageArr;
    }
    return _headScrollView;
}


- (NetWork *)net{

    if (!_net) {
        
        _net = [[NetWork alloc]init];
    }
    return _net;
}


- (void)addButtons{

    UIButton * shareBt = [self addButton:CGRectMake(0, ScreenHeight - ScreenWith/8, ScreenWith/2, ScreenWith/8) bgColor:[UIColor orangeColor] andTitle:@"分享商品" titleFont:17.0 ];
    [self.view addSubview:shareBt];
    
    
    UIButton * fiftyMoney = [self addButton:CGRectMake(ScreenWith/2, ScreenHeight - ScreenWith/8, ScreenWith/2, ScreenWith/8) bgColor:[UIColor redColor] andTitle:@"领优惠券" titleFont:17.0];
    [self.view addSubview:fiftyMoney];
    
    
    
    UIButton * popBt = [self addButton:CGRectMake(10, 30, 40, 40) bgColor:[UIColor blackColor] andTitle:@"←_←" titleFont:17.0];
    popBt.layer.cornerRadius = 20.0;
    popBt.clipsToBounds = YES;
    [self.view addSubview:popBt];
    
    
    [shareBt addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [fiftyMoney addTarget:self action:@selector(fiftyMoneyAction) forControlEvents:UIControlEventTouchUpInside];
    [popBt addTarget:self action:@selector(popBtAction) forControlEvents:UIControlEventTouchUpInside];

}


- (void)popBtAction{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareAction{

    NSLog(@"分享商品");

    ShareController * share = [[ShareController alloc]init];
    share.imageArr = self.imageArr;
    share.imageUrlArr = self.model.imagArr;
    share.model = self.model;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:share animated:YES];
    
    
}


- (void)fiftyMoneyAction{

    NSLog(@"领50元优惠券");

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"taobao://"]]) {
     
        NSString * url = self.model.couponurl;
        
        NSString * url_1 = [url substringFromIndex:8];
        
        NSLog(@"%@",url_1);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"taobao://%@",url_1]]];
        
    }
    
}


- (void)tableViewInit{

    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenWith)];
    
    head.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableHeaderView = head;
    
    self.tableView.tableFooterView = self.footView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return ScreenWith/4;
    }else{
    
        return ScreenWith/10;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1) {
        
        
        NSLog(@"唤起淘宝");
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"taobao://"]]) {
            
            NSString * taobao = [NSString stringWithFormat:@"taobao://item.taobao.com/item.htm?id=%@",self.model.itemid];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:taobao]];
            
        }
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        TaoBaoListDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        if (cell == nil) {
        
            cell = [[[NSBundle mainBundle] loadNibNamed:@"TaoBaoListDetailCell" owner:self options:nil]firstObject];
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    
    
        
        cell.model = self.model;
        
        return cell;
    
    }else{
    
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        if (cell == nil) {
            
            cell =[[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = @"查看更多宝贝详情";
        
        return cell;
    }
    
}

- (UIView *)footView{

    if (!_footView) {
        
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWith, ScreenWith/10)];
        _footView.backgroundColor = [UIColor lightGrayColor];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, ScreenWith, ScreenWith/10-1)];
        label.text = @"——————精品推荐——————";
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:13.0];
        
        [_footView addSubview:label];
    }
    return _footView;
}



- (UIButton *)addButton:(CGRect )frame bgColor:(UIColor *)bgColor andTitle:(NSString *)title titleFont:(CGFloat)font{

    UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt .frame = frame;
    bt.backgroundColor = bgColor;
    bt.titleLabel.font = [UIFont systemFontOfSize:font];
    [bt setTitle:title forState:UIControlStateNormal];
    return bt;
}

@end
