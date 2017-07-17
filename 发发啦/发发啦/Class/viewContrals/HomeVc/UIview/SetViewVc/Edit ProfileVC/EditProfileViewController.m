//
//  EditProfileViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/30.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "EditProfileViewController.h"//我的资料
#import "EditViewController.h"
#import "selectPickView.h"
#import "NetWork.h"
#import "UIImageView+WebCache.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface EditProfileViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UIImageView * imageIconView;
@property(nonatomic,retain)UIImage * imageIcon;

@property(nonatomic,retain)UIButton * resiveButton;

@property(nonatomic,retain)UIAlertController * alertControll;

@property(nonatomic,retain)UIImagePickerController * pickerControll;

@property(nonatomic,retain)NSUserDefaults * userDefaults;

@property(nonatomic,strong)NSDictionary * userInfoDic;

@property(nonatomic,strong)NetWork * net;

@end

@implementation EditProfileViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    if (self.imageIcon) {
        
        self.imageIconView.image = self.imageIcon;
    }else{
    
        NSDictionary * dic = [_userDefaults objectForKey:@"usermessage"];
        
        NSString * headimgurl = dic[@"headimgurl"];

        [self.imageIconView sd_setImageWithURL:[NSURL URLWithString:headimgurl]];
    
    }
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initCreat];

}

- (void)initCreat{
    _userDefaults = [NSUserDefaults standardUserDefaults];
    _userInfoDic = [_userDefaults objectForKey:@"usermessage"];
    
    [self navViewCreat];
    [self scrollViewcreat];
    [self userIconCreat];

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
    titleLabel.text = @"我的资料";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 40);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}

#pragma mark- scrollViewcreat
- (void)scrollViewcreat{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    [self.view addSubview:_scrollView];
    
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_H - 63);
    self.scrollView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    [self creatButton];
}




#pragma mark- 获取用户头像
- (void)userIconCreat{

    UIView * views = (UIView *)[self.view viewWithTag:3330];
        
        self.imageIconView = [[UIImageView alloc]initWithFrame:CGRectMake(-SCREEN_W/7/2, 0,views.bounds.size.height, views.bounds.size.height)];
        
        [views addSubview:_imageIconView];
        
        self.imageIconView.layer.cornerRadius = views.bounds.size.height/2;
        self.imageIconView.clipsToBounds = YES;
        
        NSDictionary * dic = [_userDefaults objectForKey:@"usermessage"];
    
        NSString * headimgurl = dic[@"headimgurl"];
    
        if (headimgurl == nil) {
            self.imageIconView.image = [UIImage imageNamed:@"icon_1.png"];
            
        }else{
            
            [self.imageIconView sd_setImageWithURL:[NSURL URLWithString:headimgurl]];
            
        }
    

}


#pragma mark- userIfon
- (void)creatButton{

//    NSMutableArray * viewArray = [NSMutableArray new];
    NSArray * titleArray = @[@"设置头像",@"会员号",@"昵称",@"性别",@"年龄",@"城市",@"详细地址",@"行业",@"收入"];
    
    for (int i = 0; i < 9; i++) {
        
        UIView * views = [[UIView alloc]init];
        views.backgroundColor = [UIColor whiteColor];
        views.layer.cornerRadius = 5;
#pragma mark- views.tag-3330+i
        views.tag = 3330 + i;
        if (i == 0) {
            views.frame = CGRectMake(SCREEN_W/7/2 + 10, 15, (SCREEN_W - 20) -SCREEN_W/7/2, SCREEN_W/7);
        }else if (i == 1) {
            views.frame = CGRectMake(10, SCREEN_W/7 + 15 + 15 , (SCREEN_W - 20), SCREEN_W/8);
        }else {
            views.frame = CGRectMake(10, (SCREEN_W/8 + 15 + 15 + SCREEN_W/7 + 15 ) + (i - 2) * (SCREEN_W/8 + 1) , (SCREEN_W - 20), SCREEN_W/8);
        }
        
        UILabel * title = [[UILabel alloc]init];
        
        if (i == 0) {
            
            title.frame = CGRectMake(views.bounds.size.width/8, 0, 100, views.bounds.size.height);
            
        }else {
            
            title.frame = CGRectMake(15, 0, 80, views.bounds.size.height);
        }
        
        
        title.text = titleArray[i];
        title.textColor = [UIColor blackColor];
        title.font = [UIFont systemFontOfSize:15];
        [views addSubview:title];
        
        
        UILabel * rightLabel =[[UILabel alloc]init];
        
        if (i != 1) {
            rightLabel.frame = CGRectMake(0, 0, 30, SCREEN_W/8);
            rightLabel.center = CGPointMake(views.bounds.size.width - 10, views.bounds.size.height/2);
        }
        
        rightLabel.text = @">";
        rightLabel.textColor = [UIColor lightGrayColor];
        rightLabel.font = [UIFont systemFontOfSize:20];
        [views addSubview:rightLabel];
        
        
        UILabel * detailLabel = [[UILabel alloc]init];
        if (i != 0) {
            detailLabel.frame = CGRectMake(CGRectGetMaxX(title.frame) + 30, 0, SCREEN_W * 2/3 - 30, views.bounds.size.height);
           
        }
        
//        detailLabel.backgroundColor =[UIColor redColor];
        
#pragma mark- 读取用户数据
        
        if (i == 1) {
            
            detailLabel.text = _userInfoDic[@"uid"];

        }else if (i == 2) {
            detailLabel.text = _userInfoDic[@"nickname"];
        }else if (i == 3) {
            
            if ([_userInfoDic[@"sex"]isEqualToString:@"0"]) {
                
                detailLabel.text = @"未知";
            }else if ([_userInfoDic[@"sex"] isEqualToString:@"1"]){
            
                detailLabel.text = @"男";
                
            }else{
            
                detailLabel.text = @"女";

            }
            
            
        }else if (i == 4) {
            detailLabel.text = _userInfoDic[@"age"];

        }else if (i == 5) {
            
            NSString * city = [NSString stringWithFormat:@"%@ %@",_userInfoDic[@"province"],_userInfoDic[@"city"]];
            
            detailLabel.text = city;

        }else if (i == 6) {
            detailLabel.text = _userInfoDic[@"address"];

        }else if (i == 7) {
            detailLabel.text = _userInfoDic[@"industry"];

        }else if (i == 8) {
            detailLabel.text = _userInfoDic[@"monthly_income"];

        }
        
            
        
//        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.textColor = [UIColor blackColor];
        [views addSubview:detailLabel];
        
#pragma mark- detailLabel.tag- 2220+i
        detailLabel.tag = 2220 + i;
        [self.scrollView addSubview:views];
        
//        [viewArray addObject:views];
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, views.bounds.size.width, views.bounds.size.height);
        
#pragma mark- button.tag- 1110+i
        button.tag = 1110 + i;
        [views addSubview:button];
        
       [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIView * vv = (UIView *)[_scrollView viewWithTag:3338];
    
#pragma resiveButton
    self.resiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.resiveButton setTitle:@"修改" forState:UIControlStateNormal];
    self.resiveButton.backgroundColor = [UIColor orangeColor];
    [self.resiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.resiveButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.resiveButton.frame = CGRectMake(20, CGRectGetMaxY(vv.frame) + vv.bounds.size.height/2, SCREEN_W - 40, 35);
    self.resiveButton.layer.cornerRadius = 5;
#pragma mark- resiveButton.tag-5555
    self.resiveButton.tag = 5555;
    [self.resiveButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_resiveButton];
    
}



#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 1110) {
        NSLog(@"1110");
        [self iocnOfUserChange];
        
    }else if (button.tag == 1111){
        NSLog(@"1111");
        
    }else if (button.tag == 1112){
        NSLog(@"1112昵称");
        
//         UILabel * label = (UILabel *)[self.view viewWithTag:2222];
        
        EditViewController * editVc = [[EditViewController alloc]init];
        editVc.buttonTag = button.tag - 1110;//2
        
        [self.navigationController pushViewController:editVc animated:YES];
        
    
//        __block UILabel * newlabel = label;
        
        editVc.sendMessageBlock=^(NSString * message){
        
            UILabel * label = (UILabel *)[self.view viewWithTag:2222];

            NSLog(@"[传过来的 = %@]",message);
//            newlabel.text = message;
//            NSLog(@"[重新赋值的 = %@]--------------",newlabel);
            label.text = message;
            NSLog(@"label = %@",label);
        };
        
        
        
    }else if (button.tag == 3000){
        NSLog(@"3000");
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 1113){
        NSLog(@"1113-性别");
        selectPickView * selpickView = [[selectPickView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:selpickView];
        
        
        [selpickView DidLoadWithTag:button.tag - 1110];
        
        selpickView.messageBlock=^(NSString * message){
        
            
            UILabel * label = (UILabel *)[self.view viewWithTag:2223];
            label.text = message;

            
        };
        
    }else if (button.tag == 1114){
        NSLog(@"1114");
        selectPickView * selpickView = [[selectPickView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:selpickView];
        [selpickView DidLoadWithTag:button.tag - 1110];
        
        selpickView.messageBlock=^(NSString * message){
            
            
            UILabel * label = (UILabel *)[self.view viewWithTag:2224];
            label.text = message;
            
            
        };

        
    }else if (button.tag == 1115){
        NSLog(@"1115-城市");

        selectPickView * selpickView = [[selectPickView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:selpickView];
        
        
        [selpickView DidLoadWithTag:button.tag - 1110];
        
        selpickView.messageBlock=^(NSString * message){
            
            
            UILabel * label = (UILabel *)[self.view viewWithTag:2225];
            label.text = message;
    
        };

        
    }else if (button.tag == 1116){
        NSLog(@"1116-详细地址");
        EditViewController * editVc = [[EditViewController alloc]init];
        editVc.buttonTag = button.tag - 1110;//6
        
        [self.navigationController pushViewController:editVc animated:YES];

        editVc.sendMessageBlock=^(NSString * message){
            
            UILabel * label = (UILabel *)[self.view viewWithTag:2226];
            
            label.text = message;
            NSLog(@"label = %@",label);
        };

        
    }else if (button.tag == 1117){
        NSLog(@"1117-行业");
        selectPickView * selpickView = [[selectPickView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:selpickView];
        [selpickView DidLoadWithTag:button.tag - 1110];
        
        selpickView.messageBlock=^(NSString * message){
            
            
            UILabel * label = (UILabel *)[self.view viewWithTag:2227];
            label.text = message;
            
            
        };

        
        
    }else if (button.tag == 1118){
        NSLog(@"1118-收入");
        
        selectPickView * selpickView = [[selectPickView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:selpickView];
        [selpickView DidLoadWithTag:button.tag - 1110];
        
        selpickView.messageBlock=^(NSString * message){
            
            
            UILabel * label = (UILabel *)[self.view viewWithTag:2228];
            label.text = message;
            
            
        };

        
        
    }else if (button.tag == 5555) {
#pragma mark- 修改按钮
        NSLog(@"5555-修改");
        
        if (self.net == nil) {
        self.net = [[NetWork alloc]init];
        }
        
        [_net newUserInfoChangeWithDic:[self newUserInfo]];
        
        
        __weak EditProfileViewController * weakSelf = self;
        
        self.net.userInfoCMB=^(NSString * code){
        
            BOOL isSuccessed = NO;
            
            if ([code isEqualToString:@"1"]) {
                
                isSuccessed = YES;
            }
            
            
            [weakSelf userInfoChangeAlerate:isSuccessed];
            
            
            if (isSuccessed) {
                
                [weakSelf performSelector:@selector(successedBack) withObject:nil afterDelay:2];
            }
            
            
        };
        
        
    }
    
}


#pragma mark- 修改资料成功提示
- (void)userInfoChangeAlerate:(BOOL)isSucceed{
    
    UILabel * laber = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    laber.center = CGPointMake(SCREEN_W/2, SCREEN_H + 15);
    laber.backgroundColor = [UIColor blackColor];
    laber.textColor = [UIColor whiteColor];
    laber.font = [UIFont boldSystemFontOfSize:13];
    laber.textAlignment = NSTextAlignmentCenter;
    laber.layer.cornerRadius = 6;
    laber.clipsToBounds = YES;
    [self.view addSubview:laber];
    
    if (isSucceed) {
        laber.text = @"资料修改成功";
    }else{
        
        laber.text = @"资料修改失败";
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        laber.center = CGPointMake(SCREEN_W/2, SCREEN_H - 49);
        
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(removeuserInfoLabel:) withObject:laber afterDelay:1];
    }];
    
    
}


- (void)successedBack{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)removeuserInfoLabel:(UILabel *)label{
    
    [label removeFromSuperview];

}



#pragma mark- 资料修改
- (NSDictionary *)newUserInfo{
    
    UILabel * label2 = (UILabel *)[_scrollView viewWithTag:2222];
    UILabel * label3 = (UILabel *)[_scrollView viewWithTag:2223];
    UILabel * label4 = (UILabel *)[_scrollView viewWithTag:2224];
    UILabel * label5 = (UILabel *)[_scrollView viewWithTag:2225];
    UILabel * label6 = (UILabel *)[_scrollView viewWithTag:2226];
    UILabel * label7 = (UILabel *)[_scrollView viewWithTag:2227];
    UILabel * label8 = (UILabel *)[_scrollView viewWithTag:2228];

    NSLog(@"%@",label2.text);
    NSLog(@"%@",label3.text);
    NSLog(@"%@",label4.text);
    NSLog(@"%@",label5.text);
    NSLog(@"%@",label6.text);
    NSLog(@"%@",label7.text);
    NSLog(@"%@",label8.text);

    
    NSArray * strArray = [label5.text componentsSeparatedByString:@" "];
    NSMutableDictionary * muDic = [NSMutableDictionary dictionaryWithDictionary:_userInfoDic];
    
    muDic[@"nickname"] = label2.text;
    muDic[@"sex"] = label3.text;
    muDic[@"age"] = label4.text;
    
    if (strArray) {
        muDic[@"city"] = strArray[1];
        muDic[@"province"] = strArray[0];
    }
    
    muDic[@"address"] = label6.text;
    muDic[@"industry"] = label7.text;
    muDic[@"monthly_income"] = label8.text;

    
    NSDictionary * newDic = [NSDictionary dictionaryWithDictionary:muDic];
    
    [_userDefaults setObject:newDic forKey:@"usermessage"];
    
    NSLog(@"%@",newDic);

    return newDic;
}


#pragma mark- 头像修改
- (void)iocnOfUserChange{

    self.pickerControll = [[UIImagePickerController alloc]init];
    self.pickerControll.delegate = self;
    self.pickerControll.allowsEditing = YES;
    
    self.alertControll = [UIAlertController alertControllerWithTitle:@"图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    
    [self.alertControll addAction:[UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.pickerControll.sourceType = UIImagePickerControllerSourceTypeCamera;

        [self presentViewController:_pickerControll animated:YES completion:nil];
        
    }]];
    }
    
    [self.alertControll addAction:[UIAlertAction actionWithTitle:@"本地图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pickerControll.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:_pickerControll animated:YES completion:nil];
    }]];
    
    [self.alertControll addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:_alertControll animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSLog(@"selsec");
    
    UIImage * seletImg = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData * imgData = UIImageJPEGRepresentation(seletImg, 1);
    
    
   //上传图片===
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    UIImage * image2 = [self compressOriginalImage:seletImg toSize:CGSizeMake(640, 640)];
    
    NSData * iconData2 = UIImageJPEGRepresentation(image2,0.5);
    
    [self.net userIconUpLoadToPhp:iconData2];
    
    __weak EditProfileViewController * weakSelf = self;
    
    self.imageIcon = image2;
    
    self.net.iconUpLoadB=^(NSString * message,BOOL isSucceeds){
    
        NSLog(@"%@",message);
        
        if (isSucceeds) {
            
            [weakSelf.net firstVcMessageGetOfNet];
            
            weakSelf.net.userInfoMessageB=^(NSString * message,BOOL bb){
            
                [[NSNotificationCenter defaultCenter]postNotificationName:@"iconChange" object:weakSelf.imageIcon];
                
            };
        }
        
        
        if (isSucceeds) {
            
            [weakSelf iconUpLoadAlerate:isSucceeds];
        }
    
    };
    
    
    
    
    //======
    
//    [self saveIconInBandul:imgData];

    [self.pickerControll dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark- 头像上传成功提示
- (void)iconUpLoadAlerate:(BOOL)isSucceed{
    
    UILabel * laber = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    laber.center = CGPointMake(SCREEN_W/2, -15);
    laber.backgroundColor = [UIColor blackColor];
    laber.textColor = [UIColor whiteColor];
    laber.font = [UIFont boldSystemFontOfSize:14];
    laber.textAlignment = NSTextAlignmentCenter;
    laber.layer.cornerRadius = 6;
    laber.clipsToBounds = YES;
    [self.view addSubview:laber];
    
    if (isSucceed) {
        laber.text = @"头像上传成功";
    }else{
        
        laber.text = @"头像上传失败";
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        laber.center = CGPointMake(SCREEN_W/2, 42);
        
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(removeLabel:) withObject:laber afterDelay:1];
    }];
    
    
}


- (void)removeLabel:(UILabel *)label{
    
    [label removeFromSuperview];
}




-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage * resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return image;
}


//#pragma mark- 保存头像到本地
//- (void)saveIconInBandul:(NSData *)imgData{
//    
//    NSDictionary * dic = [_userDefaults objectForKey:@"usermessage"];
//    
//    
//    if (dic[@"iconPath"] == nil) {
//        
//        NSMutableDictionary * muDict;
//        
//        NSString * iconPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"customer_icon"];
//        
//        muDict = [NSMutableDictionary dictionaryWithDictionary:dic];
//        
//        muDict[@"iconPath"] = iconPath;
//        
//        NSDictionary * newDic = [NSDictionary dictionaryWithDictionary:muDict];
//        
//        [_userDefaults setObject:newDic forKey:@"usermessage"];
//        
//    };
//    
//    NSDictionary * newdict = [_userDefaults objectForKey:@"usermessage"];
//    
//    
//    NSLog(@"11==[%@]==",newdict[@"iconPath"]);
//    
//    BOOL write =  [imgData writeToFile:newdict[@"iconPath"] atomically:YES];
//
//    
//    if (write == YES) {
//        NSLog(@"=====0写入成功0====");
//    }else{
//        
//        NSLog(@"=====0写入失败0====");
//    }
//
//}
//
//#pragma mark- 从本地读取头像
//- (UIImage *)getIconImg{
//    
//    NSDictionary * dic = [_userDefaults objectForKey:@"usermessage"];
//
//    NSString * iconPath = dic[@"iconPath"];
//
//    NSLog(@"22==[%@]==",iconPath);
//    
//    UIImage * iconImg = [UIImage imageWithData:[NSData dataWithContentsOfFile:iconPath]];
//    
//    
//    if(iconImg == nil){
//        
//        NSLog(@"图片文件读取失败");
//        
//        NSMutableDictionary * mudic = [NSMutableDictionary dictionaryWithDictionary:dic];
//        mudic[@"iconPath"]=nil;
//        
//        NSDictionary * newdict = [NSDictionary dictionaryWithDictionary:mudic];
//        
//        [_userDefaults setObject:newdict forKey:@"usermessage"];
//        
//        iconImg = [UIImage imageNamed:@"2.jpg"];
//        
//    }else{
//        
//        NSLog(@"文件读取成功");
//    }
//
//    
//    return iconImg;
//}

@end
