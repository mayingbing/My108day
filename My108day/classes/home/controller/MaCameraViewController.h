//
//  MaCameraViewController.h
//  My108day
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaCameraViewController : UIViewController
@property (copy, nonatomic) void(^sucessScanBlock)(NSString *result);
@end
