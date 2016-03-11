//
//  JSTopicCell.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/11/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopicCell.h"
#import "JSTopic.h"
#import "UIImageView+WebCache.h"

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

@end

@implementation JSTopicCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(JSTopic *)topic {
    _topic = topic;
    
    // 设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.created_at;
    
    // 设置按钮文字
    [self setUpButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setUpButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setUpButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setUpButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
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
    
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
