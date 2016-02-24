//
//  JSRecommendCategory.h
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/23.
//  Copyright © 2016年 leo. All rights reserved.
//  推荐关注 左边的数据模型

#import <Foundation/Foundation.h>

@interface JSRecommendCategory : NSObject

/**
 *  id
 */
@property (nonatomic, copy) NSString *id;

/**
 *  总数
 */
@property (nonatomic, copy) NSString *count;

/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;

@end
