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

@interface JSPublishViewController ()

/**
 *  标语
 */
@property (nonatomic, strong) UIImageView *sloganView;

@end

@implementation JSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = JSScreenH * 0.2;
    sloganView.centerX = JSScreenW * 0.5;
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    
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
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        button.width = buttonW;
        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = buttonStartY + row * buttonH;
        [self.view addSubview:button];
    }
    
    
}


- (IBAction)cancel {
    [self dismissViewControllerAnimated:NO completion:nil];
}


/**
    pop 和 Core Animaiton 的区别
    1.Core Animaiton 的动画只能添加到layer上
    2.pop 的动画能添加到任何对象
    3.pop 的底层并非基于Core Animation， 是基于CADisplayLink
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    
//    animation.springBounciness = 20;
//    animation.springSpeed = 20;
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    
//    [self.sloganView pop_addAnimation:animation forKey:nil];
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    animation.beginTime = CACurrentMediaTime() + 1.0;
    animation.springBounciness = 20;
    animation.springSpeed = 20;
    animation.fromValue = @(self.sloganView.layer.position.y);
    animation.toValue = @(300);
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        JSLog(@"动画结束");
    };
    
    [self.sloganView.layer pop_addAnimation:animation forKey:nil];
}


@end
