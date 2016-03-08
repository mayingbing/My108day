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
#import "MaTableViewCell.h"
#import "MaStatuesFrame.h"

@interface MaHomeTableViewController ()<UITableViewDataSource>

@property(nonatomic ,strong)NSMutableArray *statuesFrameDataArr;

@end

@implementation MaHomeTableViewController

static NSString *ID = @"cell";

-(NSMutableArray *)statuesFrameDataArr{
    if (_statuesFrameDataArr == nil) {
        _statuesFrameDataArr = [NSMutableArray array];
    }
    return _statuesFrameDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CZTitleButton *btn = [CZTitleButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"个人助手" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"home_city_location_img@2x"] forState:UIControlStateNormal];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = left;
    [btn addTarget:self action:@selector(chooseCity) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    
    [self.tableView headerBeginRefreshing];
    self.tableView.dataSource = self;
    
}



//加载更多新数据

-(void)loadNewData{
    
    MaDataTool *data = [[MaDataTool alloc]init];
    
    MaAccount *account = [MaAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    id sinceID = nil;
    if (self.statuesFrameDataArr.count) {
        
        sinceID = [[self.statuesFrameDataArr firstObject] status].idstr;
    }
    
    [data GET:@"https://api.weibo.com/2/statuses/friends_timeline.json"  WithID:(id)sinceID  parameters:parameters success:^(NSArray *statuesFArr) {
        // httpTool请求成功的时候调用，把代码保存起来
        // 结束上拉刷新
        [self.tableView headerEndRefreshing];
        
        
//        // 展示最新的微博数
//        [self showNewStatusCount:statuesFArr.count];
        
        NSIndexSet *index = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuesFArr.count)];
        [self.statuesFrameDataArr insertObjects:statuesFArr atIndexes:index];
        
        // 刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        // 结束上拉刷新
        [self.tableView headerEndRefreshing];
    }];
   
}

-(void)showNewStatusCount:(int)count{
    
    
    
    
}

//加载更多旧的数据
-(void)loadMoreData{
    
    MaDataTool *data = [[MaDataTool alloc]init];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    MaAccount *account = [MaAccountTool account];
    parameters[@"access_token"] = account.access_token;
    id maxID = nil;
    if (self.statuesFrameDataArr.count) {
        
        maxID= @([[[self.statuesFrameDataArr lastObject] status].idstr longLongValue]-1);
        
    }

    [data GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" WithID:maxID parameters:parameters success:^(NSArray *objArr) {
        // httpTool请求成功的时候调用，把代码保存起来
        // 结束刷新
        [self.tableView footerEndRefreshing];
        
  
        [self.statuesFrameDataArr addObjectsFromArray:objArr];
        
        // 刷新表格
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
        // 结束刷新
        [self.tableView footerEndRefreshing];
    }];
   
    
}



-(void)chooseCity{
    
    MaChooseCityTableViewController *chooseVc = [[MaChooseCityTableViewController alloc]init];
    [self.navigationController pushViewController:chooseVc animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuesFrameDataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MaTableViewCell *cell = [MaTableViewCell cellWithTableView:tableView];
    

    MaStatuesFrame *statuesF = self.statuesFrameDataArr[indexPath.row];
    
    
    cell.statusF = statuesF;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaStatuesFrame *statusF = self.statuesFrameDataArr[indexPath.row];
    return statusF.cellHeight;
    
}


@end
