//
//  DCLoginMeViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/4.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCLoginMeViewController.h"

@interface DCLoginMeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation DCLoginMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sertUpBase];
}

- (void)sertUpBase {
    self.view.backgroundColor = [UIColor whiteColor];
    _loginButton.enabled = NO;
    _loginButton.backgroundColor = [UIColor lightGrayColor];
    [_userNameField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    [_userPasswordField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    _userNameField.text = ([YJUserDefault getValueForKey:@"UserName"] == nil) ? nil : [YJUserDefault getValueForKey:@"UserName"];
}

#pragma mark - 注册
- (IBAction)registAccount {
    
}

#pragma mark - 退出当前界面
- (IBAction)dismissViewController {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 账号/密码 登录
- (IBAction)LoginAccount {
    if ([self.userNameField.text isEqualToString:@"CDDMall"] && [self.userPasswordField.text isEqualToString:@"000"]) {
        [YJUserDefault setValue:@"1" forKey:@"isLogin"]; //1代表登录
        [YJUserDefault setValue:self.userNameField.text forKey:@"UserName"]; //记录用户名
        WEAK_SELF
        [self dismissViewControllerAnimated:YES completion:^{
            [weakSelf.view endEditing:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:LOGINSELECTCENTERINDEX object:nil];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"账号密码错误请重新登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

#pragma mark - 快速登录
- (IBAction)fastLoginAccount {
    
}

#pragma mark - 忘记密码
- (IBAction)dismissPassword {
    
    
}

#pragma mark - 使用一下账号登录
- (IBAction)wbmsqqemLogin {
    
}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_userNameField.text.length != 0 && _userPasswordField.text.length != 0) {
        _loginButton.backgroundColor = RGB(252, 159, 149);
        _loginButton.enabled = YES;
    }else{
        _loginButton.backgroundColor = [UIColor lightGrayColor];
        _loginButton.enabled = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end



