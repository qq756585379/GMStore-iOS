//
//  DCOverFootView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCOverFootView.h"

@interface DCOverFootView ()
/* label */
@property (strong , nonatomic)UILabel *overLabel;
@end

@implementation DCOverFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _overLabel = [[UILabel alloc] init];
    _overLabel.textAlignment = NSTextAlignmentCenter;
    _overLabel.font = PFR16Font;
    _overLabel.textColor = [UIColor darkGrayColor];
    _overLabel.text = @"看完喽，下次在逛吧";
    [self addSubview:_overLabel];
    
    [_overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}

@end
