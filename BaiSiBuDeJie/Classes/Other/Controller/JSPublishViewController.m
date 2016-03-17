//
//  JSPublishViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/16/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSPublishViewController.h"
#import "JSVerticalButton.h"
#import <POP.h>

static CGFloat const JSAnimationDelay = 0.05;
static CGFloat const JSSpringFactor = 10;

@interface JSPublishViewController ()


@property (nonatomic, copy) void (^complectionBlock)();

@end

@implementation JSPublishViewController


- (void)test:(void (^)())abc {
//- (void)test:(void (^)())completionBlock {
    void (^block)() = ^{
        
    };
    block();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 让控制器的 view 不能被点击
    self.view.userInteractionEnabled = NO;
    
    
    // 数据
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    // 中间的6个按钮
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (JSScreenH - 2 * buttonH) * 0.5;
    int maxCols = 3;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (JSScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i < images.count; i++) {
        JSVerticalButton *button = [[JSVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //  计算 X Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginX = buttonEndY - JSScreenH;
        
        // 添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginX, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = JSSpringFactor;
        anim.springSpeed = JSSpringFactor;
        anim.beginTime = CACurrentMediaTime() + JSAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
        
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    
    // 标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = JSScreenW * 0.5;
    CGFloat centerEndY = JSScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - JSScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * JSAnimationDelay;
    anim.springBounciness = JSSpringFactor;
    anim.springSpeed = JSSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画执行完毕，恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];

    [sloganView pop_addAnimation:anim forKey:nil];

    
}


#pragma mark - 先执行退出动画，动画完毕后执行 complectionBlock
- (void)cancelWithComplectionBlock:(void (^)())complectionBlock {
    
    // 让控制器的 view 不能被点
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i < self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerEndY = subview.centerY + JSScreenH;
        // 动画的执行节奏（一开始很慢，后面很快）
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerEndY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * JSAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行传进来的 complectionBlock 参数
//                if (complectionBlock) {
//                    complectionBlock();
//                }
                !complectionBlock ? : complectionBlock();
                
            }];
        }
    }
}

- (void)buttonClick:(UIButton *)button {
    [self cancelWithComplectionBlock:^{
        if (button.tag == 0) {
            JSLog(@"发视频");
        }
    }];
}


- (IBAction)cancel {
    [self cancelWithComplectionBlock:nil];
    
}


/**
    pop 和 Core Animaiton 的区别
    1.Core Animaiton 的动画只能添加到layer上
    2.pop 的动画能添加到任何对象
    3.pop 的底层并非基于Core Animation， 是基于CADisplayLink
    4.Core Animaiton 的动画仅仅是表象，并不会修改对象的 frame、size等值
    5.pop 动画实时修改对象的属性，真正地修改了对象的属性
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelWithComplectionBlock:nil];
}


@end
