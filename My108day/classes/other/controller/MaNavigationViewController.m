//
//  MaNavigationViewController.m
//  My108day
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaNavigationViewController.h"
#import "UIBarButtonItem+MaBarButtonItem.h"

@interface MaNavigationViewController ()

@end

@implementation MaNavigationViewController


//+(void)initialize{
//    
//    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    
//    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
//    
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
   
  
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navi_expend"] highImage:[UIImage imageNamed:@"navi_expend"] target:self action:@selector(backPre) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = left;
        
    }
    [super pushViewController:viewController animated:animated];
}

-(void)backPre{
    
    [self popViewControllerAnimated:YES];
    
}

@end
