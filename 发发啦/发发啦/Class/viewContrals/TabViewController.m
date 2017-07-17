//
//  TabViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/15.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@property(nonatomic,retain)NSMutableArray * vcArray;

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}





// 初始化标签栏  /
- (NSArray *)getClassNameWithArray:(NSArray * )viewControllNameArray
                       andPicArray:(NSArray * )picArray
                 andClassTitleName:(NSArray * )titlyName
                      andselectPic:(NSArray * )selectPicArray{
    
    self.vcArray = [NSMutableArray new];
    
    for (int i = 0; i < viewControllNameArray.count; i++) {
        
        Class class = NSClassFromString(viewControllNameArray[i]);
        UIViewController * vc = [[class alloc]init];
        vc.title = titlyName[i];
        
        
        vc.tabBarItem.image = [[UIImage imageNamed:picArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectPicArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //选中时标签栏字体颜色
        UIColor *titleHighlightedColor = [UIColor colorWithRed:255/255.0 green:157/255.0 blue:55/255.0 alpha:1];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        
        
        UINavigationController * unc = [[UINavigationController alloc]initWithRootViewController:vc];
        
        unc.navigationBarHidden = YES;
        //微标
//        vc.tabBarItem.badgeValue = @"11";
        
        [self.vcArray addObject:unc];
    }
    
    
    
    return self.vcArray;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
