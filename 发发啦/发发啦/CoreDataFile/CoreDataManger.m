//
//  CoreDataManger.m
//  coreData
//
//  Created by gxtc on 16/9/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "CoreDataManger.h"
#import "UserMessage+CoreDataClass.h"
#import "ArticleMessage+CoreDataClass.h"
#import "articleClassModel.h"
#import "systemMessageModel.h"
#import "SystemMessage+CoreDataClass.h"

@interface CoreDataManger ()

@end

static CoreDataManger * CDManger;

@implementation CoreDataManger

+ (instancetype)shareCoreDataManger{

    if (CDManger == nil) {
        
        CDManger = [[CoreDataManger alloc]init];
        
        CDManger.appDelgate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        CDManger.manageObjectContext = CDManger.appDelgate.managedObjectContext;
        
        //数据库路径
        NSString * PATH = [NSHomeDirectory() stringByAppendingString:@"/Documents"];
        NSLog(@"PATH = %@",PATH);
        
    }
    return CDManger;
}

///Users/gxtc/Library/Developer/CoreSimulator/Devices/0ED11819-056B-4BF9-9960-95930B331980/data/Containers/Data/Application/DA69AAC9-0891-43A9-98F6-BA8371466EE6/Documents

+ (instancetype)alloc{

    if (CDManger == nil) {
        
        CDManger = [super alloc];
    }
    return CDManger;

}


+ (instancetype)allocWithZone:(struct _NSZone *)zone{

    if (CDManger == nil) {
        
        CDManger = [super allocWithZone:zone];
    }
    return CDManger;
}

//===================================================================================================




#pragma mark-插入文章频道
/** 插入文章频道*/
- (BOOL )insertIntoDataWithArticalClassTheSelect:(NSArray *)select andTheUnselect:(NSArray *)unSelect{
    
    NSError * error1 = nil;
    NSError * error2 = nil;
    BOOL isSucceed = NO;

    for (articleClassModel * model in select) {
        
        ArticleMessage * AM = [NSEntityDescription insertNewObjectForEntityForName:@"ArticleMessage" inManagedObjectContext:self.manageObjectContext];
    
        AM.title = [NSString stringWithFormat:@"%@",model.title];
        AM.c_id = [NSString stringWithFormat:@"%@",model.c_id];
        AM.is_select = [NSNumber numberWithBool:YES];
        
        isSucceed = [self.manageObjectContext save:&error1];

    }
    
    
    if (unSelect.count == 0) {
        
    }else{
    
        for (articleClassModel * model in unSelect) {
            
            ArticleMessage * AM = [NSEntityDescription insertNewObjectForEntityForName:@"ArticleMessage" inManagedObjectContext:self.manageObjectContext];
            
            AM.title = [NSString stringWithFormat:@"%@",model.title];
            AM.c_id = [NSString stringWithFormat:@"%@",model.c_id];
            AM.is_select = [NSNumber numberWithBool:NO];
            
            isSucceed = [self.manageObjectContext save:&error2];

        }
        

    }

    
    if (isSucceed == YES) {
        NSLog(@"1插入成功");
    }else{
        NSLog(@"error1=%@",error1);
        NSLog(@"error2=%@",error2);

    }
    
    
    
    return isSucceed;
}




#pragma mark- 插入所有系统消息
- (BOOL )insertIntoDataWithsystemMessage:(NSArray *)messageArray{

    NSError * error = nil;
    
    BOOL isSucceed = NO;
    
    for (systemMessageModel * model in messageArray) {
        
    SystemMessage * SM = [NSEntityDescription insertNewObjectForEntityForName:@"SystemMessage" inManagedObjectContext:self.manageObjectContext];
        
        SM.c_id = model.id_;
        SM.titlt = model.title;
        SM.ptime = model.ptime;
        SM.read = model.read;
        
      isSucceed = [self.manageObjectContext save:&error];

    }
    
    
    if (isSucceed == YES) {
        NSLog(@"所有系统消息插入成功");
    }else{
        NSLog(@"error1=%@",error);
    
    }
    
    return isSucceed;
    
}

#pragma mark-删除所有系统消息
/**删除所有系统消息*/
- (void)deleteAllSystemMessageData{
    
    NSFetchRequest * ftRequest = [NSFetchRequest fetchRequestWithEntityName:@"SystemMessage"];
    
      NSArray * array = [self.manageObjectContext executeFetchRequest:ftRequest error:nil];

    
    for (SystemMessage * SM in array) {
        
        [self.manageObjectContext deleteObject:SM];

    }
    
    BOOL is = [self.manageObjectContext save:nil];
    
    if (is == YES) {
        
        NSLog(@"删除成功");
        
    }else{
        NSLog(@"删除失败");
    
    }
    
}

#pragma mark-删除所有数据
/**删除所有数据*/
- (void)deleteAllArticleClassData{

    NSFetchRequest * ftRequest = [NSFetchRequest fetchRequestWithEntityName:@"ArticleMessage"];
    NSArray * array = [self.manageObjectContext executeFetchRequest:ftRequest error:nil];
    
    for (ArticleMessage * AM in array) {
        
        [self.manageObjectContext deleteObject:AM];
        
    }
    
    BOOL is = [self.manageObjectContext save:nil];
    
    if (is == YES) {
        
        NSLog(@"删除所有数据成功");
        
    }else{
        NSLog(@"删除失败");
        
    }

}



#pragma mark- 查找[选中]频道
- (NSArray *)checkSelectArticleCharnel{

    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    
    NSFetchRequest * ftRequest = [NSFetchRequest fetchRequestWithEntityName:@"ArticleMessage"];
    ftRequest.predicate = [NSPredicate predicateWithFormat:@"is_select = '1'"];
    
    NSArray * array = [self.manageObjectContext executeFetchRequest:ftRequest error:nil];

    NSInteger num = array.count;
    
    
    for (ArticleMessage * am in array) {
        
        articleClassModel * model = [[articleClassModel alloc]init];

        model.title = am.title;
        model.c_id = am.c_id;

        [muArray addObject:model];
    }
    
    
    
    if(num == 0){
        
        return nil;
    }else{
    
        NSLog(@"查找成功!");
    
    }
    
    
    
    NSLog(@"%@",muArray);
    
    
    
    return muArray;
}


#pragma mark- 查找[没选中]频道
- (NSArray *)checkUnSelectArticleCharnel{
    
    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    
    NSFetchRequest * ftRequest = [NSFetchRequest fetchRequestWithEntityName:@"ArticleMessage"];
    ftRequest.predicate = [NSPredicate predicateWithFormat:@"is_select = '0'"];
    
    NSArray * array = [self.manageObjectContext executeFetchRequest:ftRequest error:nil];
    
    NSInteger num = array.count;
    
    
    for (ArticleMessage * am in array) {
        
        articleClassModel * model = [[articleClassModel alloc]init];
        
        model.title = am.title;
        model.c_id = am.c_id;
        
        [muArray addObject:model];
    }
    
    
    
    if(num == 0){
        
        return nil;
    }else{
        
        NSLog(@"查找成功!");
        
    }
    
    
    NSLog(@"%@",muArray);
    
    
    
    return muArray;
}


#pragma mark- 查找所有频道
- (NSArray *)checkArticleList{

    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:@"ArticleMessage"];

    NSArray * array = [self.manageObjectContext executeFetchRequest:fetch error:nil];
    
    NSInteger num = array.count;
    
    
    if(num == 0){
        
        return nil;
    }
    
    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    
    for (ArticleMessage * AM in array) {
        
        articleClassModel * model = [[articleClassModel alloc]init];
        
        model.title = AM.title;
        model.c_id = AM.c_id;
        
        [muArray addObject:model];
    }
    
    
    return muArray;
}


#pragma mark- 查找所有系统消息
- (NSArray *)checkAllSystemMessage{

    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:@"SystemMessage"];
    
    NSArray * array = [self.manageObjectContext executeFetchRequest:fetch error:nil];
    
    NSInteger num = array.count;

    if(num == 0){
        
        return nil;
    }
    
    
    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    
    for (SystemMessage * SM in array) {
        
        systemMessageModel * model = [[systemMessageModel alloc]init];
        
        model.title = SM.titlt;
        model.id_ = SM.c_id;
        model.ptime = SM.ptime;
        model.read = SM.read;

        [muArray addObject:model];
    }
    
    
    return muArray;

}




@end
