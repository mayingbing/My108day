//
//  MaCollectionViewCell.h
//  My108day
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaCollectionViewCell : UICollectionViewCell

@property(nonatomic ,strong)UIImage *image;

// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end
