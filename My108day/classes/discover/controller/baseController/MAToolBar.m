//
//  MAToolBar.m
//  简历
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MAToolBar.h"


@interface MAToolBar ()



@end

@implementation MAToolBar


-(instancetype)init{
    if (self = [super init]) {
        [self setToolBarChildView];
    }
    return self;
}



-(void)setToolBarChildView{
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width-85, 44)];
    textView.layer.cornerRadius = 3;
    textView.layer.masksToBounds = YES;
    textView.font = [UIFont systemFontOfSize:18];
    _textView = textView;
    textView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:textView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn = btn;
    btn.layer.cornerRadius =3;
    btn.layer.masksToBounds = YES;
    btn.frame = CGRectMake(CGRectGetMaxX(textView.frame)+5, 5, 60, 44);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:btn];
    
}


@end
