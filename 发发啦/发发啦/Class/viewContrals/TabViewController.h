//
//  TabViewController.h
//  发发啦
//
//  Created by gxtc on 16/8/15.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabViewController : UITabBarController


- (NSArray *)getClassNameWithArray:(NSArray * )viewControllNameArray
                       andPicArray:(NSArray * )picArray
                 andClassTitleName:(NSArray * )titlyName
                      andselectPic:(NSArray * )selectPicArray;


@end
