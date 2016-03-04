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


@implementation MaDataTool


-(void)GET:(NSString *)urlStr parameters:(id)parameters success:(void(^)(NSArray *objArr))success failure:(void(^)(NSError *error))failure{
    
    MaHttpTool *http = [[MaHttpTool alloc]init];
    
    [http GET:urlStr parameters:parameters success:^(id responseObject) {
        
        // httpTool请求成功的时候调用，把代码保存起来
        
        // 获取到微博数据 转换成模型
        // 获取微博字典数组
        NSArray *dictArr = responseObject[@"statuses"];
        NSArray *objArr = [CZStatus objectArrayWithKeyValuesArray:dictArr];
        
        if (success) {
            success(objArr);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    
    
    
}

@end
