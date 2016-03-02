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
    self.fansCountLabel.text = [NSString stringWithFormat:@"%@人关注", user.fans_count];
    [self.headerImageView sd_setImageWithURL:user.header placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
