//
//  UIImage+YFCategory.h
//  YFMagicView
//
//  Created by FYWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YFCategory)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageNaviWithColor:(UIColor *)color;

/**
 * 分割一张图片， row 几行,从 1 开始，column 几列，从 1 开始，返回 分割后的 图片数组
 */
- (NSMutableArray *)imageCutRow:(NSUInteger)row column:(NSUInteger)column;

@end
