//
//  MaCollectionViewCell.m
//  My108day
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaCollectionViewCell.h"
#import "MaTabBarController.h"

@interface MaCollectionViewCell ()

@property (nonatomic ,weak)UIImageView *imgView;
@property (nonatomic ,weak)UIButton *btn;

@end

@implementation MaCollectionViewCell

-(UIButton *)btn{
    if (_btn == nil) {
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn = btn;
        [_btn setBackgroundImage:[UIImage imageNamed:@"personal_login_btn_bg"] forState:UIControlStateNormal];
        [_btn setTitle:@"开始体验" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn setFrame:CGRectMake((self.bounds.size.width-100)*0.5,self.bounds.size.height*0.8, 100, 30)];
        [self.contentView addSubview:_btn];
    }
    return _btn;
}

-(UIImageView *)imgView{
    
    if (_imgView == nil) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    self.imgView.image = image;
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.imgView.frame = self.bounds;
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count{
    
    if (indexPath.row == count -1) {// 最后一页,显示分享和开始按钮
        self.btn.hidden = NO;
          [self.btn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
        
        
    }else{// 非最后一页，隐藏分享和开始按钮
        self.btn.hidden = YES;
    }
    
}
-(void)enter{
    
    MaTabBarController *tabBarVc = [[MaTabBarController alloc]init];
    self.window.rootViewController = tabBarVc;

    
    
    
}

@end
