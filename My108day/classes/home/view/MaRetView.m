//
//  MaRetView.m
//  My108day
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaRetView.h"

@interface MaRetView ()

// 昵称
@property (nonatomic, weak) UILabel *nameView;


// 正文
@property (nonatomic, weak) UILabel *textView;

@end

@implementation MaRetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    [self addSubview:nameView];
    _nameView = nameView;
    
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    [self addSubview:textView];
    _textView = textView;
}


@end
