//
//  YFBaseVerticalHandle.h
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFMVViewModel.h"

#import "YFBaseCubeView.h"

#import "YFMagicGameView.h"

@interface YFBaseVerticalHandle : NSObject

@property(nonatomic,weak)YFMVViewModel *firstModel;

@property(nonatomic,weak)YFMVViewModel *lastModel;

@property(nonatomic,weak)YFBaseCubeView *shareView;

@property(nonatomic,weak)NSMutableArray *modelArray;

@property(nonatomic,assign)NSInteger firstNum;

@property(nonatomic,assign)NSInteger LastNum;

@property(nonatomic,weak)YFMagicGameView *magicView;

/**
 *  开始移动的坐标
 */
@property(nonatomic,assign)CGPoint beginPointFromPan;

@property(nonatomic,assign)CGPoint lastPoint;

-(void)handleWithPoint:(CGPoint)point gapY:(CGFloat )gapY;

-(void)panGest:(UIPanGestureRecognizer *)panGes endPoint:(CGPoint)point;

/**
 * 交换 第一个View
 */
-(void)exchangeShareViewWithFirstView;

/**
 * 第一个View 交换后设置公用View 的frame 只是在滑动过程中有
 */
-(void)setShareViewCenterAfterExchangeWithFirstView;


/**
 * 交换最后一个View
 */
-(void)exchangeShareViewWithLastView;

/**
 * 最后一个View 交换后设置公用View 的frame 只是在滑动过程中有
 */
-(void)setShareViewCenterAfterExchangeWithLastView;

@end
