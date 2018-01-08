//
//  DCShareToViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/11.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCShareToViewController.h"
#import "DCShareItem.h"
// Views
#import "DCShareItemCell.h"
// Vendors
#import <MJExtension.h>
// Categories
#import "UIViewController+XWTransition.h"
// Others

@interface DCShareToViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 分享 */
@property (strong , nonatomic)NSMutableArray<DCShareItem*> *shareItem;
@end

static NSString *const DCShareItemCellID = @"DCShareItemCell";

@implementation DCShareToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpShareAlterView];
    
    [self setUpBase];
    
    [self setUpTopBottomView];
}

- (void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _shareItem = [DCShareItem mj_objectArrayWithFilename:@"shareTerrace.plist"];
}

- (void)setUpTopBottomView
{
    UILabel *shareLabel = [UILabel new];
    shareLabel.text = @"分享到";
    shareLabel.font = PFR18Font;
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.frame = CGRectMake(0, DCMargin, SCREEN_WIDTH, 35);
    [self.view addSubview:shareLabel];
    
    
    UIView *line = [UIView new];
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    line.frame = CGRectMake(DCMargin, shareLabel.bottom + DCMargin, SCREEN_WIDTH - 2*DCMargin, 1);
    [self.view addSubview:line];
    
    self.collectionView.frame = CGRectMake(0, line.bottom + DCMargin, SCREEN_WIDTH, 160);
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:0];
    cancelButton.adjustsImageWhenHighlighted = NO;
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"share_cancle"] forState:0];
    [cancelButton setTitleColor:[UIColor blackColor] forState:0];
    cancelButton.frame = CGRectMake(DCMargin, self.collectionView.bottom + DCMargin * 2, SCREEN_WIDTH - 2 *DCMargin, 35);
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _shareItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCShareItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCShareItemCellID forIndexPath:indexPath];
    cell.shareItem = _shareItem[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第%zd分享平台",indexPath.row);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 弹出弹框
- (void)setUpShareAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    WEAK_SELF
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } edgeSpacing:0];
}

#pragma mark - 取消点击
- (void)cancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.width / 4, 80);
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //注册
        [_collectionView registerClass:[DCShareItemCell class] forCellWithReuseIdentifier:DCShareItemCellID];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
