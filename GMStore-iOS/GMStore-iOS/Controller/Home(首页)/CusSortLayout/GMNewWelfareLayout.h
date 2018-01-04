//
//  GMNewWelfareLayout.h
//  GMStore-iOS
//
//  Created by 杨俊 on 2017/12/28.
//  Copyright © 2017年 上海创米科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GMNewWelfareLayoutDelegate <NSObject>
@optional;
/* 头部高度 */
-(CGFloat)yj_HeightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath;
/* 尾部高度 */
-(CGFloat)yj_HeightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath;
@end

@interface GMNewWelfareLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<GMNewWelfareLayoutDelegate>delegate;

@end
