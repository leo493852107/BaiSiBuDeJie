//
//  JSShowPictureViewController.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/14/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSShowPictureViewController.h"
#import "JSTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface JSShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) UIImageView *image_View;

@end

@implementation JSShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 屏幕尺寸
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 添加图片
    UIImageView *image_View = [[UIImageView alloc] init];
    image_View.userInteractionEnabled = YES;
    [image_View addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:image_View];
    self.image_View = image_View;

    // 图片尺寸
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > screenH) {
        // 图片显示高度超过一个屏幕 需要滚动查看
        image_View.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
        
        
    } else {
        image_View.size = CGSizeMake(pictureW, pictureH);
        image_View.centerY = screenH * 0.5;
    }
    
    [image_View sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    
    
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 将图片保存到相册
- (IBAction)save {
    UIImageWriteToSavedPhotosAlbum(self.image_View.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

// 保存成功
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

@end
