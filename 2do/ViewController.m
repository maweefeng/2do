//
//  ViewController.m
//  2do
//
//  Created by Weefeng Ma on 2017/11/23.
//  Copyright © 2017年 maweefeng. All rights reserved.
//

#import "ViewController.h"
#import "PresentCollectV.h"
#import "UIColor+randomColor.h"
#import "BgView.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property(assign,nonatomic)CGRect frame;
@property(assign,nonatomic)CGRect newframe;
@property(assign,nonatomic)NSInteger selectedTag;
@property (weak, nonatomic) IBOutlet BgView *bgView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self initializeCollectionView];
    
}
#pragma mark 初始化collectionView
-(void)initializeCollectionView{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.flowLayout.itemSize = CGSizeMake(self.view.frame.size.width-70, 300-10);
  

    self.collectionView =  [[UICollectionView alloc] initWithFrame:CGRectMake(30, 300, self.view.frame.size.width - 60, 300) collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.clipsToBounds = NO;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    //最开始会有个偏移量 这样的话可以使其减少到0
    self.collectionView.contentOffset = CGPointMake(0, 0);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[PresentCollectV class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
}
#pragma mark CollectionView方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PresentCollectV *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    __weak typeof(self)weakself = self;
      __weak typeof(cell)weakCell = cell;
    [cell setUpBlock:^{
        [UIView animateWithDuration:1.5 animations:^{
             weakCell.frame = weakself.newframe;
        } completion:^(BOOL finished) {
            [weakCell removeFromSuperview];
             weakCell.frame = weakself.frame;
            [weakself.collectionView addSubview:weakCell];
        }];
    }];
    cell.backgroundColor = [UIColor randomColor];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedTag = indexPath.item;
    NSLog(@"这是第%lu个item",indexPath.item);
//    collectionView.contentOffset = CGPointMake((indexPath.item)*(self.view.frame.size.width-60)+(indexPath.item+1)*15+(self.view.frame.size.width-60)*0.5 - self.view.frame.size.width*0.5, 0);
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexpath=%ld \n selectindex = %ld",(long)indexPath.item,(long)self.selectedTag);
    PresentCollectV * cell = (PresentCollectV *)[collectionView cellForItemAtIndexPath:indexPath];
    self.frame = cell.frame;
    CGRect newRect =  [collectionView convertRect:cell.frame toView:self.view];
    cell.frame = newRect;
    self.newframe = newRect;

    [UIView animateWithDuration:1 animations:^{
        [[[[UIApplication sharedApplication] windows] lastObject] addSubview:cell];
        // 动画属性。不要在view变形之后使用frame
        // 否则会导致其不能正确的映射出view的真实位置。用bounds + center 代替
        //cell.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        cell.center = cell.superview.center;
        cell.bounds = cell.superview.bounds;
        cell.cancleBtn.frame = CGRectMake(ScreenW-50, 20, 30, 30);

    }];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark scrollView代理方法

//停止拖拽时的代理
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
  
    
//    [self contentViewScrollAnimation];
    
//    if (curIndex == self.rollDataArr.count + 1) {
//
//        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
//    }else if (curIndex == 0){
//
//        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * self.rollDataArr.count, 0);
//    }
//
   
    
    /*
    //    如果是内容页的横向滑动
    if (scrollView == self.collectionView)
    {
        NSLog(@"slowing?? %@",decelerate ? @"YES" : @"NO");
        CGFloat scrollX = scrollView.contentOffset.x;
        //        如果带有惯性（快速滑动），则内容页必然进行对应的移动
        if (decelerate)
        {
           if  (scrollView.contentOffset.x < (self.selectedTag +1)* 15 + (ScreenW -60)*(self.selectedTag+0.5)-0.8*ScreenW)
            {
               
               
                self.selectedTag -= 1;
            }
        }
        //如果无惯性（慢速拖拽），此时需要满足拖动的范围才会进行移动
        else
        {
            if (scrollX >=(self.selectedTag +1)* 15 + (ScreenW -60)*(self.selectedTag+0.5)-0.5*ScreenW)
            {
//                self.selectedTag = 1;
            }
            else if (scrollX <= (self.selectedTag +1)* 15 + (ScreenW -60)*(self.selectedTag+0.5)-0.5*ScreenW){
                self.selectedTag -=1;
            }
        }
        [self contentViewScrollAnimation];
    }*/
}
//内容页进行移动的封装
- (void)contentViewScrollAnimation
{
    //根据此时选中的按钮计算出contentView的偏移量
    CGFloat offsetX = (self.selectedTag +1)* 15 + (ScreenW -60)*(self.selectedTag+0.5)-0.5*ScreenW;
    CGPoint scrPoint = self.collectionView.contentOffset;
    scrPoint.x = offsetX;
    //默认滚动速度有点慢 加速了下
    [UIView animateWithDuration:0.3 animations:^{
        [self.collectionView setContentOffset:scrPoint];
    }];
}

//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//    int a;
//    double c = scrollView.contentOffset.x/ScreenW;
//    int b = (int)round(c);
//    if (c==0) {
//        a = 0;
//    }else{
//   
//            a = b +1;
//       
//    }
//    NSLog(@"------%f   %d",scrollView.contentOffset,a);
//    [scrollView setContentOffset:CGPointMake((a)*(self.view.frame.size.width-60+15)+15+(self.view.frame.size.width-60)*0.5 - self.view.frame.size.width*0.5, 0) animated:YES];
//}
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//
//
////    NSLog(@"------%f",scrollView.contentOffset);
//
//
//}
////动画结束的时候调用
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    int a;
//    double c = scrollView.contentOffset.x/ScreenW;
//    int b = (int)round(c);
//    if (c==0) {
//        a = 0;
//    }else{
//        
//        a = b +1;
//        
//    }
//    NSLog(@"------%f   %d",scrollView.contentOffset,a);
//    [scrollView setContentOffset:CGPointMake((a)*(self.view.frame.size.width-60+15)+15+(self.view.frame.size.width-60)*0.5 - self.view.frame.size.width*0.5, 0) animated:YES];
//
//}
//
//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
///*
//    NSLog(@"%f",scrollView.contentOffset);
//    int a = (scrollView.contentOffset.x + self.view.frame.size.width/2-(self.view.frame.size.width-60)*0.5-15)/(self.view.frame.size.width-40);
//    NSLog(@"------%f   %d",scrollView.contentOffset,a);
//    [scrollView setContentOffset:CGPointMake((a)*(self.view.frame.size.width-60+15)+15+(self.view.frame.size.width-60)*0.5 - self.view.frame.size.width*0.5, 0) animated:YES];*/
//    
//    int a;
//    double c = scrollView.contentOffset.x/ScreenW;
//    int b = (int)round(c);
//    if (c==0) {
//        a = 0;
//    }else{
//        
//        a = b +1;
//        
//    }
//    NSLog(@"------%f %d",scrollView.contentOffset,a);
//    [scrollView setContentOffset:CGPointMake((a)*(self.view.frame.size.width-60+15)+15+(self.view.frame.size.width-60)*0.5 - self.view.frame.size.width*0.5, 0) animated:YES];
//}
@end
