//
//  JSTopicPictureView.h
//  BaiSiBuDeJie
//
//  Created by leo on 3/14/16.
//  Copyright © 2016 leo. All rights reserved.
//  图片帖子中间的内容

#import <UIKit/UIKit.h>

@class JSTopic;
@interface JSTopicPictureView : UIView

+ (instancetype)pictureView;

/**
 *  帖子数据
 */
@property (nonatomic, strong) JSTopic *topic;

@end
