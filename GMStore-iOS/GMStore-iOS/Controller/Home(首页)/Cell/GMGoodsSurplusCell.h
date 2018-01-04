//
//  GMGoodsSurplusCell.h
//  GMStore-iOS
//
//  Created by 杨俊 on 2018/1/2.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "YJCollectionViewCell.h"

@class GMRecommendItem;

@interface GMGoodsSurplusCell : YJCollectionViewCell

/* 推荐商品数据 */
@property (strong , nonatomic)GMRecommendItem *recommendItem;

@end
