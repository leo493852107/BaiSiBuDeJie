//
//  JSRecommendCategoryCell.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/23.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSRecommendCategoryCell.h"
#import "JSRecommendCategory.h"


@interface JSRecommendCategoryCell ()

/**
 *  选中时显示的指示器控件
 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation JSRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = JSRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = JSRGBColor(219, 21, 26);
//    self.textLabel.textColor = JSRGBColor(78, 78, 78);
//    self.textLabel.highlightedTextColor = JSRGBColor(219, 21, 26);
    
//    UIView *bg = [[UIView alloc] init];
//    bg.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = bg;

}

- (void)setCategory:(JSRecommendCategory *)category {
    _category = category;
    
    self.textLabel.text = category.name;
    self.textLabel.font = [UIFont systemFontOfSize:11];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : JSRGBColor(78, 78, 78);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 重新调整内部 textLabel 的 frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;

}

@end
