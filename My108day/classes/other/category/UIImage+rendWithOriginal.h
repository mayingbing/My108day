//
//  UIImage+rendWithOriginal.h
//  My108day
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (rendWithOriginal)

+(UIImage *)imageRenderingModeAlwaysOriginalWithImageName:(NSString *)imageName;
+ (instancetype)imageWithStretchableName:(NSString *)imageName;
@end
