//
//  MAFirstGroundViewController.h
//  简历
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MATextTableViewCell;
@class MAToolBar;
@interface MAFirstGroundViewController : UIViewController

@property (nonatomic ,strong)MAToolBar *toolBar;
@property (nonatomic ,strong)MATextTableViewCell *maTextTableViewCell;
@property(nonatomic ,strong)UITableView *tableView;
@end
