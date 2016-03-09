//
//  MaMyCamer.m
//  My108day
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaMyCamer.h"
#import <AVFoundation/AVFoundation.h>

@interface MaMyCamer ()
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end

@implementation MaMyCamer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configureViews];
}

-(void)configureViews{
    
    if (!_videoPreviewLayer) {
        NSError *err;
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&err];
        
        if (!input) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        } else {
            AVCaptureSession *captureSession = [AVCaptureSession new];
            [captureSession addInput:input];

            _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
            [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            [_videoPreviewLayer setFrame:self.view.bounds];
        }
    }
    
    [self.view.layer addSublayer:_videoPreviewLayer];
    [_videoPreviewLayer.session startRunning];
}

@end
