//
//  GMGoodsHandheldCell.m
//  GMStore-iOS
//
//  Created by 杨俊 on 2018/1/2.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "GMGoodsHandheldCell.h"

@interface GMGoodsHandheldCell ()
/* 图片 */
@property (strong , nonatomic)UIImageView *handheldImageView;
@end

@implementation GMGoodsHandheldCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _handheldImageView = [[UIImageView alloc] init];
    _handheldImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_handheldImageView];
    
    [_handheldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setHandheldImage:(NSString *)handheldImage
{
    _handheldImage = handheldImage;
    
    [_handheldImageView sd_setImageWithURL:[NSURL URLWithString:handheldImage]];
}

@end
