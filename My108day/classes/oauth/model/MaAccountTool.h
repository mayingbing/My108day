//
//  MaAccountTool.h
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MaAccount;

@interface MaAccountTool : NSObject

+ (void)saveAccount:(MaAccount *)account;
+ (MaAccount *)account;
@end
