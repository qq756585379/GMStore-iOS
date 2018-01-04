//
//  GMNewWelfareCell.m
//  GMStore-iOS
//
//  Created by 杨俊 on 2018/1/2.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "GMNewWelfareCell.h"
#import "GMNewWelfareLayout.h"
#import "GMGoodsHandheldCell.h"

@interface GMNewWelfareCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GMNewWelfareLayoutDelegate>
/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
@end

@implementation GMNewWelfareCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.collectionView.backgroundColor = self.backgroundColor;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GMGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GMGoodsHandheldCell cellReuseIdentifier]
                                                                          forIndexPath:indexPath];
    NSArray *images = GoodsNewWelfareImagesArray;
    cell.handheldImage = images[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                  withReuseIdentifier:@"HeaderReusableView"
                                                                                         forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor redColor];
        return headerView;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                  withReuseIdentifier:@"FooterReusableView"
                                                                                         forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor greenColor];
        return footerView;
    }
    
    return [UICollectionReusableView new];
}

#pragma mark - item点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"第%zd个item",indexPath.row);
}

#pragma mark - 底部高度
-(CGFloat)yj_HeightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath {
    return DCMargin;
}

#pragma mark - 头部高度
-(CGFloat)yj_HeightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

#pragma mark - lazyload
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        GMNewWelfareLayout *dcLayout = [GMNewWelfareLayout new];
        dcLayout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:dcLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        
        [_collectionView registerClass:[GMGoodsHandheldCell class] forCellWithReuseIdentifier:[GMGoodsHandheldCell cellReuseIdentifier]];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"]; //注册头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView"]; //注册尾部
    }
    return _collectionView;
}

@end
