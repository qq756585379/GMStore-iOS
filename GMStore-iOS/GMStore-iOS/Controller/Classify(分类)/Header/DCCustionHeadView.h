//
//  DCCustionHeadView.h
//  CDDMall
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "YJCollectionReusableView.h"

@interface DCCustionHeadView : YJCollectionReusableView

/** 筛选点击回调 */
@property (nonatomic, copy) dispatch_block_t filtrateClickBlock;

@end
