//
//  DCCountDownHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCountDownHeadView.h"
#import "DCZuoWenRightButton.h"

@interface DCCountDownHeadView ()
/* 红色块 */
@property (strong , nonatomic)UIView *redView;
/* 时间 */
@property (strong , nonatomic)UILabel *timeLabel;
/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;
/* 好货秒抢 */
@property (strong , nonatomic)DCZuoWenRightButton *quickButton;
@end

@implementation DCCountDownHeadView

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
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    [self addSubview:_redView];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"6点场";
    _timeLabel.font = PFR16Font;
    [self addSubview:_timeLabel];
    
    _countDownLabel = [[UILabel alloc] init];
    _countDownLabel.textColor = [UIColor redColor];
    _countDownLabel.text = @"05 : 58 : 33";
    _countDownLabel.font = PFR14Font;
    [self addSubview:_countDownLabel];
    
    _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = PFR12Font;
    [_quickButton setImage:[UIImage imageNamed:@"shouye_icon_jiantou"] forState:UIControlStateNormal];
    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_quickButton setTitle:@"好货秒抢" forState:UIControlStateNormal];
    [self addSubview:_quickButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _redView.frame = CGRectMake(0, 10, 8, 20);
    _timeLabel.frame = CGRectMake(20, 0, 60, self.height);
    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, 100, self.height);
    _quickButton.frame = CGRectMake(self.width - 70, 0, 70, self.height);
}

@end
