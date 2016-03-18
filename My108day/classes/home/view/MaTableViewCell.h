//
//  MaTableViewCell.h
//  My108day
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZStatus;
@interface MaTableViewCell : UITableViewCell

@property (nonatomic ,strong)CZStatus *statues;

+(MaTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
