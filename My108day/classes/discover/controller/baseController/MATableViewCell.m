//
//  MATableViewCell.m
//  简历
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MATableViewCell.h"
#import "MACellView.h"

@interface MATableViewCell ()

@end

@implementation MATableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString * ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    
    if (!cell) {
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
    
    MACellView *titleView = [[MACellView alloc]init];
    [self addSubview:titleView];
    
    
}
@end
