//
//  MaDataTool.h
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaDataTool : NSObject


-(void)GETMoreData:(NSString *)urlStr WithID:(id)ID  success:(void (^)(NSArray *))success failure:(void (^)(NSMutableArray *))failure;

-(void)GETNewData:(NSString *)urlStr WithID:(id)ID  success:(void (^)(NSArray *))success failure:(void (^)(NSArray *))failure;
@end
