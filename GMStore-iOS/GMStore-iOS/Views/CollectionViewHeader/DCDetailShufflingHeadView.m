//
//  DCDetailShufflingHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCDetailShufflingHeadView.h"
#import <SDCycleScrollView.h>

@interface DCDetailShufflingHeadView ()<SDCycleScrollViewDelegate>
/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;
@end

@implementation DCDetailShufflingHeadView

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
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height)
                                                          delegate:self placeholderImage:nil];
    _cycleScrollView.autoScroll = NO; // 不自动滚动
    [self addSubview:_cycleScrollView];
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}

- (void)setShufflingArray:(NSArray *)shufflingArray
{
    _shufflingArray = shufflingArray;
    _cycleScrollView.imageURLStringsGroup = shufflingArray;
}

@end
