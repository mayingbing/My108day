//
//  MaAccount.h
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
/*
 
 
 返回值字段	字段类型	字段说明
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid	string	当前授权用户的UID。
 
 */

#import <Foundation/Foundation.h>

@interface MaAccount : NSObject

@property(nonatomic ,copy)NSString *access_token;
@property(nonatomic ,copy)NSString *expires_in;
@property(nonatomic ,copy)NSString *remind_in;
@property(nonatomic ,copy)NSString *uid;
@property(nonatomic ,copy)NSString *expires_date;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

- (void)setExpires_in:(NSString *)expires_in;

@end
