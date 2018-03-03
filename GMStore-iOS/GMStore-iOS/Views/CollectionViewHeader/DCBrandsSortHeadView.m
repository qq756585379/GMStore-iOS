//
//  DCBrandsSortHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBrandsSortHeadView.h"
#import "DCClassMianItem.h"

@interface DCBrandsSortHeadView ()
/* 头部标题Label */
@property (strong , nonatomic)UILabel *headLabel;
@end

@implementation DCBrandsSortHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = PFR13Font;
    _headLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_headLabel];
    _headLabel.frame = CGRectMake(DCMargin, 0, self.width, self.height);
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(DCClassMianItem *)headTitle
{
    _headTitle = headTitle;
    _headLabel.text = headTitle.title;
}

@end
