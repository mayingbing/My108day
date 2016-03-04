//
//  CZStatus.m
//  传智微博
//
//  Created by apple on 15-3-8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZStatus.h"

#import "CZPhoto.h"

@implementation CZStatus
// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[CZPhoto class]};
}


@end
