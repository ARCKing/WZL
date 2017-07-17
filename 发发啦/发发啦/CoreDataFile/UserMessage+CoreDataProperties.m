//
//  UserMessage+CoreDataProperties.m
//  发发啦
//
//  Created by gxtc on 16/12/7.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "UserMessage+CoreDataProperties.h"

@implementation UserMessage (CoreDataProperties)

+ (NSFetchRequest<UserMessage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserMessage"];
}

@dynamic inconData;

@end
