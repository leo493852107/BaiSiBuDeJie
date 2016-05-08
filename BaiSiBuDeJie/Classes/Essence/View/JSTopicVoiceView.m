//
//  JSTopicVoiceView.m
//  BaiSiBuDeJie
//
//  Created by leo on 5/8/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopicVoiceView.h"
#import "JSTopic.h"
#import <UIImageView+WebCache.h>

@interface JSTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;

@end

@implementation JSTopicVoiceView

+ (instancetype)voiceView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(JSTopic *)topic {
    _topic = topic;
    
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    // 播放时长
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end
