//
//  DCLIRLButton.m
//  CDDMall
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCLIRLButton.h"

@implementation DCLIRLButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width * 0.55;
    self.imageView.x = self.titleLabel.x - self.imageView.width - 5;
}

@end
