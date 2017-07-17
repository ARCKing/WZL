//
//  SystemMessage+CoreDataProperties.m
//  发发啦
//
//  Created by gxtc on 16/12/9.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "SystemMessage+CoreDataProperties.h"

@implementation SystemMessage (CoreDataProperties)

+ (NSFetchRequest<SystemMessage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SystemMessage"];
}

@dynamic c_id;
@dynamic titlt;
@dynamic ptime;
@dynamic read;

@end
