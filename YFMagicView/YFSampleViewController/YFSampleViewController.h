//
//  YFSampleViewController.h
//  YFMagicView
//
//  Created by FYWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFSampleViewController : UIViewController

/**
 * 可操作矩形区域 宽 高 的比例,在闭合区间 0.3 和 3 之间
 */
@property(nonatomic,assign)CGFloat gameViewScale;

@property(nonatomic,assign)NSUInteger rows;// 每行多少个
@property(nonatomic,assign)NSUInteger  columns;//每列多少个

/**
 * 如果想操作图片，传进来图片， gameViewScale 比例最好是 图片的 宽高比，图片不会变形
 */
@property(nonatomic,strong)UIImage *gameImage;

/**
 * 如果是拼接的 文字， 请传入一个 正确顺序 文字的 数组，会随机打乱，操作到正确的顺序会 提示成功
 */
@property(nonatomic,strong)NSMutableArray *textArray;

@end

