//
//  JSFriendTrendsViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/21.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSFriendTrendsViewController.h"
#import "JSRecommendViewController.h"
#import "JSLoginRegisterViewController.h"

@interface JSFriendTrendsViewController ()

@end

@implementation JSFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];

    // 设置背景色
    self.view.backgroundColor = JSGlobalBackGroundColor;
    
    
}

- (void)friendsClick {
    JSRecommendViewController *vc = [[JSRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginRegister {
    JSLoginRegisterViewController *login = [[JSLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
