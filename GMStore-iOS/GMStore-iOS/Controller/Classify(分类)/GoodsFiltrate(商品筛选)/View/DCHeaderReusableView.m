//
//  DCHeaderReusableView.m
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCHeaderReusableView.h"
#import "DCFiltrateItem.h"

@interface DCHeaderReusableView ()
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UIButton *upDownButton;
@end

@implementation DCHeaderReusableView

- (void)setHeadFiltrate:(DCFiltrateItem *)headFiltrate
{
    _headLabel.text = headFiltrate.headTitle;
    
    if (headFiltrate.isOpen) { //箭头
        [self.upDownButton setImage:[UIImage imageNamed:@"arrow_down"] forState:0];
    }else{
        [self.upDownButton setImage:[UIImage imageNamed:@"arrow_up"] forState:0];
    }
}

- (IBAction)upDownClick:(UIButton *)sender {
    !_sectionClick ? : _sectionClick();
}

@end
