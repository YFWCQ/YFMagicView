//
//  YFMagicGameView.h
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YFBaseHandle.h"


typedef NS_ENUM(NSInteger, YFPanGestureBeginDirecion) {
    YFPanGestureBeginDirecionNone,
    
    YFPanGestureBeginDirecionHorizontal,
    
    YFPanGestureBeginDirecionVertical,
    
    YFPanGestureBeginDirecionNoHandle,
    
    YFPanGestureBeginDirecionFailPass,
    
    YFPanGestureBeginDirecionCheckIfIsSuccess,// 禁止手势滑动，执行手势结束的方法，检查是否成功，不成功则成仁
    
    
    YFPanGestureBeginDirecionError
};

@class YFBaseHandle;
@interface YFMagicGameView : UIView

/**
 * 所有的方块 放到这的数组
 */
@property(nonatomic,strong)NSMutableArray *arrayForCube;

/**
 *   每行有几个 View
 */
@property(nonatomic,assign)NSUInteger rows;

/**
 *  每列有几个 View
 */
@property(nonatomic,assign)NSUInteger columns;

/**
 *  每个方格的宽
 */
@property(nonatomic,assign)CGFloat perCubeWidth;

/**
 *  每个方格的高
 */
@property(nonatomic,assign)CGFloat perCubeHeight;

/**
 *  移动手势的处理基类
 */
@property(nonatomic,strong)YFBaseHandle *logicHandle;

/**
 * 滑动情况 的 判断
 */
@property(nonatomic,assign)YFPanGestureBeginDirecion directionForPan;

/**
 *  开始移动的坐标
 */
@property(nonatomic,assign)CGPoint beginPointFromPan;

/**
 * 各种属性设置完毕 加载游戏界面
 */
-(void)loadPlayGameView;

/**
 * 检查是否成功
 */
-(void)checkSucceed;


/**
 * 图片
 */
@property(nonatomic,strong)UIImage *gameImage;

/**
 * 如果是拼接的 文字， 请传入一个 正确顺序 文字的 数组，会随机打乱，操作到正确的顺序会 提示成功
 */
@property(nonatomic,strong)NSMutableArray *textArray;


/**
 * 成功闯关后 调用 的Block
 */
@property(nonatomic,copy)void(^successBlock)();

// 策略模式 ，最后一步，检查错误还是成功
@property(nonatomic,copy)void(^failBlock)();


// 失败后，再开始前，需要调用
-(void)whenBeginAfterFail;
/**
 * 每次 增加一步，都调用一次
 */
@property(nonatomic,copy)void(^whenStepsAddedBlock)(NSUInteger);

/**
 * 每当停止滑动的时候，调用，
 */
@property(nonatomic,copy)void(^playWhenStepCompleted)();


@end
