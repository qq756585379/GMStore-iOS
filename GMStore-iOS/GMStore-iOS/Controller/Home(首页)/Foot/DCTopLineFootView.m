//
//  DCTopLineFootView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCTopLineFootView.h"
#import "DCTitleRolling.h"
#import "UIImage+GIF.h"

@interface DCTopLineFootView ()<UIScrollViewDelegate,CDDRollingDelegate>
/* 滚动 */
@property (strong , nonatomic)DCTitleRolling *numericalScrollView;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;
/* 顶部广告宣传图片 */
@property (strong , nonatomic)UIImageView *topAdImageView;
@end

@implementation DCTopLineFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        
        [self setUpBase];
    }
    return self;
}

- (void)setUpUI{
    //手机潮品，嗨够不停
    _topAdImageView = [[UIImageView alloc] init];
    _topAdImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_topAdImageView];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:HomeBottomViewGIFImage] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        _topAdImageView.image = [UIImage sd_animatedGIFWithData:data];
    }];
    
    //初始化 第三方
    _numericalScrollView = [[DCTitleRolling alloc] initWithFrame:CGRectMake(0, self.height - 50, self.width, 50) WithTitleData:^(CDDRollingGroupStyle *rollingGroupStyle, NSString *__autoreleasing *leftImage, NSArray *__autoreleasing *rolTitles, NSArray *__autoreleasing *rolTags, NSArray *__autoreleasing *rightImages, NSString *__autoreleasing *rightbuttonTitle, NSInteger *interval, float *rollingTime, NSInteger *titleFont, UIColor *__autoreleasing *titleColor, BOOL *isShowTagBorder) {
        
        *rollingTime = 0.25;
        *rolTags = @[@"冬季健康日",@"新手上路",@"年终内购会",@"GitHub星星走一波"];
        *rolTitles = @[@"先领券在购物，一元抢？",@"2000元热门手机推荐",@"好奇么？点进去哈",@"这套家具比房子还贵"];
        *leftImage = @"shouye_img_toutiao";
        *interval = 6.0;
        *titleFont = 14;
        *isShowTagBorder = YES;
        *titleColor = [UIColor darkGrayColor];
    }];
    
    _numericalScrollView.moreClickBlock = ^{
        NSLog(@"mall----more");
    };
    
    [_numericalScrollView dc_beginRolling];
    
    _numericalScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_numericalScrollView];
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = YJBGColor;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.height - 8, SCREEN_WIDTH, 8);
    
    [_topAdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(self);
        [make.bottom.mas_equalTo(self)setOffset:-50];
    }];
}

- (void)setUpBase
{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%zd头条滚动条",index);
}

@end
