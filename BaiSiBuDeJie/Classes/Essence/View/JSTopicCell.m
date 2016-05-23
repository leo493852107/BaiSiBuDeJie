//
//  JSTopicCell.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/11/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopicCell.h"
#import "JSTopic.h"
#import <UIImageView+WebCache.h>
#import "JSTopicPictureView.h"
#import "JSTopicVoiceView.h"
#import "JSTopicVideoView.h"
#import "JSComment.h"
#import "JSUser.h"

@interface JSTopicCell ()

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/**
 *  顶
 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/**
 *  踩
 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/**
 *  分享
 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/**
 *  新浪加V
 */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;

/**
 *  帖子的文字内容
 */
@property (weak, nonatomic) IBOutlet UILabel *text_Label;

/**
 *  图片帖子中间的内容
 */
@property (nonatomic, weak) JSTopicPictureView *pictureView;

/**
 *  声音帖子中间的内容
 */
@property (nonatomic, weak) JSTopicVoiceView *voiceView;

/**
 *  视频帖子中间的内容
 */
@property (nonatomic, weak) JSTopicVideoView *videoView;

/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;


@end

@implementation JSTopicCell

+ (instancetype)cell {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (JSTopicPictureView *)pictureView {
    if (!_pictureView) {
        JSTopicPictureView *pictureView = [JSTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (JSTopicVoiceView *)voiceView {
    if (!_voiceView) {
        JSTopicVoiceView *voiceView = [JSTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (JSTopicVideoView *)videoView {
    if (!_videoView) {
        JSTopicVideoView *videoView = [JSTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(JSTopic *)topic {
    _topic = topic;
    
    // 测试
//    topic.sina_v = arc4random_uniform(100) % 2;
    
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 设置名字
    self.nameLabel.text = topic.name;
    
    // 设置帖子的创建时间
    self.createTimeLabel.text = topic.passtime;
    
    
    // 设置按钮文字
    [self setUpButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setUpButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setUpButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setUpButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    
    // 设置帖子的文字内容
    self.text_Label.text = topic.text;
    
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == JSTopicTypePicture) {
        // 图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == JSTopicTypeVoice) {
        // 声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceViewFrame;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topic.type == JSTopicTypeVideo) {
        // 视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoViewFrame;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    } else {
        // 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    // 处理最热评论 (用hidden 是为了循环利用)
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
    
    
}

#pragma mark - 处理时间
- (void)handleDate:(NSString *)create_time {
    // 当前时间
    NSDate *now = [NSDate date];
    // 发帖时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:create_time];
    
    
    // 日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    // 比较时间
//    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *cmps = [calendar components:unit fromDate:create toDate:now options:0];
//    
//    JSLog(@"%@ --- %@", create, now);
//    JSLog(@"%zd,%zd,%zd,%zd,%zd,%zd", cmps.year,cmps.month,cmps.day,cmps.hour,cmps.minute,cmps.second);

    
    // 获得 NSDate 每一个元素
//    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:now];
//    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:now];
//    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:now];
//    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:now];
//    JSLog(@"%zd,%zd,%zd", cmps.year,cmps.month,cmps.day);
    
    
}

- (void)setUpButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
//    NSString *title = nil;
//    if (count == 0) {
//        title = placeholder;
//    } else if (count > 10000) {
//        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
//    } else {
//        title = [NSString stringWithFormat:@"%zd", count];
//    }
//    [button setTitle:title forState:UIControlStateNormal];

    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = JSTopicCellMargin;
    frame.size.width -= 2 * JSTopicCellMargin;
//    frame.size.height -= JSTopicCellMargin;
    frame.size.height = self.topic.cellHeight - JSTopicCellMargin;
    frame.origin.y += JSTopicCellMargin;
    
    [super setFrame:frame];
}

- (IBAction)more {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    
    [sheet showInView:self.window];
    
}

@end
