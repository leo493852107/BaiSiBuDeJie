//
//  UIBarButtonItem+JSExtension.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/22.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "UIBarButtonItem+JSExtension.h"

@implementation UIBarButtonItem (JSExtension)

+ (instancetype)initWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    // 监听事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
    
}

@end
