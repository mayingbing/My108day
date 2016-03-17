//
//  MAOneViewController.m
//  简历
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MASinaViewController.h"
#import "MATextTableViewCell.h"
#import "MATextView.h"
#import "MAToolBar.h"

#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"sina.data"]

@interface MASinaViewController ()<UITableViewDelegate>

@end

@implementation MASinaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"sina 微博";
    
    [self.toolBar.btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.maTextTableViewCell.textView.titleLable.text = self.navigationItem.title;
    self.maTextTableViewCell.textView.textLable.text= [NSKeyedUnarchiver unarchiveObjectWithFile:CZAccountFileName];
}

-(void)save{
    
    NSString *Newcontent = self.toolBar.textView.text;
    
    NSString *currentText = self.maTextTableViewCell.textView.textLable.text;
    
    NSString *saveText = [NSString stringWithFormat:@"%@%@",currentText,Newcontent];
    
    
    [NSKeyedArchiver archiveRootObject:saveText toFile:CZAccountFileName];
    
    [self.toolBar.textView resignFirstResponder];
    [self.maTextTableViewCell.textView.textLable resignFirstResponder];
    
    self.toolBar.textView.text = nil;
    
    [self.tableView reloadData];
}


@end
