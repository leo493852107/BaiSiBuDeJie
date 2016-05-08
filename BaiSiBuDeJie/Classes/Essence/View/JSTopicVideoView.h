//
//  JSTopicVideoView.h
//  BaiSiBuDeJie
//
//  Created by leo on 5/8/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSTopic;
@interface JSTopicVideoView : UIView

+ (instancetype)videoView;

/** 帖子数据 */
@property (nonatomic, strong) JSTopic *topic;

@end
