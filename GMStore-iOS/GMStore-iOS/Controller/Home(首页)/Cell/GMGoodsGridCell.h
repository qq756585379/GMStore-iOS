//
//  GMGoodsGridCell.h
//  GMStore-iOS
//
//  Created by 杨俊 on 2017/12/29.
//  Copyright © 2017年 上海创米科技有限公司. All rights reserved.
//

#import "YJCollectionViewCell.h"

@class GMGridItem;

@interface GMGoodsGridCell : YJCollectionViewCell

/* 10个属性数据 */
@property (strong , nonatomic)GMGridItem *gridItem;

@end
