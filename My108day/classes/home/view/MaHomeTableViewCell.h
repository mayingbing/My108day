//
//  MaHomeTableViewCell.h
//  My108day
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaStatuesFrame;

@interface MaHomeTableViewCell : UITableViewCell

@property (nonatomic ,strong)MaStatuesFrame *statuesF;

+(instancetype)cellWithTableView:tableView;



@end
