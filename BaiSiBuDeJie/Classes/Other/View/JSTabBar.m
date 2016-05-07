//
//  JSTabBar.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/21.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSTabBar.h"
#import "JSPublishView.h"

#define TabBarButtonCount 5

@interface JSTabBar ()

/**
 *  发布按钮
 */
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation JSTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 设置 tabbar 的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

        // 添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

//UIWindow *window;

- (void)publishClick {
    // 窗口级别
    // UIWindowLevelNormal < UIWindowLevelStatusBar < UIWindowLevelAlert
    
//    window = [[UIWindow alloc] init];
//    window.frame = [UIScreen mainScreen].bounds;
//    window.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
//    window.hidden = NO;
    
    [JSPublishView show];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他 UITabBarButton 的 frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / TabBarButtonCount;
    CGFloat buttonH = height;
    NSUInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")] || button == self.publishButton) {
            continue;
        }
        CGFloat buttonX = buttonW * ((index > 1) ? (index + 1): index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
    
    
}

@end
