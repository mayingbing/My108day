//
//  MATextView.m
//  简历
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MATextView.h"
#import "MAOneViewController.h"


@interface MATextView ()<UITextViewDelegate>

@end

@implementation MATextView

-(instancetype)init{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    if (self = [super initWithFrame:frame]) {
        
        [self setView];
    }
    return self;
}

-(void)setView{
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"bg"];
    
    
    UILabel *titleLable = [[UILabel alloc]init];
    _titleLable = titleLable;
    
    [self addSubview:titleLable];
    titleLable.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2,15 , 100, 35);
    
    
    // 添加textView
    [self setUpTextView];
    
    
    
}


-(void)setUpTextView{
    UITextView *textLable = [[UITextView alloc] initWithFrame:CGRectMake(25, 50, self.bounds.size.width-50, self.bounds.size.height-230)];
    

    textLable.layer.cornerRadius = 5;
    textLable.layer.masksToBounds = YES;
    textLable.backgroundColor = [UIColor lightGrayColor];
    textLable.font = [UIFont systemFontOfSize:18];
    textLable.textColor = [UIColor brownColor];
    _textLable = textLable;
    [self addSubview:textLable];

}

-(void)MAOneViewControllerSaveDataWithContent:(NSString *)content{
    
    self.textLable.text = content;
    
}

@end
