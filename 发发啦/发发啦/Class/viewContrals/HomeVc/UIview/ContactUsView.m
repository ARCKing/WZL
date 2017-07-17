//
//  ContactUsView.m
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "ContactUsView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import "NetWork.h"
#import "contactUsModel.h"
#import "QQgrooupModel.h"
#import "UIImageView+WebCache.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface ContactUsView ()
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UIView * QRcodeView;
@property(nonatomic,strong)UIView * weiXinView;
@property(nonatomic,strong)UIButton * weiXinTitle;
@property(nonatomic,strong)UIButton * QQtitle;

@property(nonatomic,strong)UIView * navView;

@property(nonatomic,strong)contactUsModel * contactModel;
@property(nonatomic,strong)NSArray * qq_group;

@property(nonatomic,strong)UITextView * codeTextView;
@property(nonatomic,strong)UIImageView * QrImagView;
@end

@implementation ContactUsView


- (void)initCreat:(MBProgressHUD *)hud{
    self.backgroundColor = [UIColor whiteColor];
    [self navViewCreat];
    [self weiXinbuttonTitleCreat];
    [self twoViewCreat];
    [self QQButtonTitleCreat];
    
    [self contactUsModelGetFromNet:hud];
}


#pragma mark- 数据请求
- (void)contactUsModelGetFromNet:(MBProgressHUD *)hud{

    NetWork * net = [[NetWork alloc]init];

    [net contactUSFromNet];
    
    __weak ContactUsView * weakSelf = self;
    
    net.contactUsModelBackBlock=^(contactUsModel * model){
    
        [hud hideAnimated:YES];
        
        weakSelf.contactModel = model;
        NSString * qrUrl = model.qr;
        
        weakSelf.qq_group = [NSArray arrayWithArray:model.qq_group];
        weakSelf.codeTextView.text = model.wx_name;
        [weakSelf QQgorupCreat];

        [weakSelf.QrImagView sd_setImageWithURL:[NSURL URLWithString:qrUrl]];
    };

}


#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"联系我们";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    
#pragma mark- bgScrollViewCreat
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H-64)];
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_H - 63);
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    self.scrollView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:240/255.0];
    self.scrollView.userInteractionEnabled = YES;
    
    
}


#pragma buttonAction
- (void)buttonAction:(UIButton *)bt{
    
    int count = (int)self.qq_group.count;
    
    
    if (bt.tag == 3000) {
        self.backBlock();
    }else if (bt.tag == 7770 + count) {
        
        NSLog(@"客服");


    }else {
        
        NSLog(@"QQ群");
        
        int index = (int)bt.tag - 7770;
        
        QQgrooupModel * model = self.qq_group[index];
        
        
        [self QuickJoinQQgroupWithQQ:model.qq andKey:model.ios_key];

        
    }


}


/**QQ一键加群*/
- (void)QuickJoinQQgroupWithQQ:(NSString *)qq andKey:(NSString *)key{
    
    
    BOOL join = [self joinGroup:qq key:key];
    
    NSLog(@"%d",join);
    
}


- (BOOL)joinGroup:(NSString *)groupUin key:(NSString *)key{
    
    NSString *urlStr = [NSString stringWithFormat:@"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=%@&key=%@&card_type=group&source=external", groupUin,key];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    else return NO;
}


#pragma mark- weiXinbuttonTitleCreat

- (void)weiXinbuttonTitleCreat{
    self.weiXinTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weiXinTitle setImage:[UIImage imageNamed:@"pic_share_weixin.png"] forState:UIControlStateNormal];
    [self.weiXinTitle setTitle:@"添加微信客服账号" forState:UIControlStateNormal];
    self.weiXinTitle.titleLabel.font = [UIFont systemFontOfSize:15];
    self.weiXinTitle.frame = CGRectMake(-1, 0, SCREEN_W + 2, SCREEN_W/10);
    [self.scrollView addSubview:_weiXinTitle];
    self.weiXinTitle.layer.borderWidth = 0.5;
    self.weiXinTitle.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.weiXinTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.weiXinTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.weiXinTitle.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.weiXinTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    self.weiXinTitle.backgroundColor = [UIColor whiteColor];

}


#pragma mark- twoViewCreat
- (void)twoViewCreat{
//QRcodeView
    self.QRcodeView = [[UIView alloc]initWithFrame:CGRectMake(-1, CGRectGetMaxY(_weiXinTitle.frame), SCREEN_W/2, SCREEN_W/2)];
    self.QRcodeView.backgroundColor = [UIColor whiteColor];
    self.QRcodeView.layer.borderWidth = 0.5;
    self.QRcodeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.scrollView addSubview:_QRcodeView];
    
    UIImageView * QRimageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W/12, SCREEN_W/15, SCREEN_W/3, SCREEN_W/3)];
    QRimageView.image = [UIImage imageNamed:@"load.png"];
    [self.QRcodeView addSubview:QRimageView];
    
    self.QrImagView = QRimageView;
    
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/3, 20)];
    titleLabel.center = CGPointMake(_QRcodeView.bounds.size.width/2, _QRcodeView.bounds.size.height - SCREEN_W/19);
    [self.QRcodeView addSubview:titleLabel];
    titleLabel.text = @"扫一扫，加我微信号";
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;

//    weiXinView
    self.weiXinView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_QRcodeView.frame)+1, CGRectGetMaxY(_weiXinTitle.frame), SCREEN_W/2, SCREEN_W/2)];
    self.weiXinView.backgroundColor = [UIColor whiteColor];
    self.weiXinView.layer.borderWidth = 0.5;
    self.weiXinView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.scrollView addSubview:_weiXinView];
    
    UILabel * titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, 20)];
    titleLabel2.center = CGPointMake(_weiXinView.bounds.size.width/2, _weiXinView.bounds.size.height/5);
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    titleLabel2.text = @"直接添加微信客服账号";
    titleLabel2.font = [UIFont systemFontOfSize:15];
    [self.weiXinView addSubview:titleLabel2];
    
    UITextView * codeTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/3, 30)];
    codeTextView.text = @"weizhuanla";
    self.codeTextView = codeTextView;
    codeTextView.layer.borderWidth = 1;
    codeTextView.layer.borderColor = [UIColor orangeColor].CGColor;
    codeTextView.textColor = [UIColor orangeColor];
    codeTextView.textAlignment = NSTextAlignmentCenter;
    codeTextView.editable = NO;
    codeTextView.center = CGPointMake(_weiXinView.bounds.size.width/2, _weiXinView.bounds.size.width/2);
    [self.weiXinView addSubview:codeTextView];
    
    UILabel * titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/3, 20)];
    titleLabel3.center = CGPointMake(_weiXinView.bounds.size.width/2, CGRectGetMaxY(codeTextView.frame) + 30);
    [self.weiXinView addSubview:titleLabel3];
    titleLabel3.text = @"长按框内内容可复制";
    titleLabel3.textColor = [UIColor lightGrayColor];
    titleLabel3.font = [UIFont systemFontOfSize:13];
    titleLabel3.textAlignment = NSTextAlignmentCenter;

}


#pragma mark- QQButtonTitleCreat

- (void)QQButtonTitleCreat{

    self.QQtitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.QQtitle setImage:[UIImage imageNamed:@"pic_share_tencent.png"] forState:UIControlStateNormal];
    [self.QQtitle setTitle:@"添加客服QQ群" forState:UIControlStateNormal];
    self.QQtitle.titleLabel.font = [UIFont systemFontOfSize:15];
    self.QQtitle.frame = CGRectMake(-1, CGRectGetMaxY(_weiXinView.frame) + 10, SCREEN_W + 2, SCREEN_W/10);
    [self.scrollView addSubview:_QQtitle];
    self.QQtitle.layer.borderWidth = 0.5;
    self.QQtitle.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.QQtitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.QQtitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.QQtitle.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.QQtitle.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    self.QQtitle.backgroundColor = [UIColor whiteColor];
}

#pragma mark- fiveIteamCreat
-(void)QQgorupCreat{

    for (int i = 0; i < self.qq_group.count + 1 ; i++) {
        
        NSLog(@"%d",i);

        int j = i;
        
        if (j == self.qq_group.count) {
            
            j--;
        }
        
        QQgrooupModel * model = self.qq_group[j];

        NSLog(@"%ld",self.qq_group.count);

        
        UILabel * labrl = [[UILabel alloc]init];
        labrl.backgroundColor = [UIColor whiteColor];
        labrl.font = [UIFont systemFontOfSize:14];
        labrl.userInteractionEnabled = YES;
        if (i < self.qq_group.count) {
            labrl.frame = CGRectMake(0,CGRectGetMaxY(_QQtitle.frame) + SCREEN_W/9 * i, SCREEN_W * 2 - SCREEN_W/3, SCREEN_W/9);
            UILabel * line = [[UILabel alloc]init];
            [labrl addSubview:line];
            line.backgroundColor = [UIColor lightGrayColor];
            if (i != 3) {
                line.frame = CGRectMake(10, SCREEN_W/9 - 1, SCREEN_W-10, 0.5);
            }else{
            
                line.frame = CGRectMake(0, SCREEN_W/9 - 1, SCREEN_W, 0.5);
            }
            
        }else{
        
            labrl.frame = CGRectMake(-1,CGRectGetMaxY(_QQtitle.frame) + SCREEN_W/9 * i + 10,  SCREEN_W * 2 - SCREEN_W/3, SCREEN_W/10);
            
            UILabel * line1 = [[UILabel alloc]init];
            [labrl addSubview:line1];
            line1.frame = CGRectMake(0, 0, SCREEN_W, 0.5);
            line1.backgroundColor = [UIColor lightGrayColor];

            UILabel * line2 = [[UILabel alloc]init];
            [labrl addSubview:line2];
            line2.frame = CGRectMake(0, SCREEN_W/10 , SCREEN_W, 0.5);
            line2.backgroundColor = [UIColor lightGrayColor];


        }
        
       
        if (i < self.qq_group.count) {
            labrl.text = [NSString stringWithFormat:@"%@",model.qq];

        }else{
            
            labrl.text = self.contactModel.service_tel;

        }
        
        labrl.textAlignment = NSTextAlignmentCenter;
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 1, SCREEN_W, SCREEN_W/10);
        [labrl addSubview:button];
#pragma mark- button.tag- 7770 + i;
        button.tag = 7770 + i;
        
        if (i < self.qq_group.count) {
            
            if ([[NSString stringWithFormat:@"%@",model.status] isEqualToString:@"1"]) {
                
                [button setTitle:[NSString stringWithFormat:@"QQ群%d(未满)",i+1] forState:UIControlStateNormal];

            }else{
            
                [button setTitle:[NSString stringWithFormat:@"QQ群%d(已满)",i+1] forState:UIControlStateNormal];
                
            }
        }else{
            
            [button setTitle:[NSString stringWithFormat:@"客服热线"] forState:UIControlStateNormal];

        }
        
        
        
        
        [button setImage:[UIImage imageNamed:@"icon20.png"] forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.scrollView addSubview:labrl];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }


}


- (void)QrCode{

    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = self.contactModel.qr;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5.显示二维码
    //    self.imageView.image = [UIImage imageWithCGImage:outputImage];
    
    self.QrImagView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];

    UIImageView * icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QRcode.png"]];
    icon.frame = CGRectMake(0, 0, 30, 30);
    icon.center = CGPointMake(SCREEN_W/6, SCREEN_W/6);
    [self.QrImagView addSubview:icon];
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    
    UIImage * img = [UIImage imageWithCGImage:scaledImage];
    
    CGImageRelease(scaledImage);
    CGColorSpaceRelease(cs);
    return img;
}


@end
