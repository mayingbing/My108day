//
//  IWStatusCacheTool.m
//  ItcastWeibo
//
//  Created by yz on 14/11/19.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWStatusCacheTool.h"
#import "FMDB.h"
#import "MaParames.h"

#import "MaAccount.h"
#import "MaAccountTool.h"
#import "MaStatuesFrame.h"
#import "MJExtension.h"
#import "CZStatus.h"
#define IWStatusFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"status.sqlite"]

static FMDatabase *_db;

@implementation IWStatusCacheTool

+ (void)initialize
{
    // 创建FMDatabase
    _db = [FMDatabase databaseWithPath:IWStatusFile];
    
    // 打开数据库
    if ([_db open]) {
        NSLog(@"打开成功");
        
        // 创建表格
         BOOL success =[_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,idstr text not null,dict blob not null,access_token text not null);"];
        if (success) {
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
        
    }else{
        NSLog(@"打开失败");
    }
}

+ (void)saveWithStatuses:(NSArray *)dictArr
{
    NSString *accessToken = [MaAccountTool account].access_token;
    for (NSDictionary *dict in dictArr) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        BOOL success =[_db executeUpdate:@"insert into t_status (idstr,access_token,dict) values(?,?,?)",dict[@"idstr"],accessToken,data];
        if (success) {
//            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }
        
        
    }
}

+ (NSArray *)statusesWithParam:( MaParames *)param
{
    
    FMResultSet *set;
    if (param.max_id) {
        set = [_db executeQuery:@"select * from t_status where access_token = ? and idstr <= ?  order by idstr desc limit 20",param.access_token,param.max_id];
    }else if (param.since_id){
        set = [_db executeQuery:@"select * from t_status where access_token = ? and idstr > ?order by idstr desc limit 20",param.access_token,param.since_id];
    }else{
        
     set = [_db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 20",param.access_token];
    }
    
    NSMutableArray *arrM = [NSMutableArray array];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         CZStatus *s = [CZStatus objectWithKeyValues:dict];
        [arrM addObject:s];
    }
    
    return arrM;
}

@end
