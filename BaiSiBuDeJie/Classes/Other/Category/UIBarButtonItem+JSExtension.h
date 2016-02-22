//
//  UIBarButtonItem+JSExtension.h
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/22.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JSExtension)

+ (instancetype)initWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
