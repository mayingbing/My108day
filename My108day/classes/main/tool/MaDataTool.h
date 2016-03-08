//
//  MaDataTool.h
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaDataTool : NSObject


-(void)GET:(NSString *)urlStr  WithID:(id)ID  parameters:(id)parameters success:(void(^)(NSArray *objArr))success failure:(void(^)(NSError *error))failure;

@end
