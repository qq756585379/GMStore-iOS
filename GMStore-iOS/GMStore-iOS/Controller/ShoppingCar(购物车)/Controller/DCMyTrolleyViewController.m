//
//  DCMyTrolleyViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/6.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#define collectionViewW 100
#define collectionViewH 150
#define recommendReusableViewH 40

#import "DCMyTrolleyViewController.h"
#import "GMRecommendItem.h"
#import "DCEmptyCartView.h"
#import "DCRecommendCell.h"
#import "DCRecommendReusableView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface DCMyTrolleyViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 推荐商品数据 */
@property (strong , nonatomic)NSMutableArray<GMRecommendItem *> *recommendItem;
/* 通知 */
@property (weak ,nonatomic) id dcObserve;
@end

static NSString *const DCRecommendCellID = @"DCRecommendCell";

@implementation DCMyTrolleyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpRecommendData];
    
    [self setUpEmptyCartView];
    
    [self setUpRecommendReusableView];
}

- (void)setUpBase
{
    self.view.backgroundColor = YJBGColor;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat colBottom = (self.isTabBar == NO) ? TAB_BAR_HEIGHT : 0;
    self.collectionView.frame = CGRectMake(0, SCREEN_HEIGHT - collectionViewH - colBottom, SCREEN_WIDTH, collectionViewH);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark - 推荐商品数据
- (void)setUpRecommendData
{
    _recommendItem = [GMRecommendItem mj_objectArrayWithFilename:@"RecommendShop.plist"];
}

#pragma mark - 推荐提示View
- (void)setUpRecommendReusableView
{
    DCRecommendReusableView *recommendReusableView = [[DCRecommendReusableView alloc]init];
    recommendReusableView.backgroundColor = self.collectionView.backgroundColor;
    [self.view addSubview:recommendReusableView];
    recommendReusableView.frame = CGRectMake(0, _collectionView.y - recommendReusableViewH, SCREEN_WIDTH, recommendReusableViewH);
}

#pragma mark - 初始化空购物车View
- (void)setUpEmptyCartView
{
    DCEmptyCartView *emptyCartView = [[DCEmptyCartView alloc] init];
    [self.view addSubview:emptyCartView];
    
    emptyCartView.frame = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT - (collectionViewH + recommendReusableViewH));
    emptyCartView.buyingClickBlock = ^{
        NSLog(@"点击了立即抢购");
    };
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _recommendItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCRecommendCellID forIndexPath:indexPath];
    cell.recommendItem = _recommendItem[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了推荐商品");
}

#pragma mark - 消失
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_dcObserve];
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(collectionViewW, collectionViewH);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        
        //注册Cell
        [_collectionView registerClass:[DCRecommendCell class] forCellWithReuseIdentifier:DCRecommendCellID];
    }
    return _collectionView;
}

- (NSMutableArray<GMRecommendItem *> *)recommendItem
{
    if (!_recommendItem) {
        _recommendItem = [NSMutableArray array];
    }
    return _recommendItem;
}

@end
