//
//  GMHomeTopToolView.h
//  GMStore-iOS
//
//  Created by 杨俊 on 2017/12/28.
//  Copyright © 2017年 上海创米科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMHomeTopToolView : UIView

/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
/** 右边第二个Item点击 */
@property (nonatomic, copy) dispatch_block_t rightRItemClickBlock;
/** 搜索按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t searchButtonClickBlock;
/** 语音按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t voiceButtonClickBlock;

@end
