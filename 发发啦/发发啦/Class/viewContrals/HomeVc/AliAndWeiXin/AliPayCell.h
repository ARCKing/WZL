//
//  AliPayCell.h
//  NewApp
//
//  Created by gxtc on 17/2/23.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AliPayCell : UITableViewCell

- (UILabel * )addCellRootLabelNewWithFram:(CGRect)fram andBackGroundColor:(UIColor *)color1 andTextColor:(UIColor *)color2
                                  andFont:(NSUInteger)font andTitle:(NSString *)title
                       andNSTextAlignment:(NSTextAlignment)textAlignment;
@end
