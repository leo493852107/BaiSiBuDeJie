//
//  JSTopicViewController.h
//  BaiSiBuDeJie
//
//  Created by leo on 3/13/16.
//  Copyright © 2016 leo. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>


@interface JSTopicViewController : UITableViewController

/**
 *  帖子的类型(交给子类去实现)
 */
@property (nonatomic, assign) JSTopicType type;

@end
