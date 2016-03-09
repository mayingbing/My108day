//
//  MaClearCache.h
//  My108day
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaClearCache : NSObject

@property (copy, nonatomic) void(^sucessClearBlock)(CGFloat fileSize);


-(void)clearCache;
@end
