//
//  DCShareItemCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/11.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCShareItemCell.h"
#import "DCShareItem.h"

@interface DCShareItemCell ()
/* 图片 */
@property (strong , nonatomic)UIImageView *shareImageView;
/* 品台 */
@property (strong , nonatomic)UILabel *shareLabel;
@end

@implementation DCShareItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _shareImageView = [UIImageView new];
    [self addSubview:_shareImageView];
    
    _shareLabel = [UILabel new];
    _shareLabel.textAlignment = NSTextAlignmentCenter;
    _shareLabel.textColor = [UIColor darkGrayColor];
    _shareLabel.font = PFR13Font;
    [self addSubview:_shareLabel];
    
    [_shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self) setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(43 , 43));
    }];
    
    [_shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_shareImageView.mas_bottom) setOffset:DCMargin];
        make.centerX.mas_equalTo(self);
    }];
}

- (void)setShareItem:(DCShareItem *)shareItem
{
    _shareItem = shareItem;
    self.shareLabel.text = shareItem.terrace;
    self.shareImageView.image = [UIImage imageNamed:shareItem.iconImage];
}

@end
