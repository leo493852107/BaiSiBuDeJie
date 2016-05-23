//
//  JSComment.m
//  BaiSiBuDeJie
//
//  Created by leo on 5/8/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSComment.h"
#import <MJExtension.h>

@implementation JSComment

/**
    Description
    将属性名换为其他key去字典中取值
    Returns
    字典中的key是属性名，value是从字典中取值用的key
*/
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end
