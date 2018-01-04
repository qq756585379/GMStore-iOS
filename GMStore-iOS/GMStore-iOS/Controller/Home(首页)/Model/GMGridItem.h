//
//  GMGridItem.h
//  GMStore-iOS
//
//  Created by 杨俊 on 2017/12/28.
//  Copyright © 2017年 上海创米科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMGridItem : NSObject

/** 图片  */
@property (nonatomic, copy ,readonly) NSString *iconImage;
/** 文字  */
@property (nonatomic, copy ,readonly) NSString *gridTitle;
/** tag  */
@property (nonatomic, copy ,readonly) NSString *gridTag;
/** tag颜色  */
@property (nonatomic, copy ,readonly) NSString *gridColor;

@end
