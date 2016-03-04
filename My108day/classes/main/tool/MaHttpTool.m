//
//  MaHttpTool.m
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaHttpTool.h"
#import "AFNetworking.h"

@implementation MaHttpTool


-(void)GET:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // httpTool请求成功的时候调用，把代码保存起来
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
 
}


-(void)POST:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // httpTool请求成功的时候调用，把代码保存起来
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

@end
