//
//  JSCommentHeaderView.m
//  BaiSiBuDeJie
//
//  Created by leo on 5/23/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSCommentHeaderView.h"

@interface JSCommentHeaderView ()

/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation JSCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    JSCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        // 缓存池中没有，自己创建
        header = [[JSCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = JSGlobalBackGroundColor;
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = JSRGBColor(67, 67, 67);
        label.width = 200;
        label.x = JSTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    
    _title = [title copy];
    
    self.label.text = title;
}

@end
