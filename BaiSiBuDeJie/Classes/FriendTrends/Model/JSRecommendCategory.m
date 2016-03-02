//
//  JSRecommendCategory.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/23.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSRecommendCategory.h"

@implementation JSRecommendCategory

- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
