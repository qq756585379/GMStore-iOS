//
//  SideBarView.m
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCSildeBarView.h"
#import "DCFiltrateViewController.h"

#define AnimatorDuration  0.25

@interface DCSildeBarView() <UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *coverView;//遮罩
@property (nonatomic,strong) DCFiltrateViewController *filterView;//筛选视图
@end

@implementation DCSildeBarView

+ (void)dc_showSildBarViewController{
    DCSildeBarView *obj = [[DCSildeBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [KEY_WINDOW addSubview:obj];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpBaseSetting];
    }
    return self;
}

- (void)setUpBaseSetting{
    [self addSubViews];
    [self addGestureRecognizer];
}

- (void)addSubViews{
    [self addSubview:self.coverView];
    [self addSubview:self.filterView.view];
    
    WEAK_SELF
    [UIView animateWithDuration:AnimatorDuration animations:^{
        weakSelf.coverView.alpha = 0.4;
        weakSelf.filterView.view.x = SCREEN_WIDTH * 0.2;
    }];
    
    self.filterView.sureClickBlock = ^(NSArray *selectArray) { //在筛选情况下的确定回调
        [weakSelf tapEvent];
    };
}

#pragma mark - 添加手势和监听
- (void)addGestureRecognizer
{
    //添加手势
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panEvent:)]; //滑动
    pan.delegate = self;
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
    [self.coverView addGestureRecognizer:tap]; //点击
    
    //添加“frame”监听
    [self.filterView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - private Methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        CGRect new = [change[@"new"] CGRectValue];
        CGFloat x = new.origin.x;
        if (x < SCREEN_WIDTH) {
            self.coverView.alpha = 0.4 * (1-x / SCREEN_WIDTH) + 0.1;
        }else{
            self.coverView.alpha = 0.0;
        }
    }
}

#pragma mark - 滑动手势事件
- (void)panEvent:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint translation = [recognizer translationInView:self];
    
    if(UIGestureRecognizerStateBegan == recognizer.state || UIGestureRecognizerStateChanged == recognizer.state){
        
        if (translation.x > 0 ) {//右滑
            self.filterView.view.x = SCREEN_WIDTH * 0.2 + translation.x;
        }else{//左滑
            
            if (self.filterView.view.x < SCREEN_WIDTH * 0.2) {
                self.filterView.view.x = self.filterView.view.x - translation.x;
            }else{
                self.filterView.view.x = SCREEN_WIDTH * 0.2;
            }
        }
    }else{
        [self tapEvent];
    }
}

- (void)tapEvent{
    WEAK_SELF
    [UIView animateWithDuration:AnimatorDuration animations:^{
        weakSelf.coverView.alpha = 0.0;
        weakSelf.filterView.view.x = SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        [weakSelf removeAllSubviews];
        [weakSelf removeFromSuperview];
    }];
}

- (void)removeAllSubviews {
    if (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (void)dealloc{
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.filterView removeObserver:self forKeyPath:@"frame"];
}

#pragma mark - LazyLaod
- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.0;
    }
    return _coverView;
}

- (DCFiltrateViewController *)filterView{
    if (!_filterView) {
        _filterView = [[DCFiltrateViewController alloc]init];
        _filterView.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH * 0.8, SCREEN_HEIGHT);
    }
    return _filterView;
}

@end
