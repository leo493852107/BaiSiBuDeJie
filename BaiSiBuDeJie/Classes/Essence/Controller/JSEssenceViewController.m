//
//  JSEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/21.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSEssenceViewController.h"
#import "JSRecommendTagsViewController.h"
#import "JSAllViewController.h"
#import "JSVideoViewController.h"
#import "JSVoiceViewController.h"
#import "JSPictureViewController.h"
#import "JSWordViewController.h"

@interface JSEssenceViewController () <UIScrollViewDelegate>

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

/**
 *  底部的所有内容
 */
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation JSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpNav];
    
    // 初始化子控制器
    [self setUpChilidVCs];
    
    // 设置顶部的标签栏
    [self setUpTitlesView];
    
    // 底部的scrollView
    [self setUpContentView];
    
    
}

/**
 *  初始化子控制器
 */
- (void)setUpChilidVCs {
    JSWordViewController *word = [[JSWordViewController alloc] init];
    word.title = @"段子";
    [self addChildViewController:word];
    
    JSAllViewController *all = [[JSAllViewController alloc] init];
    all.title = @"全部";
    [self addChildViewController:all];

    JSVideoViewController *video = [[JSVideoViewController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    JSVoiceViewController *voice = [[JSVoiceViewController alloc] init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    JSPictureViewController *picture = [[JSPictureViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    
    
}

/**
 *  设置顶部的标签栏
 */
- (void)setUpTitlesView {
    
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
    titlesView.width = self.view.width;
    titlesView.height = JSTitlesViewH;
    titlesView.y = JSTitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * button.width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
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
    
    [titlesView addSubview:indicatorView];
    
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
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}

#pragma mark - 底部的scrollView
- (void)setUpContentView {
    
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}


#pragma mark - 设置导航栏
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


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 添加子控制器的view
    
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    // 设置控制器view的y值为0（默认20）
    vc.view.y = 0;
    // 设置控制器view的height为整个屏幕的高度（默认是比屏幕高度少个20）
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
    
}

@end
