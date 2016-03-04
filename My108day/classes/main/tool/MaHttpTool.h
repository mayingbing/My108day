//
//  MaHttpTool.h
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaHttpTool : NSObject
-(void)GET:(NSString *)urlStr parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
