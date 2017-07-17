//
//  selectPickView.m
//  发发啦
//
//  Created by gxtc on 16/8/31.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "selectPickView.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface selectPickView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,retain)UIPickerView * pickView;

@property(nonatomic,strong)NSArray * sexArray;
@property(nonatomic,strong)NSArray * jobArray;
@property(nonatomic,strong)NSArray * ageArray;
@property(nonatomic,strong)NSArray * incomeArray;

@property(nonatomic,strong)UIView * bgPickView;

@property(nonatomic,assign)NSInteger indexTag;

@property(nonatomic,copy)NSString * messageString;

@property(nonatomic,strong)NSMutableArray * cityArrays;
@property(nonatomic,strong)NSMutableArray * provineceArray;

@end

@implementation selectPickView

- (void)DidLoadWithTag:(NSInteger)tag {
    
    self.backgroundColor = [UIColor colorWithRed:36/255.0 green:38/255.0 blue:47/255.0 alpha:0.6];
    
    NSLog(@"%@",_aliAndWeiXinPayCashArray);
    
    self.indexTag = tag;
    
    
    self.sexArray = @[@"未知",@"男",@"女"];//tag-3
    self.jobArray = @[@"IT|互联网|电子|通信",@"金融业",@"房地产|建筑业",@"贸易|批发零售",@"文体教育|工艺美术",@"生产|加工|制造",@"交通|运输|物流|仓储",@"文化|传媒|娱乐|体育",@"能源|矿产|环保",@"政府|非盈利机构",@"学生",@"其他"];//tag-7
    self.ageArray = @[@"18岁以下",@"18-22岁",@"23-26岁",@"27-30岁",@"31-35岁",@"36-40岁",@"40岁以上"];//tag-4
    self.incomeArray = @[@"2999以下",@"3001-4999",@"5001-6999",@"7001-8999",@"10000以上"];//tag-8
    
    [self cityDataLoad];
    [self bgPickViewCreat];
    [self addButton];
    [self pickViewCreat];
    
    [self showPickView];
}


- (void)showPickView{

    [UIView animateWithDuration:0.3 animations:^{
        
        self.bgPickView.frame = CGRectMake(0, 2 * SCREEN_H/3 - 35, SCREEN_W , SCREEN_H/3 + 35);

    }];
    
}

- (void)cityDataLoad{

    self.provineceArray = [NSMutableArray new];
    self.cityArrays = [NSMutableArray new];
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"Provineces.plist" ofType:nil];
    
    self.provineceArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
    self.cityArrays = [NSMutableArray arrayWithArray:self.provineceArray[0][@"cities"]];
   
}


- (void)bgPickViewCreat{

    self.bgPickView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H + SCREEN_H/3 + 35, SCREEN_W , SCREEN_H/3 + 35)];
    self.bgPickView.backgroundColor =[ UIColor whiteColor];
    [self addSubview:_bgPickView];
}


- (void)addButton{

    UIButton * enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [enterButton setTitle:@"确认" forState:UIControlStateNormal];
    [enterButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    enterButton.frame = CGRectMake(20, 0, 50, 35);
    [enterButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.bgPickView addSubview:enterButton];
#pragma mark- enterButton.tag-4000
    enterButton.tag = 4000;
    
    
    
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(SCREEN_W - 20 - 50, 0, 50, 35);
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.bgPickView addSubview:cancelButton];
#pragma mark- cancelButton.tag-4040
    cancelButton.tag = 4040;
}





- (void)pickViewCreat{
    
    if (!self.pickView) {
        self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 35 , SCREEN_W, SCREEN_H/3)];

    }
    
    [self.bgPickView addSubview:_pickView];
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    self.pickView.backgroundColor = [UIColor whiteColor];
    
}


- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 4000) {
        
        NSLog(@"4000-确认");
        if (_indexTag == 3) {
           
            
            if (_messageString == nil) {
                _messageString = _sexArray[0];
            }
            self.messageBlock(_messageString);
            
        }else if (_indexTag == 4) {
        
            if (_messageString == nil) {
                _messageString = _ageArray[0];
            }
            
            self.messageBlock(_messageString);
        
        }else if (_indexTag == 5) {
            
            if (_messageString == nil) {
                _messageString = @"北京市 北京市";
            }
            self.messageBlock(_messageString);

        }else if (_indexTag == 7) {
            
            if (_messageString == nil) {
                _messageString = _jobArray[0];
            }
            self.messageBlock(_messageString);
            
        }else if (_indexTag == 8) {
            
            if (_messageString == nil) {
                _messageString = _incomeArray[0];
            }
            self.messageBlock(_messageString);
            
        }else {
            if (_messageString == nil) {
                _messageString = [NSString stringWithFormat:@"%@",_aliAndWeiXinPayCashArray[0]];
            }
            self.messageBlock(_messageString);
        }
        
    }else if (button.tag == 4040) {
        NSLog(@"4040-取消");
    
    }
    
    [self removeFromSuperview];
    
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (_indexTag == 3){
        
        NSLog(@"%@",_sexArray[row]);
        self.messageString = _sexArray[row];
        
    }else if (_indexTag == 4){
    
        NSLog(@"%@",_ageArray[row]);
        self.messageString = _ageArray[row];

    }else if (_indexTag == 5){
        
        if (component == 0) {
        
            self.cityArrays = self.provineceArray[row][@"cities"];
            [self.pickView reloadComponent:1];
            
            NSInteger citySelect = [self.pickView  selectedRowInComponent:1];

            NSString * provinece = self.provineceArray[row][@"ProvinceName"];
            NSString * city = self.cityArrays[citySelect][@"CityName"];
            
            self.messageString = [NSString stringWithFormat:@"%@ %@",provinece,city];
            
        }else{
        
            NSInteger ProvineceSelect = [self.pickView  selectedRowInComponent:0];
            
            NSString * provinece = self.provineceArray[ProvineceSelect][@"ProvinceName"];
            
            NSString * city = self.cityArrays[row][@"CityName"];
        
            self.messageString = [NSString stringWithFormat:@"%@ %@",provinece,city];

        }
        
       
        
    }else if (_indexTag == 7) {
        
        NSLog(@"%@",_jobArray[row]);
        self.messageString = _jobArray[row];

    }else if (_indexTag == 8) {
        
        NSLog(@"%@",_incomeArray[row]);
        self.messageString = _incomeArray[row];

    }else{
    
        NSLog(@"%@",[NSString stringWithFormat:@"%@",_aliAndWeiXinPayCashArray[row]]);
        self.messageString = [NSString stringWithFormat:@"%@",_aliAndWeiXinPayCashArray[row]];

    }
    
    
}


//显示内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString * info = nil;
    if (_indexTag == 3) {
        
        info = _sexArray[row];
        
    }else if (_indexTag == 4) {
    
        info = _ageArray[row];
        
    }else if (_indexTag == 5) {
        
        if (component == 0) {
            
        info = _provineceArray[row][@"ProvinceName"];
           
        }else{
            
        info = _cityArrays[row][@"CityName"];
            
        }
        
    }else if (_indexTag == 7) {
    
        info = _jobArray[row];
        
    }else if (_indexTag == 8) {
        
        info = _incomeArray[row];
    
    }else {
        
        info = [NSString stringWithFormat:@"%@",_aliAndWeiXinPayCashArray[row]];
    
    }
    
    return info;
    
}

//每组的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger count = 0;
    
    if (_indexTag == 3) {
        count = _sexArray.count;
    }else if(_indexTag == 4) {
    
        count = _ageArray.count;
    }else if (_indexTag == 5) {
        
        if (component == 0) {
            
            return self.provineceArray.count;
        }else{
            return self.cityArrays.count;
        }
        
        
    }else if (_indexTag == 7) {
    
        count = _jobArray.count;
    }else if (_indexTag == 8) {
    
        count = _incomeArray.count;
    }else {
    
        count = _aliAndWeiXinPayCashArray.count;
    
    }
    
    return count;
    
}

//组数，列表数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    
    if (self.indexTag == 5) {
        
        return 2;
        
    }else{
    
        return 1;
    }
    
}



@end
