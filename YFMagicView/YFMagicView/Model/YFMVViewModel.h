//
//  YFMVViewModel.h
//  YFMagicView
//
//  Created by FYWCQ on 16/7/27.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFBaseCubeView.h"

@interface YFMVViewModel : NSObject

/**
 * View
 */
@property(nonatomic,strong)YFBaseCubeView *cubeView;

/**
 * replace View
 */
@property(nonatomic,strong)UIView *viewForReplace;

/**
 * 第几个 从 0 开始
 */
@property(nonatomic,assign)NSInteger indexForArray;

/**
 * 正确的顺序， 第几个,从 0 开始
 */
@property(nonatomic,assign)NSUInteger correctIndex;

@end
