//
//  NSDate+JSExtension.h
//  BaiSiBuDeJie
//
//  Created by leo on 3/12/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JSExtension)

/**
 *  比较 from 和 self 的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

@end
