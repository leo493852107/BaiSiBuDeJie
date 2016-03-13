//
//  JSTopic.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/10/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTopic.h"

@implementation JSTopic

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

@end
