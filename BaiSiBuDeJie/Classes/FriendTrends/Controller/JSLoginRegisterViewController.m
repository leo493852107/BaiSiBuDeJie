//
//  JSLoginRegisterViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/7/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSLoginRegisterViewController.h"

@interface JSLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation JSLoginRegisterViewController

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    // NSAttributedString: 带有属性的文字（富文本）
//    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
//    self.phoneField.attributedPlaceholder = placeholder;

    // 牛逼的富文本
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(0, 1)];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor yellowColor],NSFontAttributeName: [UIFont systemFontOfSize:23]} range:NSMakeRange(1, 1)];
//    [placeholder setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(2, 1)];
//    self.phoneField.attributedPlaceholder = placeholder;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showLoginOrRegister:(UIButton *)button {
    
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        // 显示注册
        self.loginViewLeftMargin.constant = - self.view.width;
        button.selected = YES;
//        [button setTitle:@"已有账号?" forState:UIControlStateNormal];
    } else {
        // 显示登录
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
//        [button setTitle:@"注册" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

/**
 *  让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
