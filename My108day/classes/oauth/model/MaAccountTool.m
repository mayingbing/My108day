//
//  MaAccountTool.m
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaAccountTool.h"
#import "MaAccount.h"



#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation MaAccountTool

static MaAccount *_account;



+ (void)saveAccount:(MaAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:CZAccountFileName];
}

+ (MaAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:CZAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }
        
    }
    
    
    return _account;
}


@end
