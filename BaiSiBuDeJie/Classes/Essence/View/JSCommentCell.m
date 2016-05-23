//
//  JSCommentCell.m
//  BaiSiBuDeJie
//
//  Created by leo on 5/23/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSCommentCell.h"
#import "JSComment.h"
#import "JSUser.h"
#import <UIImageView+WebCache.h>

@interface JSCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sexView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end

@implementation JSCommentCell

- (void)setComment:(JSComment *)comment {
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexView.image = [comment.user.sex isEqualToString:JSUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.userNameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
