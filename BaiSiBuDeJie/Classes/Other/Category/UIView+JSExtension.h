//
//  UIView+JSExtension.h
//  BaiSiBuDeJie
//
//  Created by leo on 16/2/21.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JSExtension)

/**
 *  在分类中声明 @property ，只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量
 */

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;




@end
