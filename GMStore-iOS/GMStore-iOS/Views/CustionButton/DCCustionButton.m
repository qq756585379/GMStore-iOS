//
//  DCCustionButton.m
//  CDDMall
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCustionButton.h"

@implementation DCCustionButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.titleLabel.font = PFR14Font;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    //计算完加一个间距
    self.width += DCMargin;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.x = self.width * 0.3;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + DCMargin;
}

@end
