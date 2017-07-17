//
//  ArticleMessage+CoreDataProperties.m
//  发发啦
//
//  Created by gxtc on 16/12/3.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "ArticleMessage+CoreDataProperties.h"

@implementation ArticleMessage (CoreDataProperties)

+ (NSFetchRequest<ArticleMessage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ArticleMessage"];
}

@dynamic c_id;
@dynamic title;
@dynamic is_select;

@end
