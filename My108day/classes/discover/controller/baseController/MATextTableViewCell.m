//
//  MATextTableViewCell.m
//  简历
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MATextTableViewCell.h"
#import "MATextView.h"
#import "MAOneViewController.h"

@interface MATextTableViewCell ()

@end

@implementation MATextTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString * ID = @"text";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加所有子控件
        [self setUpAllChildView];
        
    }

    return self;
}

-(void)setUpAllChildView{
    
    MATextView *textView = [[MATextView alloc]init];
    _textView = textView;
    
    
    
    [self addSubview:textView];
}

@end
