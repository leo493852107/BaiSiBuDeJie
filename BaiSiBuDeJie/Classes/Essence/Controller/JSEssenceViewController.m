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

/**
 *  标签栏底部的红色指示器
 */
@property (nonatomic, weak) UIView *indicatorView;

/**
 *  当前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

/**
 *  顶部的所有标签
 */
@property (nonatomic, weak) UIView *titlesView;

@end

@implementation JSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpNav];
    
    // 设置顶部的标签栏
    [self setUpTitlesView];
    
    // 底部的scrollView
    [self setUpContentView];
    
    
}

/**
 *  设置顶部的标签栏
 */
- (void)setUpTitlesView {
    
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 内部子标签
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * button.width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        // 强制布局(强制更新子控件的frame)
//        [button layoutIfNeeded];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedBtn = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
//            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;

            self.indicatorView.centerX = button.centerX;
        }
    }
    
    
    
}

- (void)titleClick:(UIButton *)button {
    // 修改按钮状态
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
}

/**
 *  底部的scrollView
 */
- (void)setUpContentView {
    
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
//    contentView.backgroundColor = [UIColor redColor];
    contentView.frame = self.view.bounds;
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    [self.view insertSubview:contentView atIndex:0];
    
    
}


/**
 *  设置导航栏
 */
- (void)setUpNav {
    
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
