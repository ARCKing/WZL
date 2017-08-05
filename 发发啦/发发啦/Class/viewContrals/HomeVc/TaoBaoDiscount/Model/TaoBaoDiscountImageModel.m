//
//  TaoBaoDiscountImageModel.m
//  发发啦
//
//  Created by gxtc on 2017/8/5.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "TaoBaoDiscountImageModel.h"

@implementation TaoBaoDiscountImageModel
+ (JSONKeyMapper *)keyMapper{
    
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:
            @{@"zero":@"0",
              @"one":@"1",
              @"two":@"2",
              @"three":@"3",
              @"four":@"4",
              @"five":@"5",
              @"sex":@"6"
              }];
    
}
@end
