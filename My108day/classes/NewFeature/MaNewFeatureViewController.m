//
//  MaNewFeatureViewController.m
//  My108day
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MaNewFeatureViewController.h"
#import "MaCollectionViewCell.h"

@interface MaNewFeatureViewController ()
@property(nonatomic ,strong)UIPageControl *control;
@end

@implementation MaNewFeatureViewController

static NSString*ID = @"cell";

-(instancetype)init{
    
        
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing =0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[MaCollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    UIPageControl *control = [[UIPageControl alloc]init];
    _control = control;
    control.numberOfPages = 3;
    control.pageIndicatorTintColor = [UIColor yellowColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    control.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height-50);
    [self.view addSubview:control];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 设置页数
    int page = scrollView.contentOffset.x /scrollView.bounds.size.width;
    _control.currentPage = page;
      
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    NSString *imageName = [NSString stringWithFormat:@"LaunchImage-%ld-667h@2x.jpg",(long)indexPath.row+1];
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:3];
    
    return cell;
    
}

@end
