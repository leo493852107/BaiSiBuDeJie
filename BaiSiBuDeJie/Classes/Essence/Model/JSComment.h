//
//  JSComment.h
//  BaiSiBuDeJie
//
//  Created by leo on 5/8/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSUser;

@interface JSComment : NSObject

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;

/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;

/** 用户 */
@property (nonatomic, strong) JSUser *user;


@end
