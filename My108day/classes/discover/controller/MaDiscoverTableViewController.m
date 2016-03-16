//
//  MABaseViewController.m
//  简历
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaDiscoverTableViewController.h"
#import "MASlipView.h"
#import "EFAnimationViewController.h"

#define screenHight self.view.frame.size.height

@interface MaDiscoverViewController ()

@property (nonatomic ,assign)bool isShow;
@property (nonatomic ,weak)MASlipView *slipView;

@property (nonatomic, strong) EFAnimationViewController *EFviewController;
@end

@implementation MaDiscoverViewController
- (void)dealloc {
    
    [_EFviewController.view removeFromSuperview];
    [_EFviewController removeFromParentViewController];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isShow = NO;
//    self.navigationController.navigationBarHidden = YES;
    
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imgView];
    
    UIImage *img = [UIImage imageNamed:@"bg"];
    imgView.image = img;
    

    
    MASlipView *slipView = [[MASlipView alloc]initWithViewController:self];
    _slipView = slipView;
    [self.view addSubview:slipView];
    
    
    self.EFviewController = ({
        EFAnimationViewController *viewController = [[EFAnimationViewController alloc] init];
        [self.view addSubview:viewController.view];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        viewController;
    });
    
    
    
}

-(void)show{
    
    [_slipView show];
    
}

@end
