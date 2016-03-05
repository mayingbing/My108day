//
//  MaTableViewCell.m
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaTableViewCell.h"
#import "MaOriginalView.h"
#import "MaRetView.h"
#import "MaToolView.h"

@interface MaTableViewCell ()

@property(nonatomic ,strong)MaOriginalView *originalView ;
@property(nonatomic ,strong)MaRetView *retweetView ;
@property(nonatomic ,strong)MaToolView *toolBar;

@end

@implementation MaTableViewCell

+(MaTableViewCell *)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    
   MaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[MaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    return cell;
}

// 注意：cell是用initWithStyle初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
    }
    
    return self;
    
}
// 添加所有子控件
- (void)setUpAllChildView
{
    // 原创微博
    MaOriginalView *originalView = [[MaOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    // 转发微博
    MaRetView *retweetView = [[MaRetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    // 工具条
    MaToolView *toolBar = [[MaToolView alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

-(void)setStatus:(CZStatus *)status{
    
    _status = status;
    
    
    
}

@end
