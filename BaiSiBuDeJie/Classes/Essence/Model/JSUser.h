//
//  JSUser.h
//  BaiSiBuDeJie
//
//  Created by leo on 5/8/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;

/** 性别 */
@property (nonatomic, copy) NSString *sex;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
