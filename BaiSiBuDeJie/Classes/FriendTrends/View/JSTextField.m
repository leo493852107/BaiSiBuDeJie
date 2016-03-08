//
//  JSTextField.m
//  BaiSiBuDeJie
//
//  Created by leo on 3/7/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import "JSTextField.h"
#import <objc/runtime.h>

static NSString * const JSPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation JSTextField

//+ (void)initialize {
//    unsigned int count = 0;
//    
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//
//    for (int i = 0; i < count; i++) {
//        // 取出成员变量
//        Ivar ivar = *(ivars + i);
//        
//        // 打印成员变量名字
//        JSLog(@"%s", ivar_getName(ivar));
//        
//    }
//    
//    // 释放
//    free(ivars);
//    
//}


- (void)awakeFromNib {
//    UILabel *placeholderLabel = [self valueForKeyPath:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor redColor];
    
    // 修改占位文字颜色
//    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
    
}

/**
 *  当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder {
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:JSPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 *  当前文本框失去焦点时就会调用
 */

- (BOOL)resignFirstResponder {
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:JSPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}

//- (void)setPlaceholderColor:(UIColor *)placeholderColor {
//    _placeholderColor = placeholderColor;
//    // 修改占位文字颜色
//    [self setValue:placeholderColor forKeyPath:JSPlaceholderColorKeyPath];
//}


//- (void)drawPlaceholderInRect:(CGRect)rect {
//    [self.placeholder drawInRect:rect withAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],
//          NSFontAttributeName : self.font}];
//}

@end
