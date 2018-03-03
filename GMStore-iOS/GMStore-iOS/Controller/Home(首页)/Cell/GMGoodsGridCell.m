//
//  GMGoodsGridCell.m
//  GMStore-iOS
//
//  Created by 杨俊 on 2017/12/29.
//  Copyright © 2017年 上海创米科技有限公司. All rights reserved.
//

#import "GMGoodsGridCell.h"
#import "GMGridItem.h"

@interface GMGoodsGridCell ()
/* imageView */
@property (strong , nonatomic)UIImageView *gridImageView;
/* gridLabel */
@property (strong , nonatomic)UILabel *gridLabel;
/* tagLabel */
@property (strong , nonatomic)UILabel *tagLabel;
@end

@implementation GMGoodsGridCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR13Font;
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gridLabel];
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:8];
    _tagLabel.backgroundColor = [UIColor whiteColor];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tagLabel];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self) setOffset:DCMargin];
        make.centerX.mas_equalTo(self);
        if (IS_IPHONE_5) {
            make.size.mas_equalTo(CGSizeMake(38, 38));
        }else{
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }
    }];
    
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(_gridImageView.mas_bottom) setOffset:5];
    }];
}

- (void)setGridItem:(GMGridItem *)gridItem
{
    _gridItem = gridItem;
    _gridLabel.text = gridItem.gridTitle;
    _tagLabel.text = gridItem.gridTag;
    _tagLabel.textColor = [UIColor colorWithHexString:gridItem.gridColor];
    [_tagLabel doBorderWidth:1 color:_tagLabel.textColor cornerRadius:5];
    
    if (_gridItem.iconImage.length == 0) return;
    
    if ([[_gridItem.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage] placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        _gridImageView.image = [UIImage imageNamed:_gridItem.iconImage];
    }
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    [self layoutIfNeeded];
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints
{
    CGSize tagSize = [YJTool yj_calculateRectWithText:_gridItem.gridTag FontSize:8 MaxSize:CGSizeMake(MAXFLOAT, 30)];
    [_tagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_gridImageView.mas_centerX);
        make.top.mas_equalTo(_gridImageView);
        make.size.mas_equalTo(CGSizeMake(tagSize.width + 4, tagSize.height + 4));
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

@end
