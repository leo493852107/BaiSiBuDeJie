//
//  JSTopic.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/10/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopic.h"
#import <MJExtension.h>

//@interface JSTopic ()
//{
//    CGFloat _cellHeight;
//}
//
//@end

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
        _cellHeight = JSTopicCellTextY + textH + JSTopicCellBottomBarH + 2 * JSTopicCellMargin + self.height;
    }
    
    
    return _cellHeight;
}

@end
