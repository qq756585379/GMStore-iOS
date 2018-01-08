//
//  DCSwitchGridCell.h
//  CDDMall
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "YJCollectionViewCell.h"

@class GMRecommendItem;

@interface DCSwitchGridCell : YJCollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic)GMRecommendItem *youSelectItem;

@end
