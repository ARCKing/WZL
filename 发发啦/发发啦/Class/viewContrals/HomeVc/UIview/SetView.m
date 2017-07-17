//
//  SetView.m
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "SetView.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface SetView ()
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UISwitch * mysWitch;
@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UILabel * label;

@property(nonatomic,retain)UIButton * exitButton;

@property(nonatomic,retain)NSUserDefaults * userDefaults;

//存放缓存的大小
@property (nonatomic ,assign)CGFloat Cache;
@property (nonatomic,strong)UILabel * cacheLabel;

@end

@implementation SetView

/**初始化界面*/
- (void)initCreat{

    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [self navViewCreat];
    [self scrollViewCreat];
    
    [self exitButtonCreat];
    
    
    [self.userDefaults addObserver:self forKeyPath:@"isLogIn" options:NSKeyValueObservingOptionNew context:nil];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

    if ([[self.userDefaults objectForKey:@"isLogIn"] isEqualToString:@"1"]) {
        
        [self.scrollView addSubview:_exitButton];
    }

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
#pragma mark- '<-'button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 40);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
}


- (void)scrollViewCreat{

//    NSArray * buttonPicArray = @[@"install_set.png",@"install_edit.png",@"install_revise.png",@"system_info.png",@"install_clear.png",@"install_score.png",@"install_about.png",@"install_hide.png"];
//    NSArray * buttonTitleArray = @[@"账号绑定",@"编辑资料",@"修改登录密码",@"接收系统推送",@"清理缓存",@"去评分",@"关于微转啦",@"隐私保护"];
    
    
        NSArray * buttonPicArray = @[@"install_set.png",@"install_edit.png",@"install_revise.png",@"system_info.png",@"install_clear.png",@"install_score.png",@"install_about.png",@"install_hide.png"];
        NSArray * buttonTitleArray = @[@"账号绑定",@"编辑资料",@"修改登录密码",@"我的收藏",@"清理缓存",@"去评分",@"关于微转啦",@"隐私保护"];

    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64 + 20, SCREEN_W, SCREEN_H - 84)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    self.scrollView.contentSize = CGSizeMake(SCREEN_W, SCREEN_H - 83);
    [self addSubview:_scrollView];

    for (int i = 0; i < 8; i ++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:buttonPicArray[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
#pragma mark- 调整按钮文字图片位置
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        if (i < 3) {
            button.frame = CGRectMake(0, (45 + 1) * i, SCREEN_W, 45);
            
        }else if (i == 3){
            button.frame = CGRectMake(0,15+ (45 + 1) * i, SCREEN_W, 45);
        }else if (i < 6){
            button.frame = CGRectMake(0,30+ (45 + 1) * i, SCREEN_W, 45);
            
        }else if (i < 8){
            button.frame = CGRectMake(0,45+ (45 + 1) * i, SCREEN_W, 45);

        }
        
        
       
            _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
            _label.text = @">";
            _label.textColor = [UIColor lightGrayColor];
            _label.center = CGPointMake(SCREEN_W - 8, button.bounds.size.height/2);
            [button addSubview:_label];
#pragma mark- 开关
//            self.mysWitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
//            self.mysWitch.center = CGPointMake(SCREEN_W - 40, button.bounds.size.height/2);
//            [button addSubview:_mysWitch];
        

        
        
        
        if (i == 4 || i == 6) {
            
            if (i == 4) {
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_label.frame) - 160, 8, 150, 30)];
                label.textAlignment = NSTextAlignmentRight;
                [button addSubview:label];
                label.textColor = [UIColor lightGrayColor];
                self.cacheLabel = label;

#pragma mark- 缓存计算
                //程序进入就计算缓存大小
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
                NSLog(@"%@",paths);
        
                NSString *cachesDir = [paths objectAtIndex:0];
   
                self.Cache = [self folderSizeAtPath:cachesDir];

                label.text = [NSString stringWithFormat:@"%.2fM",_Cache];

                
            }else{
                
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_label.frame) - 160, 8, 150, 30)];
                label.textAlignment = NSTextAlignmentRight;
                [button addSubview:label];
                label.textColor = [UIColor lightGrayColor];
                label.text = @"1.1.4";
            }
        }
        
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
    }
    
    
    
}

#pragma mark-计算目录大小
//计算目录大小
- (float)folderSizeAtPath:(NSString*)path
{
    NSFileManager*fileManager = [NSFileManager defaultManager];
    CGFloat folderSize = 0.0;
    
    if([fileManager fileExistsAtPath:path]) {
        
        NSArray * childerFiles=[fileManager subpathsAtPath:path];
        
        for(NSString *fileName in childerFiles) {
            
            NSString*absolutePath = [path stringByAppendingPathComponent:fileName];
            // 计算单个文件大小
            folderSize += [self fileSizeAtPath:absolutePath];
        }
    }
    return folderSize;
}


#pragma mark- 计算单个文件大小返回值是M
//计算单个文件大小返回值是M
- (float)fileSizeAtPath:(NSString*)path
{
    NSFileManager*fileManager=[NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:path]){
        
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        // 返回值是字节B K M
        return size/1024.0/1024.0;
    }
    return 0;
}


#pragma mark-清理缓存文件
//清理缓存文件
//同样也是利用NSFileManager API进行文件操作，SDWebImage框架自己实现了清理缓存操作，我们可以直接调用。
- (void)clearCache:(NSString*)path
{
    
    NSFileManager*fileManager=[NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:path]) {
        
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        for(NSString * fileName in childerFiles) {
            
            //如有需要，加入条件，过滤掉不想删除的文件
            
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    // SDImageCache 自带缓存
//    [[SDImageCache sharedImageCache] cleanDisk];
}


//清空数据库
-(void)ClearManager
{
    if (self.Cache==0) {
        return;
    }
    //清理缓存文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    [self clearCache:cachesDir];
    
    self.cacheLabel.text = @"0.00M";
}

#pragma mark- 创建退出按钮
- (void)exitButtonCreat{
    self.exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.exitButton.backgroundColor = [UIColor redColor];
    [self.exitButton setTitle:@"退出" forState:UIControlStateNormal];
    self.exitButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    UIButton * bt = (UIButton *)[_scrollView viewWithTag:1007];
    
    self.exitButton.frame = CGRectMake(0,0 , SCREEN_W - 40, SCREEN_W/10);
    self.exitButton.center = CGPointMake(SCREEN_W/2,CGRectGetMaxY(bt.frame) + (_scrollView.bounds.size.height - CGRectGetMaxY(bt.frame))/2);
    
    
    if ([[_userDefaults objectForKey:@"isLogIn"] isEqualToString:@"1"]) {
    [self.scrollView addSubview:_exitButton];
    }
    
#pragma mark- exitButton.tag-404
    self.exitButton.tag = 404;
    self.exitButton.layer.cornerRadius = 5;
    self.exitButton.layer.borderWidth = 1;
    self.exitButton.layer.borderColor = [UIColor redColor].CGColor;
    [self.exitButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}



- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 3000) {
        NSLog(@"3000-返回");
        self.exitBlock();
    }else if (button.tag == 1000) {
        NSLog(@"1000-绑定账号");
        
        if ([[_userDefaults objectForKey:@"isLogIn"] isEqualToString:@"0"] ||[_userDefaults objectForKey:@"isLogIn"] == nil) {
            
            self.logBlock();
        }else{
        
            self.bdWeiXing();
        
        }
        
        
        
        
        
    }else if (button.tag == 1001) {
        NSLog(@"1001");
        
        if ([[_userDefaults objectForKey:@"isLogIn"] isEqualToString:@"0"]||[_userDefaults objectForKey:@"isLogIn"] == nil) {
            
            self.logBlock();
        }else {
            self.editBolck();
        }
        
    }else if (button.tag == 1002) {
        NSLog(@"1002");
        
        if ([[_userDefaults objectForKey:@"isLogIn"] isEqualToString:@"0"]||[_userDefaults objectForKey:@"isLogIn"] == nil) {
            
            self.logBlock();
        }else {
            
            self.newPassBlock();
            
            
            
        }

        
        
    }else if (button.tag == 1003) {
        NSLog(@"1003");
        
        
        self.collectionBK();
        
    }else if (button.tag == 1004) {
        NSLog(@"1004-清除缓存");
        
        self.clearBlock();
        
    }else if (button.tag == 1005) {
        NSLog(@"1005");
        
//        跳转商店内应用评论页面
//        static NSString * const reviewURL = @"itms-apps://itunes.apple.com/app/id1130831093";
        
//        static NSString * const reviewURL = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&onlyLatestVersion=true&pageNumber=0&sortOrdering=2&id=1091154038";
        
        static NSString * const reviewURL = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&onlyLatestVersion=true&pageNumber=0&sortOrdering=2&id=1130831093";
        
//        NSString *reviewURL =@" https://itunes.apple.com/cn/app/wei-zhuan-la/id1130831093?l=zh&ls=1&mt=8";


        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
        
        
//        跳转商店内应用首页
//        itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&id=xxxxxxxx

        
    }else if (button.tag == 1006) {
        NSLog(@"1006-关于微转啦");
        
        self.aboutUs();
        
    }else if (button.tag == 1007) {
        NSLog(@"1007-隐私保护");
        self.toWeb();
    }else if (button.tag == 404) {
        NSLog(@"404-退出登录");
        
        self.exitBlock2();
        [[NSNotificationCenter defaultCenter]postNotificationName:@"stopTimer" object:nil];
    }

}


@end
