//
//  MATextTableViewCell.h
//  简历
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MATextView;

@interface MATextTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) MATextView *textView;

@end
