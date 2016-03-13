//
//  JSRecommendCategory.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/23.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSRecommendCategory.h"
#import <MJExtension.h>

@implementation JSRecommendCategory

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

//+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName {
//    if ([propertyName isEqualToString:@"ID"]) {
//        return @"id";
//    }
//    return propertyName;
//}

- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
