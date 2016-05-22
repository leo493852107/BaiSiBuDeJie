//
//  JSConstant.h
//  BaiSiBuDeJie
//
//  Created by leo on 3/11/16.
//  Copyright © 2016 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    JSTopicTypeAll = 1,
    JSTopicTypePicture = 10,
    JSTopicTypeWord = 29,
    JSTopicTypeVoice = 31,
    JSTopicTypeVideo = 41
} JSTopicType;

/** 精华-所有顶部标题的高度 */
UIKIT_EXTERN CGFloat const JSTitlesViewH;

/** 精华-所有顶部标题的Y */
UIKIT_EXTERN CGFloat const JSTitlesViewY;

/** 精华 cell 间距 */
UIKIT_EXTERN CGFloat const JSTopicCellMargin;

/** 精华 cell 文字内容的Y值  */
UIKIT_EXTERN CGFloat const JSTopicCellTextY;

/** 精华 cell 最热评论标题的高度  */
UIKIT_EXTERN CGFloat const JSTopicCellTopCmtTitleH;

/** 精华 cell 底部工具条的高度 */
UIKIT_EXTERN CGFloat const JSTopicCellBottomBarH;


/** 精华 cell 图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const JSTopicCellPictureMaxH;

/** 精华 cell 图片帖子一旦超过最大高度，就使用 Standard */
UIKIT_EXTERN CGFloat const JSTopicCellPictureStandardH;


/** JSUser模型-性别属性值 */
UIKIT_EXTERN NSString * const JSUserSexMale;
UIKIT_EXTERN NSString * const JSUserSexFemale;

