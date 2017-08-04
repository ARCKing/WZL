//
//  TaoBaoDiscountClassifyListModel.h
//  发发啦
//
//  Created by gxtc on 2017/8/4.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "JSONModel.h"

@interface TaoBaoDiscountClassifyListModel : JSONModel

@property(nonatomic,strong)NSString<Optional>* _id;
@property(nonatomic,strong)NSString<Optional>* itemid;
@property(nonatomic,strong)NSString<Optional>* itemtitle;
@property(nonatomic,strong)NSString<Optional>* itemshorttitle;
@property(nonatomic,strong)NSString<Optional>* itemdesc;
@property(nonatomic,strong)NSString<Optional>* itemprice;
@property(nonatomic,strong)NSString<Optional>* itemendprice;
@property(nonatomic,strong)NSString<Optional>* couponurl;
@property(nonatomic,strong)NSString<Optional>* itempic;
@property(nonatomic,strong)NSString<Optional>* couponmoney;
@property(nonatomic,strong)NSString<Optional>* itemsale;

@property(nonatomic,strong)NSString<Optional>* guide_article;
@property(nonatomic,strong)NSString<Optional>* fqcat;
@property(nonatomic,strong)NSString<Optional>* taokouling;
@end
