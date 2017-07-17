//
//  articleOneTypeModel.m
//  发发啦
//
//  Created by gxtc on 16/10/21.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "articleOneTypeModel.h"

@implementation articleOneTypeModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
      
        self.id_ = dict[@"id"];

        if (self.id_.length > 2) {
            self.title = dict[@"title"];
            self.video = dict[@"video"];
            self.thumb = dict[@"thumb"];
            self.addtime = dict[@"addtime"];
            self.c_id = dict[@"c_id"];
            self.height_money = [NSString stringWithFormat:@"%@",dict[@"height_money"]];
            self.view_count = [NSString stringWithFormat:@"%@",dict[@"view_count"]];
            self.share_count = [NSString stringWithFormat:@"%@",dict[@"share_count"]];
            self.share = dict[@"share"];
            self.abstract = dict[@"abstract"];
            self.detail = dict[@"detail"];
            self.ucshare = dict[@"ucshare"];
            self.qqshare = dict[@"qqshare"];
            self.read_price = [NSString stringWithFormat:@"%@",dict[@"read_price"]];
            
        self.video = [NSString stringWithFormat:@"%@",dict[@"video"]];
        
        self.duotu = [NSString stringWithFormat:@"%@",dict[@"duotu"]];
        
            if ([self.duotu isEqualToString:@"1"]) {
        
                NSArray * imgs = dict[@"img"];
            
                self.imgUrl1 = imgs[0];
                self.imgUrl2 = imgs[1];
                self.imgUrl3 = imgs[2];
            
            }else{
        
                self.imgUrl1 = @"0";
                self.imgUrl2 = @"0";
                self.imgUrl3 = @"0";

            }
        }else{
        
            self.id_2 = dict[@"id"];
            self.adtitle = dict[@"adtitle"];
            self.adthumb = dict[@"adthumb"];
            self.cname = dict[@"cname"];
            self.cdtitle = dict[@"cdtitle"];
            self.ctime = dict[@"ctime"];
            self.adurl = dict[@"adurl"];
        }
        
    }
    
    return self;
}


+ (instancetype)allocWitehDictionary:(NSDictionary *)dict{
    
    
    return [[articleOneTypeModel alloc]initWithDictionary:dict];
    
    
}
@end
