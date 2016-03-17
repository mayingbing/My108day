//
//  MAFirstGroundViewController.m
//  简历
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MAFirstGroundViewController.h"

#import "MATableViewCell.h"
#import "MATextTableViewCell.h"
#import "MAToolBar.h"

@interface MAFirstGroundViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MAFirstGroundViewController

-(instancetype)init{
    
    if (self = [super init]) {
        
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor grayColor];

    // 添加工具条
    [self setUpToolBar];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveToolBar:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        MATableViewCell *maTableViewCell = [MATableViewCell cellWithTableView:tableView ];
        
        
        return maTableViewCell;
    }else{
        MATextTableViewCell *maTextTableViewCell = [MATextTableViewCell cellWithTableView:tableView];
        
        self.maTextTableViewCell = maTextTableViewCell;
        
        return maTextTableViewCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0){
        return 100;
    }else{
        
        return [UIScreen mainScreen].bounds.size.height-214;
    }
}

-(void)setUpToolBar
{
    MAToolBar *toolBar = [[MAToolBar alloc] init];
    
    _toolBar = toolBar;
    CGFloat toolBarW = self.view.width;
    CGFloat toolBarH = 54;
    CGFloat toolBarY = self.view.height - toolBarH;
    toolBar.frame = CGRectMake(0, toolBarY, toolBarW, toolBarH);
    toolBar.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:toolBar];
    
    
}
-(void)moveToolBar:(NSNotification *)note{
    // 获取键盘弹出的动画时间
    CGFloat durtion = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 获取键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) { // 没有弹出键盘
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform =  CGAffineTransformIdentity;
            _tableView.transform =CGAffineTransformIdentity;
        }];
    }else{ // 弹出键盘
        // 工具条往上移动258
        [UIView animateWithDuration:durtion animations:^{
            
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
            _tableView.transform =CGAffineTransformMakeTranslation(0, -120);

        }];
    }
}


@end
