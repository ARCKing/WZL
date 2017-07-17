//
//  contactUsModel.m
//  发发啦
//
//  Created by gxtc on 16/11/2.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "contactUsModel.h"
#import "QQgrooupModel.h"

@implementation contactUsModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{

    if (self = [super init]) {
        
        self.qr = dict[@"qr"];
        self.wx_name = dict[@"wx_name"];
        self.service_tel = dict[@"service_tel"];
        NSArray * array = dict[@"qq_group"];
        
        NSMutableArray * muArray = [NSMutableArray new];
        
        for (NSDictionary * dic in array) {
            
            QQgrooupModel * model = [QQgrooupModel allocWitehDictionary:dic];
            
            [muArray addObject:model];
        }

        self.qq_group = [NSArray arrayWithArray:muArray];
        
    }
    
    return self;
}





+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{


    return [[contactUsModel alloc]initWithDictionary:dict];

}
@end
