//
//  JSTopicVoiceView.h
//  BaiSiBuDeJie
//
//  Created by leo on 5/8/16.
//  Copyright © 2016 leo. All rights reserved.
//  声音帖子内容

#import <UIKit/UIKit.h>

@class JSTopic;
@interface JSTopicVoiceView : UIView

+ (instancetype)voiceView;

@property (nonatomic, strong) JSTopic *topic;

@end
