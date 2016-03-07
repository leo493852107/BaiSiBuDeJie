//
//  JSRecommendUserCell.m
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/24.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "JSRecommendUserCell.h"
#import "JSRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface JSRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation JSRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(JSRecommendUser *)user {
    //
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount = nil;
    NSInteger i = [user.fans_count integerValue];
    if (i < 10000) {
        fansCount = [NSString stringWithFormat:@"%ld人关注", (long)i];
    } else {
        
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", i / 10000.0];
    }
    
    self.fansCountLabel.text = fansCount;
    [self.headerImageView sd_setImageWithURL:user.header placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
