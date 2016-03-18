//
//  MaTableViewCell.m
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaTableViewCell.h"
#import "CZStatus.h"
#import "CZUser.h"
#import "CZPhoto.h"
#import "UIImageView+WebCache.h"




@interface MaTableViewCell ()
//原创微博
@property (nonatomic ,strong)UIImageView *iconView;
@property (nonatomic ,strong)UILabel *nameLable;
@property (nonatomic ,strong)UILabel *timeLable;
@property (nonatomic ,strong)UILabel *sourceLable;
@property (nonatomic ,strong)UILabel *textLable;
@property (nonatomic ,strong)UIImageView *originalImageView;


//转发微博
@property (nonatomic ,strong)UILabel *retweetedtextLable;
@property (nonatomic ,assign)CGFloat cellHeight;
@end

@implementation MaTableViewCell

+(instancetype )cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

// 注意：cell是用initWithStyle初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 原创微博
        [self setUpOriginalView];
        // 转发微博
        [self setUpRetweetedView];
        
        // 工具条
        
        
        
    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    

}
-(void)clearData{
    //原创微博
    
    self.iconView.image = nil;

    self.nameLable.text = nil;
    
    self.timeLable.text = nil;
    
    self.sourceLable.text = nil;
    
    self.textLable.text = nil;
    
    for (UIImageView *imgView in self.originalImageView.subviews) {
        [imgView removeFromSuperview];
    }
    
    //转发微博
    
    self.retweetedtextLable.text = nil;
}
-(void)setStatues:(CZStatus *)statues{
    
    [self clearData];
    
    _statues = statues;
    
    // 原创微博赋值+布局
    
    [self setOriginalContentView];
    CGFloat cellHeight = CGRectGetMaxY(self.textLable.frame);
    _cellHeight = cellHeight;
    if (self.statues.pic_urls.count) {
        _cellHeight = CGRectGetMaxY(self.originalImageView.frame);
    }
    // 转发微博
    if (self.statues.retweeted_status) {
        [self setRetweetedContentView];
        _cellHeight = CGRectGetMaxY(self.retweetedtextLable.frame);
//        if (self.statues.retweeted_status.pic_urls.count) {
//            _cellHeight = CGRectGetMaxY(self.retweetedtextLable.frame);
//        }
        
    }
    
    // 工具条
    
    
}



#pragma mark 原创微博控件
//创建控件
- (void)setUpOriginalView
{
    // 原创微博
    UIImageView *iconView = [[UIImageView alloc]init];
    _iconView = iconView;
   
    [self.contentView addSubview:iconView];
    
    UILabel *nameLable = [[UILabel alloc]init];
    _nameLable = nameLable;
    nameLable.font = CZNameFont;
    
    [self.contentView addSubview:nameLable];
    
    UILabel *timeLable = [[UILabel alloc]init];
    
    timeLable.font = CZTimeFont;
    _timeLable = timeLable;
    [self.contentView addSubview:timeLable];
    
    UILabel *sourceLable = [[UILabel alloc]init];
    
    sourceLable.font = CZSourceFont;
    _sourceLable = sourceLable;
    [self.contentView addSubview:sourceLable];
    
    UILabel *textLable = [[UILabel alloc]init];
    textLable.font = CZTextFont;
    _textLable = textLable;
    textLable.numberOfLines = 0;
    [self.contentView addSubview:textLable];
    
    
    
}

// 添加原创微博(数据添加)
-(void)setDataForView{
    //
    [self.iconView sd_setImageWithURL:self.statues.user.profile_image_url placeholderImage:[UIImage imageNamed:@"topic_placeholder"]];
    //
    self.nameLable.text = self.statues.user.name;
    //
    self.timeLable.text = self.statues.created_at;
    //
    NSString *sourceString = [self handleStringWithString:self.statues.source];
    self.sourceLable.text = sourceString;
    
    //
    
    self.textLable.text = self.statues.text;
    
    
    //原创图片
    
    [self setOriginalImage];
   
}

//去除字符串中用括号括住的位置
-(NSString *)handleStringWithString:(NSString *)str{
    
    NSMutableString * muStr = [NSMutableString stringWithString:str];
    while (1) {
        NSRange range = [muStr rangeOfString:@"<"];
        NSRange range1 = [muStr rangeOfString:@">"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }
    
    return muStr;
}

//原创微博赋值+布局
-(void)setOriginalContentView{
    
    //为控件赋值
    
    [self setDataForView];
    
    @weakify(self)
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.left.top.equalTo(self.contentView).with.offset(10);
        
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        
        make.left.equalTo(self.iconView.mas_right).with.offset(10);
        make.top.equalTo(self.iconView.mas_top);
        make.height.mas_equalTo(@15);
        
    }];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        
        make.left.equalTo(self.nameLable.mas_left);
        make.top.equalTo(self.nameLable.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@15);
        
    }];
    
    [self.sourceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        
        make.left.equalTo(self.timeLable.mas_right).with.offset(10);
        make.top.equalTo(self.timeLable.mas_top);
        make.height.mas_equalTo(self.timeLable);
     
    }];
    [self.textLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        
        make.top.equalTo(self.iconView.mas_bottom).with.offset(10);
        make.left.equalTo(self.iconView.mas_left);
        make.right.equalTo(self.constraints).width.right.offset(-10);
        
    }];
  
}

-(void)setOriginalImage{
    //创建图片视图控件
    NSArray *imgArr = [NSArray array];
    imgArr = self.statues.pic_urls;
    
    UIImageView *originalImageView = [[UIImageView alloc]init];
    originalImageView.backgroundColor = [UIColor clearColor];
    _originalImageView = originalImageView;
    
    [self.contentView addSubview:originalImageView];
    
    
    CGFloat W = ([UIScreen mainScreen].bounds.size.width-50)/3;
    CGFloat H = ([UIScreen mainScreen].bounds.size.width-50)/2;
    CGFloat imgViewHeight =0;
    CGFloat imgViewY = CGRectGetMaxY(self.textLable.frame)+10;
    
    for (int i=0; i<imgArr.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = i;
        [imageView sd_setImageWithURL:[imgArr[i] thumbnail_pic] placeholderImage:[UIImage imageNamed:@"topic_placeholder"]];
        [self.originalImageView addSubview:imageView];
        
        @weakify(self)
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            
            make.top.equalTo(self.textLable.mas_bottom).with.offset(10);
            make.left.equalTo(self.iconView.mas_left);
            make.size.mas_equalTo(CGSizeMake(W, H));
            
        }];
        imgViewHeight = CGRectGetMaxY(imageView.frame);
        
    }

    self.originalImageView.frame = CGRectMake(0, imgViewY, [UIScreen mainScreen].bounds.size.width, imgViewHeight);
    
}

#pragma mark 转发微博控件
//创建控件
-(void)setUpRetweetedView{
    
    
    UILabel *retweetedtextLable = [[UILabel alloc]init];
    retweetedtextLable.font = CZTextFont;
    _retweetedtextLable = retweetedtextLable;
    retweetedtextLable.numberOfLines = 0;
    [self.contentView addSubview:retweetedtextLable];
    
}

//转发微博赋值+布局
-(void)setRetweetedContentView{
    
    self.retweetedtextLable.text = self.statues.retweeted_status.text;
    @weakify(self)
    [self.retweetedtextLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (self.statues.pic_urls.count) {
            make.top.equalTo(self.originalImageView.mas_bottom).with.offset(10);
        }else{
            make.top.equalTo(self.textLable.mas_bottom).with.offset(10);
        }
        NSLog(@"%lu",(unsigned long)self.statues.pic_urls.count);
        make.left.equalTo(self.iconView.mas_left);
        make.right.equalTo(self.constraints).width.right.offset(-10);
        
    }];
    
}





#pragma mark 微博工具栏控件


@end
