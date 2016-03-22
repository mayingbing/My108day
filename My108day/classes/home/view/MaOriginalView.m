//
//  MaOriginalView.m
//  My108day
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaOriginalView.h"
#import "MaStatuesFrame.h"
#import "CZStatus.h"
#import "CZUser.h"
#import "CZPhoto.h"

@interface MaOriginalView ()

@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLable;
@property(nonatomic ,strong)UILabel *timeLable;
@property(nonatomic ,strong)UILabel *sourceLable;
@property(nonatomic ,strong)UILabel *textLable ;


@end

@implementation MaOriginalView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpChildView];
        
        
    }
    return self;
}

-(void)setUpChildView{
    
    UIImageView *iconView = [[UIImageView alloc]init];
    self.iconView = iconView;
    [self addSubview:iconView];
    
    UILabel *nameLable = [[UILabel alloc]init];
    self.nameLable = nameLable;
    nameLable.font = CZNameFont;
    [self addSubview:nameLable];
    
    UILabel *timeLable = [[UILabel alloc]init];
    self.timeLable = timeLable;
    timeLable.font = CZTimeFont;
    [self addSubview:timeLable];
    
    UILabel *sourceLable = [[UILabel alloc]init];
    self.sourceLable = sourceLable;
    sourceLable.font = CZSourceFont;
    [self addSubview:sourceLable];
    
    UILabel *textLable = [[UILabel alloc]init];
    self.textLable = textLable;
    textLable.font = CZTextFont;
    textLable.numberOfLines = 0;
    [self addSubview:textLable];
    
    
    
    
}


-(void)setStatuesF:(MaStatuesFrame *)statuesF{
    
    _statuesF = statuesF;
    
    @weakify(self)
    [self.iconView sd_setImageWithURL:self.statuesF.statues.user.profile_image_url placeholderImage:[UIImage imageNamed:@"topic_placeholder"]];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        
    }];
    
    self.nameLable.text = self.statuesF.statues.user.name;
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.iconView.mas_right).with.offset(10);
        make.top.equalTo(self.iconView);
        make.height.equalTo(@15);
        
    }];
    
    self.timeLable.text = self.statuesF.statues.created_at;
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.nameLable);
        make.bottom.equalTo(self.iconView);
        make.height.equalTo(self.nameLable);
        
    }];
    
    self.sourceLable.text = self.statuesF.statues.source;
    [self.sourceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.timeLable);
        make.left.equalTo(self.timeLable.mas_right).with.offset(10);
        make.height.equalTo(self.nameLable);
        
    }];
    
    self.textLable.text = self.statuesF.statues.text;
    [self.textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.iconView);
        make.top.equalTo(self.iconView.mas_bottom).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        
    }];
    
    
}




@end
