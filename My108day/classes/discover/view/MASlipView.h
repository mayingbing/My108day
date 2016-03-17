//
//  MASlipView.h
//  简历
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MASlipViewDelegate <NSObject>

@optional

-(void)MASlipViewTouchWithBtn:(UIButton *)btn;

@end



@interface MASlipView : UIView

@property(nonatomic ,weak)id<MASlipViewDelegate> delegate;

-(instancetype)initWithViewController:(UIViewController *)vc;
-(void)show;
@end
