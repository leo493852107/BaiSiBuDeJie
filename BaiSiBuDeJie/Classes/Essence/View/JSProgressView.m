//
//  JSProgressView.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/15/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSProgressView.h"

@implementation JSProgressView

- (void)awakeFromNib {
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}

@end
