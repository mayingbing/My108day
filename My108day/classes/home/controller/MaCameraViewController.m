//
//  MaCameraViewController.m
//  My108day
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanBackgroundView.h"
#import "Masonry.h"

#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

@interface MaCameraViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic)   ScanBackgroundView *scanBGView;
@property (strong, nonatomic) UIImageView *scanRectView, *lineView;
@property (strong, nonatomic) UILabel *tipLabel;

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation MaCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫描二维码";
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configureViews];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.videoPreviewLayer.session stopRunning];
    [self.videoPreviewLayer removeFromSuperlayer];
    [self scanLineStopAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureViews {
    CGFloat width = kScreen_Width*2/3;
    CGFloat padding = (kScreen_Width - width)/2;
    CGRect scanRect = CGRectMake(padding, kScreen_Height/5, width, width);
    
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
            
            AVCaptureMetadataOutput *captureMetadataOutput = [AVCaptureMetadataOutput new];
            [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_queue_create("kScanCodeQueueName", NULL)];
            [captureSession addOutput:captureMetadataOutput];
            
            if(![captureMetadataOutput.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
                NSLog(@"摄像头不支持扫描二维码");
                return;
            } else {
                [captureMetadataOutput setMetadataObjectTypes:captureMetadataOutput.availableMetadataObjectTypes];
            }
            
            captureMetadataOutput.rectOfInterest = CGRectMake(CGRectGetMinY(scanRect)/CGRectGetHeight(self.view.frame),
                                                              1 - CGRectGetMaxX(scanRect)/CGRectGetWidth(self.view.frame),
                                                              CGRectGetHeight(scanRect)/CGRectGetHeight(self.view.frame),
                                                              CGRectGetWidth(scanRect)/CGRectGetWidth(self.view.frame));//设置扫描区域
            
            _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
            [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            [_videoPreviewLayer setFrame:self.view.bounds];
        }
    }
    
    if (!_scanBGView) {
        _scanBGView = [[ScanBackgroundView alloc]initWithFrame:self.view.bounds];
        _scanBGView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        _scanBGView.scanRect = scanRect;
    }
    
    if (!_scanRectView) {
        _scanRectView = [[UIImageView alloc] initWithFrame:scanRect];
        _scanRectView.image = [[UIImage imageNamed:@"scan_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
        _scanRectView.clipsToBounds = YES;
    }
    
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont boldSystemFontOfSize:16];
        _tipLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _tipLabel.text = @"将二维码放入框内，即可自动扫描";
    }
    
    if (!_lineView) {
        UIImage *lineImage = [UIImage imageNamed:@"scan_line"];
        CGFloat lineHeight = 2;
        CGFloat lineWidth = CGRectGetWidth(_scanRectView.frame);
        _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -lineHeight, lineWidth, lineHeight)];
        _lineView.contentMode = UIViewContentModeScaleToFill;
        _lineView.image = lineImage;
    }
    
    [self.view.layer addSublayer:_videoPreviewLayer];
    [self.view addSubview:_scanBGView];
    [self.view addSubview:_scanRectView];
    [self.view addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_scanRectView.mas_bottom).offset(20);
        make.height.mas_equalTo(30);
    }];
    [_scanRectView addSubview:_lineView];
    [_videoPreviewLayer.session startRunning];
    [self scanLineStartAction];
}

- (void)scanLineStartAction{
    [self scanLineStopAction];
    
    CABasicAnimation *scanAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    scanAnimation.fromValue = @(-CGRectGetHeight(_lineView.frame));
    scanAnimation.toValue = @(CGRectGetHeight(_lineView.frame) + CGRectGetHeight(_scanRectView.frame));
    
    scanAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scanAnimation.repeatCount = CGFLOAT_MAX;
    scanAnimation.duration = 2.0;
    [self.lineView.layer addAnimation:scanAnimation forKey:@"basic"];
}
- (void)scanLineStopAction{
    [self.lineView.layer removeAllAnimations];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    //判断是否有数据，是否是二维码数据
    if (metadataObjects.count > 0) {
        __block AVMetadataMachineReadableCodeObject *result = nil;
        [metadataObjects enumerateObjectsUsingBlock:^(AVMetadataMachineReadableCodeObject *obj, NSUInteger idx, BOOL *stop) {
            if ([obj.type isEqualToString:AVMetadataObjectTypeQRCode]) {
                result = obj;
                *stop = YES;
            }
        }];
        if (!result) {
            result = [metadataObjects firstObject];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self analyseResult:result];
        });
    }
}

- (void)analyseResult:(AVMetadataMachineReadableCodeObject *)result{
    NSLog(@"result : %@", result.stringValue);
    if (result.stringValue.length <= 0) {
        return;
    }
    
    //停止扫描
    [self.videoPreviewLayer.session stopRunning];
    [self scanLineStopAction];
    
    //震动反馈
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    //解析结果
    if (self.sucessScanBlock) {
        self.sucessScanBlock(result.stringValue);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
