//
//  JSTopic.h
//  BaiSiBuDeJie
//
//  Created by leo on 3/10/16.
//  Copyright © 2016 leo. All rights reserved.
//  帖子

#import <UIKit/UIKit.h>

@class JSComment;

@interface JSTopic : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;

/** 名称 */
@property (nonatomic, copy) NSString *name;

/** 头像的图片url地址 */
@property (nonatomic, copy) NSString *profile_image;

/** 创建帖子的时间 */
@property (nonatomic, copy) NSString *create_time;

/** 帖子通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 帖子的内容 */
@property (nonatomic, copy) NSString *text;

/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;

/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;

/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;

/** 帖子的被评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 是否为新浪加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;

/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;

/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;

/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;

/** 帖子类型 */
@property (nonatomic, assign) JSTopicType type;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;

/** 最热评论 */
@property (nonatomic, strong) JSComment *top_cmt;


/**
 *  额外的辅助属性
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/**
 *  图片控件的frame
 */
@property (nonatomic, assign, readonly) CGRect pictureViewFrame;

/**
 *  图片是否太大
 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/**
 *  图片的下载进度
 */
@property (nonatomic, assign) CGFloat pictureProgress;


/**
 *  声音控件的frame
 */
@property (nonatomic, assign, readonly) CGRect voiceViewFrame;

/**
 *  视频控件的frame
 */
@property (nonatomic, assign, readonly) CGRect videoViewFrame;


@end
