//
//  JSPushGuideView.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/8/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSPushGuideView.h"

@implementation JSPushGuideView

+ (void)show {
    
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获取沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        JSPushGuideView *guideView = [JSPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


- (IBAction)close {
    [self removeFromSuperview];
}

@end
