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
@property (nonatomic, copy) NSString *ID;

/**
 *  总数
 */
@property (nonatomic, assign) NSUInteger *count;

/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;

/**
 *  总页数
 */
//@property (nonatomic, assign) NSUInteger total_page;

/**
 *  总数
 */
@property (nonatomic, assign) NSUInteger total;


@property (nonatomic, assign) NSUInteger currentPage;




/**
 *  这个类别对应的用户数据
 */
@property (nonatomic, strong) NSMutableArray *users;

@end
