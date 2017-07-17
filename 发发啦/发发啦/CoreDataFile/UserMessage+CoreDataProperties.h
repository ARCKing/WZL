//
//  UserMessage+CoreDataProperties.h
//  发发啦
//
//  Created by gxtc on 16/12/7.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "UserMessage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserMessage (CoreDataProperties)

+ (NSFetchRequest<UserMessage *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *inconData;

@end

NS_ASSUME_NONNULL_END
