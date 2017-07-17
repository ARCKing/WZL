//
//  newTaskModel.m
//  发发啦
//
//  Created by gxtc on 16/11/9.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "newTaskModel.h"
#import "articleModel.h"
@implementation newTaskModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        self.member_id = [NSString stringWithFormat:@"%@", dict[@"member_id"]];
        self.done_profile = [NSString stringWithFormat:@"%@", dict[@"done_profile"]];
        self.share_article = [NSString stringWithFormat:@"%@", dict[@"share_article"]];
        self.invite_friend = [NSString stringWithFormat:@"%@", dict[@"invite_friend"]];
        self.sign_money = [NSString stringWithFormat:@"%@", dict[@"sign_money"]];
        self.share_article = [NSString stringWithFormat:@"%@", dict[@"share_article"]];
        
        NSArray * array = [NSArray arrayWithArray:dict[@"article"]];
        NSMutableArray * muArray = [NSMutableArray new];
        for (NSDictionary * dic in array) {
            articleModel * model = [[articleModel alloc]initWithDictionary:dic];
            [muArray addObject:model];
        }
     
        self.articleArray = [NSArray arrayWithArray:muArray];
    }
    
    return self;
    
}

+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[newTaskModel alloc]initWithDictionary:dict];
    
    
}
@end
