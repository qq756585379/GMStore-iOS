//
//  DCYouLikeHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCYouLikeHeadView.h"

@implementation DCYouLikeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _likeImageView = [[UIImageView alloc] init];
    _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_likeImageView];
    
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(150, 25));
    }];
}

@end
