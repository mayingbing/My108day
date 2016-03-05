//
//  MaOriginalView.m
//  My108day
//
//  Created by apple on 16/3/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaOriginalView.h"

@interface MaOriginalView ()

// 头像
@property (nonatomic, weak) UIImageView *iconView;


// 昵称
@property (nonatomic, weak) UILabel *nameView;


// vip
@property (nonatomic, weak) UIImageView *vipView;


// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;


// 正文
@property (nonatomic, weak) UILabel *textView;


@end

@implementation MaOriginalView

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
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    [self addSubview:textView];
    _textView = textView;
}


@end
