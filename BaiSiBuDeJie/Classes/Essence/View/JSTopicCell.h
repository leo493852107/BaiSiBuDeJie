//
//  JSTopicCell.h
//  BaiSiBuDeJie
//
//  Created by leo on 3/11/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSTopic;
@interface JSTopicCell : UITableViewCell

/**
 *  帖子数据
 */
@property (nonatomic, strong) JSTopic *topic;

@end
