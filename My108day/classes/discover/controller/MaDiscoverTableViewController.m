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
#import "MATotalViewController.h"
#import "MASinaViewController.h"
#import "MA108dayViewController.h"
#import "MAJianliViewController.h"

#define screenHight self.view.frame.size.height

@interface MaDiscoverViewController ()<MASlipViewDelegate>

@property (nonatomic ,strong)MATotalViewController *totalVc;
@property (nonatomic ,strong)MASinaViewController *sinaVc;
@property (nonatomic ,strong)MA108dayViewController *madayVc;
@property (nonatomic ,strong)MAJianliViewController *jianliVc;
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
    
    self.navigationItem.title = @"我的简历";
    
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:imgView];
    
    UIImage *img = [UIImage imageNamed:@"bg"];
    imgView.image = img;
    
    
    
    MASlipView *slipView = [[MASlipView alloc]initWithViewController:self];
    _slipView = slipView;
    [self.view addSubview:slipView];
    slipView.delegate = self;
    
    self.EFviewController = ({
        EFAnimationViewController *viewController = [[EFAnimationViewController alloc] init];
        [self.view addSubview:viewController.view];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        viewController;
    });
    [self loadChildVc];
}

-(void)show{
    
    [_slipView show];
    
}
-(void)loadChildVc{
    
    MATotalViewController *totalVc = [[MATotalViewController alloc]init];
    _totalVc = totalVc;
    MASinaViewController *sinaVc = [[MASinaViewController alloc]init];
    _sinaVc = sinaVc;
    MA108dayViewController *madayVc = [[MA108dayViewController alloc]init];
    _madayVc = madayVc;
    MAJianliViewController *jianliVc = [[MAJianliViewController alloc]init];
    _jianliVc = jianliVc;
    
    
}
-(void)MASlipViewTouchWithBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
            [self.navigationController pushViewController:_totalVc animated:YES];
        }
            
            break;
        case 1:
        {
            [self.navigationController pushViewController:_sinaVc animated:YES];
        }
            
            break;
        case 2:
        {
            [self.navigationController pushViewController:_madayVc animated:YES];
        }
            
            break;
        case 3:
        {
            [self.navigationController pushViewController:_jianliVc animated:YES];
        }
            
            break;
            
        default:
            break;
    }
    
    
}

@end
