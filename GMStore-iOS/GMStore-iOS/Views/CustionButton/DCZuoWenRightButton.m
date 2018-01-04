//
//  DCZuoWenRightButton.m
//  CDDMall
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCZuoWenRightButton.h"

@implementation DCZuoWenRightButton

- (void)layoutSubviews{
    [super layoutSubviews];

    //设置lable
    self.titleLabel.x = 0;
    self.titleLabel.centerY = self.centerY;
    [self.titleLabel sizeToFit];
    
    //设置图片位置
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.centerY = self.centerY;
    [self.imageView sizeToFit];
}

@end
