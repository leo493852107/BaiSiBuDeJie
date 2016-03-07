   //
//  JSRecommendTagCell.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/3/2.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSRecommendTagCell.h"
#import "JSRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface JSRecommendTagCell ()


@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;


@end

@implementation JSRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendTag:(JSRecommendTag *)recommendTag {
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%lu人订阅", (unsigned long)recommendTag.sub_number];
    } else {
        
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", (unsigned long)recommendTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;

    
}

#pragma mark - 过滤
- (void)setFrame:(CGRect)frame {
    // cell之间的间隙
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
