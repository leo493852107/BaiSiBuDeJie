//
//  JSTabBarController.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/20.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSTabBarController.h"
#import "JSEssenceViewController.h"
#import "JSNewViewController.h"
#import "JSFriendTrendsViewController.h"
#import "JSMeViewController.h"

#import "JSTabBar.h"

@interface JSTabBarController ()

@end

@implementation JSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置 UITabBarItem 文字属性
    [self setUpTitleTextAttributes];
    
    // 设置所有 TabBarItem
    [self setUpAllTabBarItem];
    
    
}

#pragma mark - 设置 UITabBarItem 文字属性
- (void)setUpTitleTextAttributes {
    // 通过 appearance 统一设置所有 UITabBarItem 的文字属性
    // 后面带有 UI_APPEARANCE_SELECTOR 的方法，都可以通过 appearance 对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark - 设置所有 TabBarItem
- (void)setUpAllTabBarItem {
    
    // 精华
    JSEssenceViewController *essence = [[JSEssenceViewController alloc] init];
    [self setUpChildTabBarItemWithImage:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] ViewController:essence title:@"精华"];
    
    // 新帖
    JSNewViewController *new = [[JSNewViewController alloc] init];
    [self setUpChildTabBarItemWithImage:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"] ViewController:new title:@"新帖"];
    
    // 关注
    JSFriendTrendsViewController *friendTrends = [[JSFriendTrendsViewController alloc] init];
    [self setUpChildTabBarItemWithImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] ViewController:friendTrends title:@"关注"];
    
    // 我
    JSMeViewController *me = [[JSMeViewController alloc] init];
    [self setUpChildTabBarItemWithImage:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageNamed:@"tabBar_me_click_icon"] ViewController:me title:@"我"];
    
    
    // 更换tabBar
    // KVC
    [self setValue:[[JSTabBar alloc] init] forKey:@"tabBar"];

}

#pragma mark - 设置每个 TabBarItem
- (void)setUpChildTabBarItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage ViewController:(UIViewController *)vc title:(NSString *)title {
    // 添加子控制器
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    // 设置图片样式为原始图片
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectedImage;
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    // 包装一个导航控制器，添加导航控制器为 tabBarController 的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    [self addChildViewController:nav];
}


@end
