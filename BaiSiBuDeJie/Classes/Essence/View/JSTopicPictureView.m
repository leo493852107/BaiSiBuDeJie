//
//  JSTopicPictureView.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/14/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopicPictureView.h"
#import "JSTopic.h"
#import <UIImageView+WebCache.h>

@interface JSTopicPictureView ()

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *image_View;

/**
 *  gif标识
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;

/**
 *  查看大图按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation JSTopicPictureView

+ (instancetype)pictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(JSTopic *)topic {
    _topic = topic;
    
    // 设置图片
    [self.image_View sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    
}

@end
