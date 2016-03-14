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
    
    /**
     *  在不知道图片扩展名的情况下，如何知道图片的真实类型？
        答：取出图片数据的第一个字节，就可以判断出图片的真实类型
     */
    
    // 设置图片
    [self.image_View sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 判断是否为 gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示 “点击查看全图”
    if (topic.isBigPicture) {
        // 大图
        self.seeBigButton.hidden = NO;
        self.image_View.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        // 非大图
        self.seeBigButton.hidden = YES;
        self.image_View.contentMode = UIViewContentModeScaleToFill;
    }
    
    
}

@end
