//
//  MaDataTool.m
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaDataTool.h"
#import "MaHttpTool.h"
#import "MaAccount.h"
#import "MaAccountTool.h"
#import "CZStatus.h"
#import "IWStatusCacheTool.h"
#import "MaStatuesFrame.h"
#import "MaParames.h"


@implementation MaDataTool

-(void)GET:(NSString *)urlStr WithID:(id)ID parameters:(id)parameters success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    
 
    // 拼接参数
    MaParames *param = [[MaParames alloc] init];
    param.access_token = [MaAccountTool account].access_token;
    param.max_id = ID;
    
    // 加载缓存数据
    NSArray *statuses =  [IWStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (CZStatus *status in statuses) {
            MaStatuesFrame *statusF = [[MaStatuesFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
        // 不需要在发送请求
        return;
    }

    
    MaHttpTool *http = [[MaHttpTool alloc]init];
    
    
    
    
    
    [http GET:urlStr parameters:parameters success:^(id responseObject) {
        
        // httpTool请求成功的时候调用，把代码保存起来
        // 存储数据
        [IWStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
        // 获取到微博数据 转换成模型
        // 获取微博字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        NSArray *objArr = [CZStatus objectArrayWithKeyValuesArray:dictArr];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (CZStatus *status in objArr) {
            MaStatuesFrame *statusF = [[MaStatuesFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }

        if (success) {
            success(arrM);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    
    
    
}

@end
