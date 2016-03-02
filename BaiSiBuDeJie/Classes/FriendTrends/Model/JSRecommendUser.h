//
//  JSRecommendUser.h
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/24.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSRecommendUser : NSObject

/**
 *  头像
 */
@property (nonatomic, strong) NSURL *header;

/**
 *  粉丝数
 */
@property (nonatomic, copy) NSString *fans_count;

/**
 *  昵称
 */
@property (nonatomic, copy) NSString *screen_name;

@end
