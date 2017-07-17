//
//  AliPayCell.m
//  NewApp
//
//  Created by gxtc on 17/2/23.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "AliPayCell.h"

@implementation AliPayCell

- (UILabel * )addCellRootLabelNewWithFram:(CGRect)fram andBackGroundColor:(UIColor *)color1 andTextColor:(UIColor *)color2
                                  andFont:(NSUInteger)font andTitle:(NSString *)title
                       andNSTextAlignment:(NSTextAlignment)textAlignment{
    
    UILabel * label = [[UILabel alloc]initWithFrame:fram];
    label.textAlignment = textAlignment;
    label.textColor = color2;
    label.backgroundColor = color1;
    label.font = [UIFont systemFontOfSize:font];
    label.text = title;
    label.numberOfLines = 0;
    return label;
    
}

@end
