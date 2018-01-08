//
//  DCClassCategoryCell.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "YJTableViewCell.h"

@class DCClassGoodsItem;

@interface DCClassCategoryCell : YJTableViewCell

/* 标题数据 */
@property (strong , nonatomic)DCClassGoodsItem *titleItem;

@end
