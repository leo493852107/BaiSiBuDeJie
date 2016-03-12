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
    
    // 处理时间
    [self handleDate:topic.created_at];
    
    // 设置按钮文字
    [self setUpButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setUpButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setUpButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setUpButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
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
    
    JSLog(@"%@", [now deltaFrom:create]);
    
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
    
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end