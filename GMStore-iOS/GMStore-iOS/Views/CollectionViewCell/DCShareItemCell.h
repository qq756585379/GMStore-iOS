//
//  DCShareItemCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/11.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "YJCollectionViewCell.h"

@class DCShareItem;

@interface DCShareItemCell : YJCollectionViewCell

/* 分享数据 */
@property (strong , nonatomic)DCShareItem *shareItem;

@end
