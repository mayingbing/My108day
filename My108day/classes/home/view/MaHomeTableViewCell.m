//
//  MaHomeTableViewCell.m
//  My108day
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaHomeTableViewCell.h"
#import "MaOriginalView.h"
#import "MaRetweetedView.h"
#import "MaToolBarView.h"

#import "CZStatus.h"
#import "CZUser.h"
#import "CZPhoto.h"

#import "MaStatuesFrame.h"

@interface MaHomeTableViewCell ()

@property(nonatomic ,strong)MaOriginalView *originalView;

@property(nonatomic ,strong)MaRetweetedView *retweetedView;

@property(nonatomic ,strong)MaToolBarView *toolBarView;

@property(nonatomic ,assign)CGFloat originalViewFrame;

@property(nonatomic ,assign)CGFloat retweetedViewFrame;

@property(nonatomic ,assign)CGFloat toolBarViewFrame;


@end

@implementation MaHomeTableViewCell
static NSString *ID = @"cell";

+(instancetype)cellWithTableView:tableView{
    
   id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        
        [self setUpChildView];
        
    }
    
    
    return self;
}



-(void)setUpChildView{
    CGRect originalFrame = CGRectMake(0, 0, self.width, self.statuesF.originalViewHeight);
    MaOriginalView *originalView = [[MaOriginalView alloc]initWithFrame:originalFrame];
    self.originalView = originalView;
    [self.contentView addSubview:originalView];
    
    CGRect retweetFrame = CGRectMake(0, self.statuesF.originalViewHeight, self.width, self.statuesF.retweetedViewHeight);
    MaRetweetedView *retweetedView = [[MaRetweetedView alloc]initWithFrame:retweetFrame];
    self.retweetedView = retweetedView;
    [self.contentView addSubview:retweetedView];
    
    CGRect toolBarFrame = CGRectMake(0, CGRectGetMaxY(retweetFrame), self.width, self.statuesF.toolBarViewHeight);
    MaToolBarView *toolBarView = [[MaToolBarView alloc]initWithFrame:toolBarFrame];
    self.toolBarView = toolBarView;
    [self.contentView addSubview:toolBarView];
    
}

-(void)setStatuesF:(MaStatuesFrame *)statuesF{
    
    self.originalView.statuesF = statuesF;
    
    self.retweetedView.statuesF = statuesF;
    
    self.toolBarView.statuesF = statuesF;
    
}



@end
