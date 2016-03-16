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
#import "JSProgressView.h"
#import "JSShowPictureViewController.h"

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

/**
 *  进度条控件
 */
@property (weak, nonatomic) IBOutlet JSProgressView *progressView;

@end

@implementation JSTopicPictureView

+ (instancetype)pictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.image_View.userInteractionEnabled = YES;
    
    [self.image_View addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture {
    JSShowPictureViewController *showPicture = [[JSShowPictureViewController alloc] init];
    showPicture.topic = self.topic;

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
    
}

- (void)setTopic:(JSTopic *)topic {
    _topic = topic;
    
    /**
     *  在不知道图片扩展名的情况下，如何知道图片的真实类型？
        答：取出图片数据的第一个字节，就可以判断出图片的真实类型
     */
    
    // 立马显示最新的进度值(防止因为网速慢，导致显示的是其他图片的下载进度)
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    // 设置图片
    [self.image_View sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        // 计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
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
