//
//  JSCommentHeaderView.h
//  BaiSiBuDeJie
//
//  Created by leo on 5/23/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSCommentHeaderView : UITableViewHeaderFooterView

/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
