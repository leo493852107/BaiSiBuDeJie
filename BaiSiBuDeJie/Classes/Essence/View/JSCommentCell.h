//
//  JSCommentCell.h
//  BaiSiBuDeJie
//
//  Created by leo on 5/23/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSComment;

@interface JSCommentCell : UITableViewCell

/** 评论 */
@property (nonatomic, strong) JSComment *comment;

@end
