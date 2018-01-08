//
//  DCFootprintCell.h
//  CDDMall
//
//  Created by apple on 2017/6/15.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "YJTableViewCell.h"

@class GMRecommendItem;

@interface DCFootprintCell : YJTableViewCell

/* 足迹数据 */
@property (strong , nonatomic)GMRecommendItem *footprintItem;

@end
