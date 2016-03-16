//
//  MASlipView.m
//  简历
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MASlipView.h"

@interface MASlipView ()

@property (nonatomic ,assign)BOOL isOpen;
@property (nonatomic ,weak)UIViewController *vc;

@end


@implementation MASlipView

-(instancetype)initWithViewController:(UIViewController *)vc{
    _vc = vc;
    CGRect slipFrame = CGRectMake(-150, 0, 150,vc.view.frame.size.height);
    self = [super initWithFrame:slipFrame];
    self.backgroundColor = [UIColor grayColor];
    _isOpen = NO;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(show)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [vc.view addGestureRecognizer:rightSwipe];
    [vc.view addGestureRecognizer:leftSwipe];
    [self setAllChildView];
    return self;
}


-(void)show{
   
    [UIView animateWithDuration:0.25 animations:^{
        
         self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

        [_vc.view bringSubviewToFront:self];
        
        
        
    } completion:^(BOOL finished) {
        
        _isOpen = YES;
    }];
    
}

-(void)hide{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
       
        
    } completion:^(BOOL finished) {
        
        _isOpen = NO;
    }];

    
}

-(void)setAllChildView{
    
    NSArray *imgArr = [NSArray array];
    NSArray *textArr = [NSArray array];
    imgArr = @[@"profile",@"yx",@"zszk",@"gzjy",@"grpj"];
    textArr = @[@"个人简介",@"求职意向",@"知识状况",@"工作经验",@"自我评价"];
    
    for (int i = 0; i<imgArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        
        [btn setTitle:textArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        float btnY = 70 + i *(self.bounds.size.height-108)/imgArr.count;
        
        btn.frame = CGRectMake(0, btnY, 130, 35);
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn{
    
    
    
}

@end
