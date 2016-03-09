//
//  MaChooseCityTableViewController.m
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaChooseCityTableViewController.h"
#import "MaCameraViewController.h"

#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
#import "MaClearCache.h"
#import "UIImageView+WebCache.h"
#import "MaMyCamer.h"


@interface MaChooseCityTableViewController ()
@property(nonatomic ,weak)UIButton *lightBtn;
@end

@implementation MaChooseCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    CGFloat screenWidth = self.view.width;
    CGFloat screenHeight = self.view.height;
    
    UIButton *carmeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    carmeBtn.backgroundColor = [UIColor cyanColor];
    carmeBtn.layer.cornerRadius = 3;
    carmeBtn.layer.masksToBounds = YES;
    [carmeBtn setTitle:@"我的相机" forState:UIControlStateNormal];
    
    [carmeBtn addTarget:self action:@selector(openCarmer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carmeBtn];
    carmeBtn.frame = CGRectMake((screenWidth-100)*0.5, screenHeight*0.2, 100, 35);
    
    
    
    UIButton *camerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    camerBtn.frame = CGRectMake((screenWidth-100)*0.5, screenHeight*0.4, 100, 35);
    [self.view addSubview:camerBtn];
    [camerBtn setTitle:@"扫码二维码" forState:UIControlStateNormal];
    [camerBtn setBackgroundColor:[UIColor cyanColor]];
    camerBtn.layer.cornerRadius = 3;
    camerBtn.layer.masksToBounds = YES;
    [camerBtn addTarget:self action:@selector(cameraOpen) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *lightBtn = [[UIButton alloc]init];
    lightBtn.backgroundColor = [UIColor cyanColor];
    lightBtn.layer.cornerRadius = 3;
    lightBtn.layer.masksToBounds = YES;
    _lightBtn = lightBtn;
    [lightBtn setTitle:@"打开手电筒" forState:UIControlStateNormal];
    [lightBtn addTarget:self action:@selector(openSystemLight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lightBtn];
    lightBtn.frame = CGRectMake((screenWidth-100)*0.5, screenHeight*0.6, 100, 35);
    
    
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.backgroundColor = [UIColor cyanColor];
    clearBtn.layer.cornerRadius = 3;
    clearBtn.layer.masksToBounds = YES;
    [clearBtn setTitle:@"清理缓存" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [clearBtn addTarget:self action:@selector(clearCache:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    clearBtn.frame = CGRectMake((screenWidth-100)*0.5, screenHeight*0.8, 100, 35);

}

-(void)openCarmer:(id)sender{
    
    MaMyCamer *myCamerVc = [[MaMyCamer alloc]init];
    
    [self.navigationController pushViewController:myCamerVc animated:YES];
    
}


-(void)clearCache:(id)sender{
    
    
    [MaClearCache clearCache];
    
}

-(void)openSystemLight:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (button.selected) {
        [self systemLightSwitch:YES];
        [_lightBtn setTitle:@"关闭手电筒" forState:UIControlStateNormal];
    } else {
        [self systemLightSwitch:NO];
        [_lightBtn setTitle:@"打开手电筒" forState:UIControlStateNormal];
    }
    
}

-(void)systemLightSwitch:(BOOL)open{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }

    
}

-(void)cameraOpen{
    
    MaCameraViewController *cameraVc = [[MaCameraViewController alloc]init];
    
    [ self.navigationController pushViewController:cameraVc animated:YES];
    
}


@end
