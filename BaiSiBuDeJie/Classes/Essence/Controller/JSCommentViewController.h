//
//  JSCommentViewController.h
//  BaiSiBuDeJie
//
//  Created by leo on 5/22/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSTopic;

@interface JSCommentViewController : UIViewController

/** 帖子模型 */
@property (nonatomic, strong) JSTopic *topic;

@end
