//
//  JSMeViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/21.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSMeViewController.h"

@interface JSMeViewController ()

@end

@implementation JSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingButton = [UIBarButtonItem initWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonButton = [UIBarButtonItem initWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingButton, moonButton];
    
    // 设置背景色
    self.view.backgroundColor = JSGlobalBackGroundColor;
    
}

- (void)settingClick {
    JSLogFunc;
}


- (void)moonClick {
    JSLogFunc;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
