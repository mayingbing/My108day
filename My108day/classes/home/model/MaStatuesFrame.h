//
//  MaStatuesFrame.h
//  My108day
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CZStatus;

@interface MaStatuesFrame : NSObject

@property(nonatomic ,strong)CZStatus *statues;

@property(nonatomic ,assign)CGFloat originalViewHeight;

@property(nonatomic ,assign)CGFloat retweetedViewHeight;

@property(nonatomic ,assign)CGFloat toolBarViewHeight;

@property(nonatomic ,assign)CGFloat cellHeight;

@end
