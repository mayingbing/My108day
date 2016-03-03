//
//  MaTabBarController.m
//  My108day
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaTabBarController.h"
#import "UIImage+rendWithOriginal.h"

@interface MaTabBarController ()

@end

@implementation MaTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建四个子控制器
    UITableViewController *home = [[UITableViewController alloc]init];
    home.view.backgroundColor = [UIColor yellowColor];
    
    [self setOneChildViewControllerWith:home imageName:@"home@2x" selImageName:@"home_h@2x" title:@"首页"];
    
    //子控制器
    UITableViewController *discover = [[UITableViewController alloc]init];
    discover.view.backgroundColor = [UIColor cyanColor];
    
    [self setOneChildViewControllerWith:discover imageName:@"choiceness@2x" selImageName:@"choiceness_h@2x" title:@"发现"];
    
    //子控制器
    UITableViewController *active = [[UITableViewController alloc]init];
    active.view.backgroundColor = [UIColor grayColor];
    
    [self setOneChildViewControllerWith:active imageName:@"active@2x" selImageName:@"active_h@2x" title:@"活动"];
   
    //子控制器
    UITableViewController *profile = [[UITableViewController alloc]init];
    profile.view.backgroundColor = [UIColor greenColor];
    
    [self setOneChildViewControllerWith:profile imageName:@"mine@2x" selImageName:@"mine_h@2x" title:@"我的"];
   }


-(void)setOneChildViewControllerWith:(UITableViewController *)vc imageName:(NSString *)imageName selImageName:(NSString *)selImageName title:(NSString *)title{
    
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    vc.tabBarItem.selectedImage = [UIImage imageRenderingModeAlwaysOriginalWithImageName:selImageName];
    vc.tabBarItem.title = title;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    [dic setValue:[UIColor colorWithRed:71/255.0 green:186/255.0 blue:167/255.0 alpha:1] forKey:NSForegroundColorAttributeName];
    
    [vc.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    
    [self addChildViewController:vc];
    
}



@end
