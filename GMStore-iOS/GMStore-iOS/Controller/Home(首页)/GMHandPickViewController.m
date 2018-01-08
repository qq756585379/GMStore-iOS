//
//  GMHandPickViewController.m
//  GMStore-iOS
//
//  Created by 杨俊 on 2017/12/28.
//  Copyright © 2017年 上海创米科技有限公司. All rights reserved.
//

#import "GMHandPickViewController.h"
#import "DCCommodityViewController.h"
#import "GMHomeRefreshGifHeader.h"
#import "GMExceedApplianceCell.h"
#import "GMGoodsCountDownCell.h"
#import "GMGoodsHandheldCell.h"
#import "DCSlideshowHeadView.h"
#import "DCCountDownHeadView.h"
#import "GMGoodsYouLikeCell.h"
#import "DCScrollAdFootView.h"
#import "GMHomeTopToolView.h"
#import "DCTopLineFootView.h"
#import "DCYouLikeHeadView.h"
#import "GMNewWelfareCell.h"
#import "GMGoodsGridCell.h"
#import "GMRecommendItem.h"
#import "DCOverFootView.h"
#import "GMGridItem.h"

@interface GMHandPickViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic,  strong)YJCollectionView *collectionView;
/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<GMGridItem *> *gridItem;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
/* 推荐商品属性 */
@property (strong , nonatomic)NSMutableArray<GMRecommendItem *> *youLikeItem;
/* 顶部 */
@property (nonatomic,  strong)GMHomeTopToolView *topToolView;
@end

@implementation GMHandPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpNavTopView];
    
    [self setUpGoodsData];
    
    [self setUpScrollToTopView];
    
    [self getNetwork];
}

- (void)setUpBase
{
    self.collectionView.backgroundColor = self.view.backgroundColor;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 滚回顶部
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(SCREEN_WIDTH - 50, SCREEN_HEIGHT - 110 - SAFE_AREA_BOTTOM, 40, 40);
}

#pragma mark - 加载数据
- (void)setUpGoodsData
{
    _gridItem = [GMGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    _youLikeItem = [GMRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
}

- (void)getNetwork
{
//    if ([[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { //网络
//        [CDDTopTip showTopTipWithMessage:@"您现在暂无可用网络"];
//    }
}

#pragma mark - 刷新
- (void)setUpRecData
{
    WEAK_SELF
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
        [generator prepare];
        [generator impactOccurred];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
        [weakSelf.collectionView.mj_header endRefreshing];
    });
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    _topToolView = [[GMHomeTopToolView alloc] initWithFrame:CGRectMake(0, SAFE_AREA_TOP, SCREEN_WIDTH, 64)];
    WEAK_SELF
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了首页扫一扫");
    };
    _topToolView.rightItemClickBlock = ^{
        NSLog(@"点击了首页分类");
        DCCommodityViewController *dcComVc = [DCCommodityViewController new];
        [weakSelf.navigationController pushViewController:dcComVc animated:YES];
    };
    _topToolView.rightRItemClickBlock = ^{
        NSLog(@"点击了首页购物车");
//        DCMyTrolleyViewController *shopCarVc = [DCMyTrolleyViewController new];
//        shopCarVc.isTabBar = YES;
//        shopCarVc.title = @"购物车";
//        [weakSelf.navigationController pushViewController:shopCarVc animated:YES];
    };
    _topToolView.searchButtonClickBlock = ^{
        NSLog(@"点击了首页搜索");
    };
    _topToolView.voiceButtonClickBlock = ^{
        NSLog(@"点击了首页语音");
    };
    [self.view addSubview:_topToolView];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _backTopButton.hidden = (scrollView.contentOffset.y > SCREEN_HEIGHT) ? NO : YES;//判断回到顶部按钮是否隐藏
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > NAV_BAR_HEIGHT) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter] postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

#pragma mark - 消息
- (void)messageItemClick{
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 6;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //10属性
        return _gridItem.count;
    }
    if (section == 1 || section == 2 || section == 3) { //广告福利  倒计时  掌上专享
        return 1;
    }
    if (section == 4) { //推荐
        return GoodsHandheldImagesArray.count;
    }
    if (section == 5) { //猜你喜欢
        return _youLikeItem.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {//10
        GMGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GMGoodsGridCell cellReuseIdentifier] forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if (indexPath.section == 1) {//广告福利
        GMNewWelfareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GMNewWelfareCell cellReuseIdentifier] forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2) {//倒计时
        GMGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GMGoodsCountDownCell cellReuseIdentifier] forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 3) {//掌上专享
        GMExceedApplianceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GMExceedApplianceCell cellReuseIdentifier] forIndexPath:indexPath];
        cell.goodExceedArray = GoodsRecommendArray;
        return cell;
    } else if (indexPath.section == 4) {//推荐  优质家电
        GMGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GMGoodsHandheldCell cellReuseIdentifier] forIndexPath:indexPath];
        NSArray *images = GoodsHandheldImagesArray;
        cell.handheldImage = images[indexPath.row];
        return cell;
    } else {//猜你喜欢
        GMGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GMGoodsYouLikeCell cellReuseIdentifier] forIndexPath:indexPath];
        cell.lookSameBlock = ^{
            NSLog(@"点击了第%zd商品的找相似",indexPath.row);
        };
        cell.youLikeItem = _youLikeItem[indexPath.row];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            DCSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[DCSlideshowHeadView reuseIdentifier] forIndexPath:indexPath];
            headerView.imageGroupArray = GoodsHomeSilderImagesArray;
            return headerView;
        }else if (indexPath.section == 2){
            DCCountDownHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[DCCountDownHeadView reuseIdentifier] forIndexPath:indexPath];
            return headerView;
        }else if (indexPath.section == 4){
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[DCYouLikeHeadView reuseIdentifier] forIndexPath:indexPath];
            [headerView.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"http://gfs7.gomein.net.cn/T1WudvBm_T1RCvBVdK.png"]];
            return headerView;
        }else if (indexPath.section == 5){
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[DCYouLikeHeadView reuseIdentifier] forIndexPath:indexPath];
            [headerView.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"http://gfs5.gomein.net.cn/T16LLvByZj1RCvBVdK.png"]];
            return headerView;
        }
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            DCTopLineFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[DCTopLineFootView reuseIdentifier] forIndexPath:indexPath];
            return footview;
        }else if (indexPath.section == 3){
            DCScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[DCScrollAdFootView reuseIdentifier] forIndexPath:indexPath];
            return footerView;
        }else if (indexPath.section == 5) {
            DCOverFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                          withReuseIdentifier:[DCOverFootView reuseIdentifier] forIndexPath:indexPath];
            return footview;
        }
    }
    
    return nil;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//9宫格组
        return CGSizeMake(SCREEN_WIDTH/5 , SCREEN_WIDTH/5 + DCMargin);
    }
    if (indexPath.section == 1) {//广告
        return CGSizeMake(SCREEN_WIDTH, 180);
    }
    if (indexPath.section == 2) {//计时
        return CGSizeMake(SCREEN_WIDTH, 150);
    }
    if (indexPath.section == 3) {//掌上
        return CGSizeMake(SCREEN_WIDTH,SCREEN_WIDTH * 0.35 + 120);
    }
    if (indexPath.section == 4) {//推荐组
        return [self layoutAttributesForItemAtIndexPath:indexPath].size;
    }
    if (indexPath.section == 5) {//猜你喜欢
        return CGSizeMake((SCREEN_WIDTH - 4)/2, (SCREEN_WIDTH - 4)/2 + 40);
    }
    return CGSizeZero;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 230); //图片滚动的宽高
    }
    if (section == 2 || section == 4 || section == 5) {//猜你喜欢的宽高
        return CGSizeMake(SCREEN_WIDTH, 40);  //推荐适合的宽高
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 180);  //Top头条的宽高
    }
    if (section == 3) {
        return CGSizeMake(SCREEN_WIDTH, 80); // 滚动广告
    }
    if (section == 5) {
        return CGSizeMake(SCREEN_WIDTH, 40); // 结束
    }
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            layoutAttributes.size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * 0.38);
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            layoutAttributes.size = CGSizeMake(SCREEN_WIDTH * 0.5, SCREEN_WIDTH * 0.24);
        }else{
            layoutAttributes.size = CGSizeMake(SCREEN_WIDTH * 0.25, SCREEN_WIDTH * 0.35);
        }
    }
    return layoutAttributes;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {//10
//        GMGoodsSetViewController *goodSetVc = [[GMGoodsSetViewController alloc] init];
//        goodSetVc.goodPlisName = @"ClasiftyGoods.plist";
//        [self.navigationController pushViewController:goodSetVc animated:YES];
//        NSLog(@"点击了10个属性第%zd",indexPath.row);
//    }else if (indexPath.section == 5){
//        NSLog(@"点击了推荐的第%zd个商品",indexPath.row);
//        DCGoodDetailViewController *dcVc = [[DCGoodDetailViewController alloc] init];
//        dcVc.goodTitle = _youLikeItem[indexPath.row].main_title;
//        dcVc.goodPrice = _youLikeItem[indexPath.row].price;
//        dcVc.goodSubtitle = _youLikeItem[indexPath.row].goods_title;
//        dcVc.shufflingArray = _youLikeItem[indexPath.row].images;
//        dcVc.goodImageView = _youLikeItem[indexPath.row].image_url;
//
//        [self.navigationController pushViewController:dcVc animated:YES];
//    }
}

#pragma mark - LazyLoad
- (YJCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[YJCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, SAFE_AREA_TOP, SCREEN_WIDTH, SCREEN_HEIGHT - TAB_BAR_HEIGHT - SAFE_AREA_TOP);
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[GMGoodsCountDownCell class] forCellWithReuseIdentifier:[GMGoodsCountDownCell cellReuseIdentifier]];
        [_collectionView registerClass:[GMGoodsHandheldCell class] forCellWithReuseIdentifier:[GMGoodsHandheldCell cellReuseIdentifier]];
        [_collectionView registerClass:[GMGoodsYouLikeCell class] forCellWithReuseIdentifier:[GMGoodsYouLikeCell cellReuseIdentifier]];
        [_collectionView registerClass:[GMGoodsGridCell class] forCellWithReuseIdentifier:[GMGoodsGridCell cellReuseIdentifier]];
        [_collectionView registerClass:[GMExceedApplianceCell class] forCellWithReuseIdentifier:[GMExceedApplianceCell cellReuseIdentifier]];
        [_collectionView registerClass:[GMNewWelfareCell class] forCellWithReuseIdentifier:[GMNewWelfareCell cellReuseIdentifier]];

        [_collectionView registerClass:[DCTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:[DCTopLineFootView reuseIdentifier]];
        [_collectionView registerClass:[DCOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:[DCOverFootView reuseIdentifier]];
        [_collectionView registerClass:[DCScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:[DCScrollAdFootView reuseIdentifier]];

        [_collectionView registerClass:[DCYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:[DCYouLikeHeadView reuseIdentifier]];
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:[DCSlideshowHeadView reuseIdentifier]];
        [_collectionView registerClass:[DCCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:[DCCountDownHeadView reuseIdentifier]];
        
        _collectionView.mj_header = [GMHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
