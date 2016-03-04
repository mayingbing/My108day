//
//  UIImage+rendWithOriginal.m
//  My108day
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImage+rendWithOriginal.h"

@implementation UIImage (rendWithOriginal)

+(UIImage *)imageRenderingModeAlwaysOriginalWithImageName:(NSString *)imageName{
    
    UIImage *selImage =[UIImage imageNamed:imageName];
    
   return  [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


@end
