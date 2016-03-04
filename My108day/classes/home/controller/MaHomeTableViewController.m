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

@interface MaHomeTableViewController ()<UITableViewDataSource>

@property(nonatomic ,strong)NSMutableArray *dataArr;

@end

@implementation MaHomeTableViewController

static NSString *ID = @"cell";

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CZTitleButton *btn = [CZTitleButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"北京" forState:UIControlStateNormal];
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
    
    if (self.dataArr.count) {
        long long maxId = [[[self.dataArr firstObject] idstr] longLongValue];
        parameters[@"since_id"] = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    [data GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(NSArray *objArr) {
        // httpTool请求成功的时候调用，把代码保存起来
        // 结束上拉刷新
        [self.tableView headerEndRefreshing];
        
        NSIndexSet *index = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, objArr.count)];
        [self.dataArr insertObjects:objArr atIndexes:index];
        
        // 刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        // 结束上拉刷新
        [self.tableView headerEndRefreshing];
    }];
   
}

//加载更多旧的数据
-(void)loadMoreData{
    
    MaDataTool *data = [[MaDataTool alloc]init];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    MaAccount *account = [MaAccountTool account];
    parameters[@"access_token"] = account.access_token;
    if (self.dataArr.count) {
        long long minId = [[[self.dataArr lastObject] idstr] longLongValue] - 1;
        parameters[@"max_id"] = [NSString stringWithFormat:@"%lld",minId];
    }

    
    [data GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(NSArray *objArr) {
        // httpTool请求成功的时候调用，把代码保存起来
        // 结束刷新
        [self.tableView footerEndRefreshing];
        
        [self.dataArr addObjectsFromArray:objArr];
        
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

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    CZStatus *statues = self.dataArr[indexPath.row];
    
    cell.textLabel.text = statues.user.name;
    [cell.imageView sd_setImageWithURL:statues.user.profile_image_url placeholderImage:[UIImage imageNamed:@"topic_placeholder"]];
    cell.detailTextLabel.text = statues.text;
    
    return cell;
}



@end
