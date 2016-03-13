//
//  JSTopicViewController.h
//  BaiSiBuDeJie
//
//  Created by leo on 3/13/16.
//  Copyright © 2016 leo. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>

typedef enum{
    JSTopicTypeAll = 1,
    JSTopicTypePicture = 10,
    JSTopicTypeWord = 29,
    JSTopicTypeVoice = 31,
    JSTopicTypeVideo = 41
} JSTopicType;

@interface JSTopicViewController : UITableViewController

/**
 *  帖子的类型(交给子类去实现)
 */
@property (nonatomic, assign) JSTopicType type;

@end
