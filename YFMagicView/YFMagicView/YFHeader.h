//
//  YFHeader.h
//  YFMagicView
//
//  Created by FYWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#ifndef YFHeader_h
#define YFHeader_h

static CGFloat const YFAnimationTimeInterval = 0.30f;

//-- MD_MULTILINE_TEXTSIZE  字体内容多少判断label的size
#define YF_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;

#define  FYImageValidScale  3.0

#if DEBUG

#define DebugLog(...) NSLog(__VA_ARGS__)
#define YFAssert(condition,b) NSAssert(condition, b)

#else

#define YFAssert(condition,b)
#define DebugLog(...)

#endif

/**
 * 屏幕高度
 */
#define SH_YF [UIScreen mainScreen].bounds.size.height
/**
 * 屏幕宽度
 */
#define SW_YF [UIScreen mainScreen].bounds.size.width


#endif /* YFHeader_h */
