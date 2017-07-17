//
//  ArticleMessage+CoreDataProperties.h
//  发发啦
//
//  Created by gxtc on 16/12/3.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "ArticleMessage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ArticleMessage (CoreDataProperties)

+ (NSFetchRequest<ArticleMessage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *c_id;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSNumber *is_select;

@end

NS_ASSUME_NONNULL_END
