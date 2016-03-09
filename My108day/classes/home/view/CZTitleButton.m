//
//  CZTitleButton.m
//
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZTitleButton.h"
#import "UIImage+rendWithOriginal.h"
#import "UIView+Frame.h"


@implementation CZTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
       
    }
    
    return self;
}

- (void)layoutSubviews
{
     [super layoutSubviews];
    
    if (self.currentImage == nil) return;
    

    // title
    self.titleLabel.x = 5;
    // image
    self.imageView.x = 77;

}

// 重写setTitle方法，扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
