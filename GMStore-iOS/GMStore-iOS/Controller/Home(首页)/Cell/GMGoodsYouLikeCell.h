//
//  GMGoodsYouLikeCell.h
//  GMStore-iOS
//
//  Created by 杨俊 on 2018/1/2.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "YJCollectionViewCell.h"

@class GMRecommendItem;

@interface GMGoodsYouLikeCell : YJCollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic)GMRecommendItem *youLikeItem;
/* 相同 */
@property (strong , nonatomic)UIButton *sameButton;
/** 找相似点击回调 */
@property (nonatomic, copy) dispatch_block_t lookSameBlock;

@end
