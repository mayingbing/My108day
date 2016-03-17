//
//  MACellView.m
//  简历
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MACellView.h"

@implementation MACellView

-(instancetype)init{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

-(void)setView{
   
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"cellbg"];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 20, 60, 60)];
    iconView.layer.cornerRadius = 30;
    iconView.layer.masksToBounds = YES;
    [self addSubview:iconView];
    iconView.image = [UIImage imageNamed:@"icon"];
    
    CGFloat nameX = CGRectGetMaxX(iconView.frame)+5;
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(nameX, 25, 150, 20)];
    [self addSubview:name];
    name.text = @"姓名：马颖兵";
    
    CGFloat contentY = CGRectGetMaxY(name.frame)+5;
    UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(nameX, contentY, 200, 20)];
    [self addSubview:content];
    content.text = @"联系电话：17051000537";
    
}

@end
