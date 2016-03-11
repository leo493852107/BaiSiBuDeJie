//
//  JSTopic.h
//  BaiSiBuDeJie
//
//  Created by leo on 3/10/16.
//  Copyright © 2016 leo. All rights reserved.
//  帖子

#import <Foundation/Foundation.h>

@interface JSTopic : NSObject

/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  头像的图片url地址
 */
@property (nonatomic, copy) NSString *profile_image;

/**
 *  创建帖子的时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  帖子的内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  顶的数量
 */
@property (nonatomic, assign) NSInteger ding;

/**
 *  踩的数量
 */
@property (nonatomic, assign) NSInteger cai;

/**
 *  转发的数量
 */
@property (nonatomic, assign) NSInteger repost;

/**
 *  帖子的被评论数量
 */
@property (nonatomic, assign) NSInteger comment;

@end
