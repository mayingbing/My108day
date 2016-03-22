//
//  MaHomeTableViewController.m
//  My108day
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaHomeTableViewController.h"
#import "MaChooseCityTableViewController.h"
#import "CZTitleButton.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MaAccountTool.h"
#import "MaAccount.h"
#import "CZStatus.h"
#import "CZUser.h"
#import "CZPhoto.h"
#import "UIImageView+WebCache.h"
#import "MaHttpTool.h"
#import "MaDataTool.h"
#import "MaHomeTableViewCell.h"
#import "MaStatuesFrame.h"



@interface MaHomeTableViewController ()<UITableViewDataSource>

@property (nonatomic ,strong) NSMutableArray *statuesFArr;
//@property (nonatomic ,assign)CGFloat cellHeight;
@end

@implementation MaHomeTableViewController

static NSString *ID = @"cell";

-(NSMutableArray *)statuesFArr{
    if (_statuesFArr == nil) {
        _statuesFArr = [NSMutableArray array];
    }
    return _statuesFArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    CZTitleButton *btn = [CZTitleButton buttonWithType:UIButtonTypeCustom];
   
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = left;
    
    [btn setTitle:@"个人助手" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"home_city_location_img@2x"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(chooseCity) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    
    [self.tableView headerBeginRefreshing];
    

    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}



//加载更多新数据

-(void)loadNewData
{
    
    MaDataTool *data = [[MaDataTool alloc]init];
    id sinceID = nil;
    if (self.statuesFArr.count) {
        
        sinceID = [[self.statuesFArr[0] statues] idstr];
    }
    
    [data GETNewData:@"https://api.weibo.com/2/statuses/friends_timeline.json"  WithID:sinceID success:^(NSArray *statuesFArr) {
        // httpTool请求成功的时候调用，把代码保存起来
        
        NSIndexSet *index = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuesFArr.count)];
        
        
        [self.statuesFArr insertObjects:statuesFArr atIndexes:index];

        
        
        // 刷新表格
        [self.tableView reloadData];
        // 结束上拉刷新
        [self.tableView headerEndRefreshing];

        
    } failure:^(NSArray *statuesFArr) {
        
        if (!self.statuesFArr.count){
            
            [self.statuesFArr addObjectsFromArray:statuesFArr];
            
            // 刷新表格
            [self.tableView reloadData];
        }
        // 结束上拉刷新
        [self.tableView headerEndRefreshing];

    }];
    
}

 //加载更多旧的数据
-(void)loadMoreData
{
    
    MaDataTool *data = [[MaDataTool alloc]init];
    
    id maxID = nil;
    if (self.statuesFArr.count) {
        
        maxID= @([[[[self.statuesFArr lastObject] statues] idstr] longLongValue]-1);
        
    }
    
    [data GETMoreData:@"https://api.weibo.com/2/statuses/friends_timeline.json" WithID:maxID success:^(NSArray *statuesArr) {
        // httpTool请求成功的时候调用，把代码保存起来
        
        [self.statuesFArr addObjectsFromArray:statuesArr];
        
        // 刷新表格
        [self.tableView reloadData];
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        
    } failure:^(NSMutableArray *statuesFArr) {
        if (!self.statuesFArr.count) {
            
            [self.statuesFArr addObjectsFromArray:statuesFArr];
            
            // 刷新表格
            [self.tableView reloadData];
        }
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];

    }];
    }

-(void)chooseCity{
    
    MaChooseCityTableViewController *chooseVc = [[MaChooseCityTableViewController alloc]init];
    [self.navigationController pushViewController:chooseVc animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuesFArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MaHomeTableViewCell *cell = [MaHomeTableViewCell cellWithTableView:tableView];
    [cell layoutSubviews];

    MaStatuesFrame *statuesF = self.statuesFArr[indexPath.row];
    
    cell.statuesF = statuesF;
    
    [cell layoutIfNeeded];

    return cell;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaStatuesFrame *statuesF = self.statuesFArr[indexPath.row];
    

    return statuesF.cellHeight;
}


@end
