//
//  JSTopWindow.m
//  BaiSiBuDeJie
//
//  Created by leo on 5/23/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopWindow.h"

@implementation JSTopWindow

static UIWindow *window_;

static UIWindow *window_;

+ (void)initialize {
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, JSScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    //    window_.backgroundColor = [UIColor redColor];
    
    
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    
}

+ (void)show {
    window_.hidden = NO;
}

+ (void)windowClick {
    // 1.scrollView
    // 2.keyWindow
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview {
    for (UIScrollView *subview in superview.subviews) {
        
        // 转换坐标系
        CGRect newFrame = [subview.superview convertRect:subview.frame toView:[UIApplication sharedApplication].keyWindow];
        
        // nil 默认指 [UIApplication sharedApplication].keyWindow]
        //        CGRect newFrame = [subview.superview convertRect:subview.frame toView:nil];
        
        //        CGRectIntersectsRect(<#CGRect rect1#>, <#CGRect rect2#>)
        
        // 如果是 ScrollView ，滚到最顶部
        if ([subview isKindOfClass:[UIScrollView class]]) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

@end
