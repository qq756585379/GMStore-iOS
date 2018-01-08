//
//  DCListGridCell.h
//  CDDMall
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "YJCollectionViewCell.h"

@class GMRecommendItem;

@interface DCListGridCell : YJCollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic)GMRecommendItem *youSelectItem;

/** 冒号点击回调 */
@property (nonatomic, copy) dispatch_block_t colonClickBlock;

@end
