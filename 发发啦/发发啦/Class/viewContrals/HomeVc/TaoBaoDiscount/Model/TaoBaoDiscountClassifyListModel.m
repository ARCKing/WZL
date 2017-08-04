//
//  TaoBaoDiscountClassifyListModel.m
//  发发啦
//
//  Created by gxtc on 2017/8/4.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "TaoBaoDiscountClassifyListModel.h"

@implementation TaoBaoDiscountClassifyListModel



+ (JSONKeyMapper *)keyMapper{
    
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"_id":@"id"}];
    
}

@end
