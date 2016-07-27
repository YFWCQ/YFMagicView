//
//  YFHorizonHandle.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFHorizonHandle.h"

#import "YFMVViewModel.h"

#import "YFLeftDirectionHandle.h"
#import "YFRightDirectionHandle.h"
#import "YFShareInstance.h"
#import "YFHeader.h"

@interface YFHorizonHandle ()

// 左滑右滑 处理 类
@property(nonatomic,strong)YFLeftDirectionHandle *leftHandle;
@property(nonatomic,strong)YFRightDirectionHandle *rightHandle;

@end

@implementation YFHorizonHandle
{
    CGFloat _beginY;
    
    CGFloat _endY;
    
    NSUInteger _rowOfSelect;
    
    CGFloat _gapXX;
    
    YFBaseHorizonHandle *_handleForLR;
    
    // 横向 滑动的 第一个 元素的 下标 >= 0
    NSInteger _firstNum;
    
    // 横向 滑动的 最后一个 元素的 下标
    NSInteger _lastNum;
}


-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _leftHandle = [[YFLeftDirectionHandle alloc] init];
        
        _rightHandle = [[YFRightDirectionHandle alloc] init];
        
        
        _leftHandle.modelArray = [YFShareInstance sharedInstance].modelArray;
        
        _rightHandle.modelArray = [YFShareInstance sharedInstance].modelArray;
        
        __weak typeof(self)weakS = self;
        
        [[YFShareInstance sharedInstance] setChangeShareViewForHorizonBlock:^(YFBaseCubeView * shareView) {
            
            
            
            weakS.leftHandle.shareView = shareView;
            
            weakS.rightHandle.shareView = shareView;
            
            // 记录
            weakS.leftHandle.firstModel = self.magicView.arrayForCube[_firstNum];
            
            weakS.leftHandle.lastModel = self.magicView.arrayForCube[_lastNum];
            
            weakS.rightHandle.firstModel = self.magicView.arrayForCube[_firstNum];
            
            weakS.rightHandle.lastModel = self.magicView.arrayForCube[_lastNum];
            
            
        }];
        
    }
    return self;
}



-(void)checkBeginPoint:(CGPoint)point
{
    
    // 设置
    self.lastPoint = point;
    
    _leftHandle.lastPoint = point;
    
    _leftHandle.beginPointFromPan = self.magicView.beginPointFromPan;
    
    _rightHandle.lastPoint = point;
    
    _rightHandle.beginPointFromPan = self.magicView.beginPointFromPan;
    
    
    _rowOfSelect = (NSInteger)point.y / (NSInteger)self.magicView.perCubeHeight;
    
    _beginY = _rowOfSelect * self.magicView.perCubeHeight;
    
    _endY = _beginY + self.magicView.perCubeHeight;
    
    if (_beginY <= point.y  && _endY > point.y)
    {
    }
    else
    {
        // 多算 多行的 情况 没有处理 除非 有很小的 方格 否则不会出现多行的情况
        if (point.y < _beginY) // 多算了一行
        {
            //            YFAssert(NO, @"多算了一行");
            
            //            DebugLog(@"多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行多算了一行");
            
            _rowOfSelect --;
            
            _beginY = _rowOfSelect * self.magicView.perCubeHeight;
        }
        else // 少算了一行
        {
            
            //            YFAssert(NO, @"少算了一行");
            
            //            DebugLog(@"少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行少算了一行");
            
            _rowOfSelect ++;
            
            _beginY = _rowOfSelect * self.magicView.perCubeHeight;
            
        }
        _endY = _beginY + self.magicView.perCubeHeight;
    }
    
    //   计算 第一个 和 最后一个 方块的 下标
    _firstNum = _rowOfSelect * self.magicView.rows;
    
    _lastNum = _firstNum  + self.magicView.rows - 1;
    
    
    // 记录
    _leftHandle.firstModel = self.magicView.arrayForCube[_firstNum];
    
    _leftHandle.lastModel = self.magicView.arrayForCube[_lastNum];
    
    _leftHandle.firstNum = _firstNum;
    
    _leftHandle.LastNum = _lastNum;
    
    
    
    _rightHandle.firstModel = self.magicView.arrayForCube[_firstNum];
    
    _rightHandle.lastModel = self.magicView.arrayForCube[_lastNum];
    
    _rightHandle.firstNum = _firstNum;
    
    _rightHandle.LastNum = _lastNum;
    
    if (_beginY == point.y)
    {
        //        NSAssert(NO, @"点击的两行中间");
        
        DebugLog(@"点击的两行中间");
        
        self.magicView.directionForPan = YFPanGestureBeginDirecionError;
    }
    else
    {
        //        [self.arrayOfSelectObjects removeAllObjects];
        //
        //        for (NSInteger i = _firstNum; i <= _lastNum; i ++ )
        //        {
        //
        //            YFMVViewModel * cubeModel = self.magicView.arrayForCube[i];
        //
        //            [self.arrayOfSelectObjects addObject:cubeModel];
        //            //        DebugLog(@"水平水平水平水平水平水平水平水平水平水平水平水平:::=====%ld",i);
        //        }
        
    }
}

-(void)panGest:(UIPanGestureRecognizer *)panGes point:(CGPoint)point
{
    if (point.y <= _beginY || point.y >= _endY)
    {
        self.magicView.directionForPan = YFPanGestureBeginDirecionError;
        
        DebugLog(@"移动手指超出选中行");
        
        return;
    }
    
    _gapXX = point.x - self.lastPoint.x;
    
    // 大约 可以达到 20 warnning
    DebugLog(@"========:%f",_gapXX);
    
    if (_gapXX > 0 ) // 右 滑
    {
        _handleForLR = _rightHandle;
    }
    else // 左滑
    {
        _handleForLR = _leftHandle;
    }
    
    for (NSInteger i = _firstNum; i <= _lastNum; i ++ )
    {
        
        YFMVViewModel * cubeModel = self.magicView.arrayForCube[i];
        
        //        cubeModel.cubeView.backgroundColor = [UIColor purpleColor];
        
        cubeModel.cubeView.center = CGPointMake(cubeModel.cubeView.center.x + _gapXX, cubeModel.cubeView.center.y);
        //        DebugLog(@"水平水平水平水平水平水平水平水平水平水平水平水平:::=====%ld",i);
    }
    
    [_handleForLR handleWithPoint:point gapX:_gapXX];
    
    
    //    DebugLog(@"-------------------:%@::%@::%@::%@::%@::%@--------------",_leftHandle.shareView.title,_leftHandle.firstModel.cubeView.title,_leftHandle.lastModel.cubeView.title,_rightHandle.shareView.title,_rightHandle.firstModel.cubeView.title,_rightHandle.lastModel.cubeView.title);
    
    // 设置
    self.lastPoint = point;
    
    _leftHandle.lastPoint = point;
    
    _rightHandle.lastPoint = point;
    
    //    DebugLog(@"水平水平水平水平水平水平水平水平水平水平水平水平:::%ld",_rowOfSelect);
}


-(void)setOriginalFrame
{
    for (NSInteger i = _firstNum; i <= _lastNum; i ++ )
    {
        YFMVViewModel * cubeModel = self.magicView.arrayForCube[i];
#pragma mark !!!!!NIUNIU
        //        cubeModel.cubeView.center = CGPointMake(self.magicView.perCubeWidth *(i % 3 + 0.5)  , cubeModel.cubeView.center.y);
        
        cubeModel.cubeView.center = CGPointMake(self.magicView.perCubeWidth *(i % self.magicView.rows  + 0.5)  , cubeModel.cubeView.center.y);
        //        DebugLog(@"水平水平水平水平水平水平水平水平水平水平水平水平:::=====%ld",i);
    }
}

-(void)panGest:(UIPanGestureRecognizer *)panGes endPoint:(CGPoint)point
{
    [_handleForLR panGest:panGes endPoint:point];
}

-(void)setMagicView:(YFMagicGameView *)magicView
{
    [super setMagicView:magicView];
    
    _leftHandle.magicView = magicView;
    
    _rightHandle.magicView = magicView;
}


@end
