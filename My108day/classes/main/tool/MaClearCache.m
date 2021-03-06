//
//  MaClearCache.m
//  My108day
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaClearCache.h"
#import "UIImageView+WebCache.h"
#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

#define IWStatusFile NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

@implementation MaClearCache


-(void)clearCache{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    CGFloat fileSize = 0;
    if([fileManager fileExistsAtPath:IWStatusFile]){
        long long size=[fileManager attributesOfItemAtPath:IWStatusFile error:nil].fileSize;
        fileSize = size/1024.0;
        
    }
    
    if ([fileManager fileExistsAtPath:IWStatusFile]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:IWStatusFile];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            if ([fileName containsString:@"account.data"]) {
                continue;
            }
            NSString *absolutePath=[IWStatusFile stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
    
    //解析结果
    //缓存文件大小
   
    
    
    
    if (self.sucessClearBlock) {
        self.sucessClearBlock(fileSize);

    }

}
@end
