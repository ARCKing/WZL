//
//  SystemMessage+CoreDataProperties.h
//  发发啦
//
//  Created by gxtc on 16/12/9.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "SystemMessage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SystemMessage (CoreDataProperties)

+ (NSFetchRequest<SystemMessage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *c_id;
@property (nullable, nonatomic, copy) NSString *titlt;
@property (nullable, nonatomic, copy) NSString *ptime;
@property (nullable, nonatomic, copy) NSString *read;

@end

NS_ASSUME_NONNULL_END
