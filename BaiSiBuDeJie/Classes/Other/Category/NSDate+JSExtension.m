//
//  NSDate+JSExtension.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/12/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "NSDate+JSExtension.h"

@implementation NSDate (JSExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from {
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}

@end
