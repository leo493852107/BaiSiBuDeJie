//
//  JSEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/21.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSEssenceViewController.h"
#import "JSRecommendTagsViewController.h"

@interface JSEssenceViewController ()

@end

@implementation JSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏图片标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = JSGlobalBackGroundColor;
    
}


#pragma mark - 点击 MainTagSubIcon
- (void)tagClick {

    JSRecommendTagsViewController *tags = [[JSRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
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
