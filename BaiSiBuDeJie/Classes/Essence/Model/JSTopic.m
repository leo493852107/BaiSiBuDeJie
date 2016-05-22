//
//  JSTopic.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/10/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopic.h"
#import <MJExtension.h>
#import "JSComment.h"
#import "JSUser.h"

@implementation JSTopic
{
    @private
    CGFloat _cellHeight;
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" :@"image2"
             };
}

+ (NSDictionary *)objectClassInArray {
    return @{@"top_cmt" : [JSComment class]};
}

- (NSString *)passtime {
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子创建时间
    NSDate *create = [fmt dateFromString:_passtime];
    
    if (create.isThisYear) {
        // 今年
        if (create.isToday) {
            // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) {
                // 时间差距 >= 1 hour
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
            
        } else if (create.isYesterday) {
            // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else {
            // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else {
        // 非今年
        return _passtime;
    }
    
    
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {

        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * JSTopicCellMargin, MAXFLOAT);
        // 计算文字的高度 
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // cell的高度
        // 文字部分的高度
        _cellHeight = JSTopicCellTextY + textH + JSTopicCellMargin;
        
        // 根据段子的类型来计算cell的高度
        if (self.type == JSTopicTypePicture) {
            // 图片显示出来的宽度,高度
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= JSTopicCellPictureMaxH) {
                // 图片高度过长
                pictureH = JSTopicCellPictureStandardH;
                // 大图
                self.bigPicture = YES;
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = JSTopicCellMargin;
            CGFloat pictureY = JSTopicCellTextY + textH + JSTopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            // 图片
            _cellHeight += pictureH + JSTopicCellMargin;
            
        } else if (self.type == JSTopicTypeVoice) {
            // 声音帖子
            CGFloat voiceX = JSTopicCellMargin;
            CGFloat voiceY = JSTopicCellTextY + textH + JSTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + JSTopicCellMargin;
        } else if (self.type == JSTopicTypeVideo) {
            // 视频帖子
            CGFloat videoX = JSTopicCellMargin;
            CGFloat videoY = JSTopicCellTextY + textH + JSTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + JSTopicCellMargin;

        }
        
        JSComment *cmt = self.top_cmt.firstObject;
        if (cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += JSTopicCellTopCmtTitleH + contentH + JSTopicCellMargin;
        }
        
        // 底部工具条的高度
        _cellHeight += JSTopicCellBottomBarH + JSTopicCellMargin;
    }
    
    
    return _cellHeight;
}

@end
