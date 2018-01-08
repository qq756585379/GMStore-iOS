//
//  DCTitleRolling.m
//  CDDTitleRolling
//
//  Created by dashen on 2017/11/17.
//  Copyright © 2017年 com.RocketsChen. All rights reserved.
//

#define RollingBtnTag      1000

#define RollingViewHeight self.frame.size.height
#define RollingViewWidth  self.frame.size.width
#define RollingMargin 10

#import "DCTitleRolling.h"

@interface DCTitleRolling ()
/** 定时器的循环时间 */
@property (nonatomic , assign)NSInteger interval;
/* 定时器 */
@property (strong , nonatomic)NSTimer *timer;
/* 图片 */
@property (strong , nonatomic)NSString *leftImage;
/* 按钮提示文字 */
@property (strong , nonatomic)NSString *rightbuttonTitle;
/* 标题 */
@property (strong , nonatomic)NSArray *rolTitles;
/* tags */
@property (strong , nonatomic)NSArray *rolTags;
/* 右边图片数组 */
@property (strong , nonatomic)NSArray *rightImages;
/* 滚动时间 */
@property (assign , nonatomic)float rollingTime;
/* 字体尺寸 */
@property (nonatomic , assign)NSInteger titleFont;
/* 字体颜色 */
@property (strong , nonatomic)UIColor *titleColor;
/* 滚动按钮数组 */
@property (strong , nonatomic)NSMutableArray *saveMiddleArray;
/** 是否显示tagLabel边框 */
@property (nonatomic,  assign)BOOL isShowTagBorder;

@property (nonatomic,  assign) CDDRollingGroupStyle rollingGroupStyle;
@end

@implementation DCTitleRolling

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_leftImageView];
    }
    return _leftImageView;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.adjustsImageWhenHighlighted = NO;
        [_rightButton setTitleColor:[UIColor darkGrayColor] forState:0];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

- (NSMutableArray *)saveMiddleArray
{
    if (!_saveMiddleArray) {
        _saveMiddleArray = [NSMutableArray array];
    }
    return _saveMiddleArray;
}

- (instancetype)initWithFrame:(CGRect)frame WithTitleData:(void(^)(CDDRollingGroupStyle *rollingGroupStyle, NSString **leftImage,NSArray **rolTitles,NSArray **rolTags,NSArray **rightImages,NSString **rightbuttonTitle,NSInteger *interval,float *rollingTime,NSInteger *titleFont,UIColor **titleColor,BOOL *isShowTagBorder))titleDataBlock{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSString *leftImage;
        NSString *rightbuttonTitle;
        
        NSArray *rolTitles;
        NSArray *rolTags;
        NSArray *rightImages;
        
        NSInteger interval;
        float rollingTime;
        NSInteger titleFont;
        UIColor *titleColor;

        BOOL isShowTagBorder;
        
        if (titleDataBlock){
		titleDataBlock(&_rollingGroupStyle,&leftImage,&rolTitles,&rolTags,&rightImages,&rightbuttonTitle,&interval,&rollingTime,&titleFont,&titleColor,&isShowTagBorder);
            
            self.leftImage = leftImage;
            self.rolTitles = rolTitles;
            self.rolTags = rolTags;
            self.rightImages = rightImages;
            self.interval = (interval == 0 || interval > 100) ? 5.0 : interval; //限定定时不大于100秒
            self.rollingTime = (rollingTime <= 0.1  || rollingTime > 1) ? 0.5 : rollingTime; //限定翻滚时间不能大于1秒
            self.rightbuttonTitle = rightbuttonTitle;
            self.titleFont = (titleFont == 0) ? 13 : titleFont;
            self.titleColor = (titleColor == nil) ? [UIColor blackColor] : titleColor;
            self.isShowTagBorder = isShowTagBorder;
            
            if (self.rolTags.count == 0 && self.rolTitles.count == 0) return 0; //若数组为0直接返回
            if (_rollingGroupStyle == CDDRollingTwoGroup) {
                [self setUpTwoGroupRollingUI]; //UI
            }else{
                [self setUpOneGroupRollingUI]; //UI
            }
        };
    }
    return self;
}

#pragma mark - 界面搭建【CDDRollingOneGroup】
- (void)setUpOneGroupRollingUI
{
    [self setUpRollingLeft];
    
    [self setUpRollingCenter];
    
    [self setUpRollingRight];
}

#pragma mark - 界面搭建【CDDRollingTwoGroup】
- (void)setUpTwoGroupRollingUI
{
    [self setUpRollingLeft];
    
    [self setUpRollingCenterRight];
}

#pragma mark - 左边图片
- (void)setUpRollingLeft
{
    if (self.leftImage == nil) return;

    self.leftImageView.frame = CGRectMake(0, RollingViewHeight * 0.1, RollingViewHeight * 1.5, RollingViewHeight * 0.8);
    self.leftImageView.image = [UIImage imageNamed:self.leftImage];
}

#pragma mark - 中间带右部
- (void)setUpRollingCenterRight
{
    if (self.saveMiddleArray.count > 0) return;

    if (_rolTitles.count > 1) {//@[@[],@[]]
        
        NSArray *firstTitleArrray = _rolTitles.firstObject;
        NSArray *firstTagArrray = _rolTags.firstObject;
        NSArray *lastTagArray = _rolTags.lastObject;
        NSArray *lastTitleArray = _rolTitles.lastObject;
        
        for (NSInteger i= 0; i < firstTitleArrray.count; i++) {
            
            UIButton *middleView = [self getBackMiddleViewWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame), 0, RollingViewWidth - CGRectGetMaxX(self.leftImageView.frame), RollingViewHeight) WithIndex:i]; //中间View
            
            UILabel *contentTopLabel = [UILabel new];
            [middleView addSubview:contentTopLabel];
            
            UILabel *contentBottomLabel = [UILabel new];
            [middleView addSubview:contentBottomLabel];
            
            contentTopLabel.textAlignment = contentBottomLabel.textAlignment = NSTextAlignmentLeft;
            contentTopLabel.font = contentBottomLabel.font = [UIFont systemFontOfSize:self.titleFont];
            contentTopLabel.textColor = contentBottomLabel.textColor = self.titleColor;
            
            UIImageView *rightImageView = [UIImageView new];
            
            if (_rightImages.count == firstTitleArrray.count) {
                [middleView addSubview:rightImageView];
                rightImageView.frame = CGRectMake(middleView.width - (middleView.height * 1.2), 0, middleView.height * 1.2, middleView.height);
                rightImageView.contentMode = UIViewContentModeCenter;
                rightImageView.image = [UIImage imageNamed:_rightImages[i]];
            }
            
            contentTopLabel.text = firstTitleArrray[i];
            contentBottomLabel.text = lastTitleArray[i];
            
            if (_rolTags.count > 0 && firstTitleArrray.count == firstTagArrray.count) {
                UILabel *tagTopLabel = [UILabel new];
                UILabel *tagBottomLabel = [UILabel new];
                [middleView addSubview:tagTopLabel];
                [middleView addSubview:tagBottomLabel];

                tagTopLabel.font = tagBottomLabel.font = [UIFont systemFontOfSize:self.titleFont - 1.5];
                tagTopLabel.textColor = tagBottomLabel.textColor = [UIColor orangeColor];
                tagTopLabel.textAlignment = tagBottomLabel.textAlignment = NSTextAlignmentCenter;
                tagTopLabel.text = firstTagArrray[i];
                tagBottomLabel.text = lastTagArray[i];
                
                if (self.isShowTagBorder) { //是否tag显示边框
                    [tagTopLabel doBorderWidth:1 color:tagTopLabel.textColor cornerRadius:3];
                    [tagBottomLabel doBorderWidth:1 color:tagBottomLabel.textColor cornerRadius:3];
                }
                
                CGSize tagTopSize = [YJTool yj_calculateRectWithText:firstTagArrray[i] FontSize:self.titleFont - 1 MaxSize:CGSizeMake(MAXFLOAT, RollingViewHeight)];
                
                CGSize tagBottomSize = [YJTool yj_calculateRectWithText:lastTagArray[i] FontSize:self.titleFont - 1 MaxSize:CGSizeMake(MAXFLOAT, RollingViewHeight)];
                
                tagTopLabel.size = CGSizeMake(tagTopSize.width + 4, tagTopSize.height + 4);
                tagBottomLabel.size = CGSizeMake(tagBottomSize.width + 4, tagBottomSize.height + 4);
                
                contentTopLabel.frame = CGRectMake(CGRectGetMaxX(tagTopLabel.frame) + 5, 0, middleView.width - rightImageView.width, middleView.height * 0.5);
                
                contentBottomLabel.frame = CGRectMake(CGRectGetMaxX(tagBottomLabel.frame) + 5, middleView.height * 0.5, middleView.width - rightImageView.width, middleView.height * 0.5);
                
                tagTopLabel.x = tagBottomLabel.x = 0;
                tagTopLabel.centerY = contentTopLabel.centerY;
                tagBottomLabel.centerY = contentBottomLabel.centerY;
                
            }else{
                
                contentTopLabel.frame = CGRectMake(0, 0, middleView.width - rightImageView.width, middleView.height * 0.5);
                contentBottomLabel.frame = CGRectMake(0, middleView.height * 0.5, middleView.width - rightImageView.width, middleView.height * 0.5);
            }
            
            [self setUpCATransform3DWithIndex:i WithButton:middleView];//旋转
        }
    }
}

#pragma mark - 中间滚动内容
- (void)setUpRollingCenter{
    if (self.saveMiddleArray.count > 0) return;
    
    if (_rolTitles.count > 0) {
        for (NSInteger i = 0; i < _rolTitles.count; i++) {
            
            CGRect middleFrame = (self.rightbuttonTitle == nil) ? CGRectMake(CGRectGetMaxX(self.leftImageView.frame), 0, RollingViewWidth - CGRectGetMaxX(self.leftImageView.frame), RollingViewHeight) : CGRectMake(CGRectGetMaxX(self.leftImageView.frame), 0, RollingViewWidth - (CGRectGetMaxX(self.leftImageView.frame) + RollingViewWidth * 0.2), RollingViewHeight);
            
            UIButton *middleView = [self getBackMiddleViewWithFrame:middleFrame WithIndex:i];
            
            UILabel *contentLabel = [UILabel new];
            [middleView addSubview:contentLabel];
            contentLabel.textAlignment = NSTextAlignmentLeft;
            contentLabel.font = [UIFont systemFontOfSize:self.titleFont];
            contentLabel.textColor = self.titleColor;
            contentLabel.text = self.rolTitles[i];
            
            if (self.rolTags.count > 0 && self.rolTitles.count == self.rolTags.count) {
            
                UILabel *tagLabel = [UILabel new];
                [middleView addSubview:tagLabel];
                tagLabel.font = [UIFont systemFontOfSize:self.titleFont - 1.5];
                tagLabel.textColor = [UIColor redColor];
                tagLabel.textAlignment = NSTextAlignmentCenter;
                
                tagLabel.text = self.rolTags[i];
                if (self.isShowTagBorder) {//是否tag显示边框
                    [tagLabel doBorderWidth:1 color:tagLabel.textColor cornerRadius:3];
                }
                
                CGSize tagSize = [YJTool yj_calculateRectWithText:self.rolTags[i] FontSize:self.titleFont - 1 MaxSize:CGSizeMake(MAXFLOAT, RollingViewHeight)];
            
                tagLabel.size = CGSizeMake(tagSize.width + 4, tagSize.height + 4);
                tagLabel.x = 0;
                tagLabel.centerY = middleView.centerY;
                
                contentLabel.frame = CGRectMake(CGRectGetMaxX(tagLabel.frame) + 5, 0, middleView.width - CGRectGetMaxX(tagLabel.frame), middleView.height);

            }else{
                contentLabel.frame = CGRectMake(5, 0, middleView.width - RollingMargin, middleView.height);
            }
            
            [self setUpCATransform3DWithIndex:i WithButton:middleView]; //旋转
        }
    }
}

#pragma mark - 右边按钮
- (void)setUpRollingRight
{
    if (self.rightbuttonTitle == nil) return;
    
    self.rightButton.frame = CGRectMake(RollingViewWidth * 0.8, RollingViewHeight * 0.1, RollingViewWidth * 0.18, RollingViewHeight * 0.8);
    [self.rightButton setTitle:self.rightbuttonTitle forState:0];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:self.titleFont + 0.5];
    
    [self.rightButton addTarget:self action:@selector(rightMoreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnLine = [UIView new];
    btnLine.backgroundColor = [UIColor darkGrayColor];
    btnLine.frame = CGRectMake(RollingViewWidth * 0.82, RollingViewHeight * 0.35, 1.5, RollingViewHeight * 0.3);
    [self addSubview:btnLine];
}

#pragma mark - 开始滚动
- (void)dc_beginRolling{
    _timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(titleRolling) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 结束滚动
- (void)dc_endRolling{
    [_timer invalidate];
}

#pragma mark - 标题滚动
- (void)titleRolling{
    if (self.saveMiddleArray.count > 1) { //所存的每组滚动
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:self.rollingTime animations:^{
            [self getMiddleArrayWithIndex:0 WithAngle:- M_PI_2 Height: -RollingViewHeight / 2]; //第0组
            [self getMiddleArrayWithIndex:1 WithAngle:0 Height:0]; //第一组
        } completion:^(BOOL finished) {
            if (finished == YES) { //旋转结束
                UIButton *newMiddleView = [weakSelf getMiddleArrayWithIndex:0 WithAngle:M_PI_2 Height: -RollingViewHeight / 2];
                [weakSelf.saveMiddleArray addObject:newMiddleView];
                [weakSelf.saveMiddleArray removeObjectAtIndex:0];
            }
        }];
    }
}

#pragma mark - CATransform3D翻转
- (UIButton *)getMiddleArrayWithIndex:(NSInteger)index WithAngle:(CGFloat)angle Height:(CGFloat)height{
    if (index > _saveMiddleArray.count) return 0;
    UIButton *middleView = self.saveMiddleArray[index];
    
    CATransform3D trans = CATransform3DIdentity;
    trans = CATransform3DMakeRotation(angle, 1, 0, 0);
    trans = CATransform3DTranslate(trans, 0, height, height);
    middleView.layer.transform = trans;
    
    return middleView;
}

- (void)setUpCATransform3DWithIndex:(NSInteger)index WithButton:(UIButton *)contentButton
{
    if (index != 0) {
        CATransform3D trans = CATransform3DIdentity;
        trans = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        trans = CATransform3DTranslate(trans, 0, - RollingViewHeight / 2, -RollingViewHeight / 2);
        contentButton.layer.transform = trans;
    }else{
        CATransform3D trans = CATransform3DIdentity;
        trans = CATransform3DMakeRotation(0, 1, 0, 0);
        trans = CATransform3DTranslate(trans, 0, 0, - RollingViewHeight / 2);
        contentButton.layer.transform = trans;
    }
}

#pragma mark - 初始化中间View
- (UIButton *)getBackMiddleViewWithFrame:(CGRect)frame WithIndex:(NSInteger)index{
    UIButton *middleView = [UIButton buttonWithType:UIButtonTypeCustom];
    middleView.adjustsImageWhenHighlighted = NO;
    middleView.tag = RollingBtnTag + index;
    [middleView addTarget:self action:@selector(titleButonAction:) forControlEvents:UIControlEventTouchUpInside];
    middleView.frame = frame;
    [self addSubview:middleView];
    [self.saveMiddleArray addObject:middleView];
    return middleView;
}

#pragma mark - 点击更多
- (void)rightMoreButtonClick{
    !_moreClickBlock ? : _moreClickBlock();
}

- (void)titleButonAction:(UIButton *)sender{
    NSInteger tag = sender.tag - RollingBtnTag;
    if ([self.delegate respondsToSelector:@selector(dc_RollingViewSelectWithActionAtIndex:)]) {
        [self.delegate dc_RollingViewSelectWithActionAtIndex:tag];
    }
}

@end
