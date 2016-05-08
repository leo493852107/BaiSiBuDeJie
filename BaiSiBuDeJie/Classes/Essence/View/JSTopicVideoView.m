//
//  JSTopicVideoView.m
//  BaiSiBuDeJie
//
//  Created by leo on 5/8/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopicVideoView.h"
#import "JSTopic.h"
#import <UIImageView+WebCache.h>
#import "JSShowPictureViewController.h"

@interface JSTopicVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end

@implementation JSTopicVideoView


+ (instancetype)videoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给声音添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture {
    JSShowPictureViewController *showPicture = [[JSShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
    
}

- (void)setTopic:(JSTopic *)topic {
    _topic = topic;
    
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}

@end
