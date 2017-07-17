//
//  CoreDataManger.h
//  coreData
//
//  Created by gxtc on 16/9/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface CoreDataManger : NSObject

@property (nonatomic,assign)AppDelegate * appDelgate;

@property (nonatomic,strong)NSManagedObjectContext * manageObjectContext;
@property (nonatomic,strong)NSFetchRequest * fetchRequest;


/** 单例创建CoreDataManger*/
+ (instancetype)shareCoreDataManger;




//======================插入
#pragma mark-插入文章频道
/** 插入文章频道*/
- (BOOL )insertIntoDataWithArticalClassTheSelect:(NSArray *)select andTheUnselect:(NSArray *)unSelect;

#pragma mark- 插入所有系统消息
/**插入所有系统消息*/
- (BOOL )insertIntoDataWithsystemMessage:(NSArray *)messageArray;



//======================删除




//======================修改



//======================查找

#pragma mark- 查找所有频道
- (NSArray *)checkArticleList;


#pragma mark- 查找选中频道
- (NSArray *)checkSelectArticleCharnel;

#pragma mark- 查找[没选中]频道
- (NSArray *)checkUnSelectArticleCharnel;


#pragma mark- 查找所有系统消息
- (NSArray *)checkAllSystemMessage;



//======================删除所有

#pragma mark- 删除所有数据
/**删除所有文章频道数据*/
- (void)deleteAllArticleClassData;

#pragma mark-删除所有系统消息
/**删除所有系统消息*/
- (void)deleteAllSystemMessageData;
@end
