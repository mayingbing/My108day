//
//  MaChooseRootViewController.m
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaChooseRootViewController.h"
#import "MaTabBarController.h"
#import "MaNewFeatureViewController.h"

#define MaVersionKey @"version"
#define keyWindow  [UIApplication sharedApplication].keyWindow

@implementation MaChooseRootViewController


+(void)chooseRootViewControllerWithWindow:(UIWindow *)window{
    
   
        //选择是否进入新特性界面
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:MaVersionKey];
        if ([currentVersion isEqualToString:lastVersion]) {
    
            MaTabBarController *tabBarVc = [[MaTabBarController alloc]init];
            window.rootViewController = tabBarVc;
        }else{
            MaNewFeatureViewController *newFeature = [[MaNewFeatureViewController alloc]init];
            window.rootViewController = newFeature;
    
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:MaVersionKey];
        }
}

@end
