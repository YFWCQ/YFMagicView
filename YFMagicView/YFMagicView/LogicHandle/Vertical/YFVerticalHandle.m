//
//  YFVerticalHandle.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFVerticalHandle.h"

#import "YFMVViewModel.h"

#import "YFShareInstance.h"

#import "YFUpDirectionHandle.h"

#import "YFDownDirectionHandle.h"

@interface YFVerticalHandle ()

@property(nonatomic,strong)YFUpDirectionHandle *upHandle;

@property(nonatomic,strong)YFDownDirectionHandle *downHandle;

@end

@implementation YFVerticalHandle

{
    CGFloat _beginX;
    
    CGFloat _endX;
    
    NSUInteger _columnOfSelect;
    
    // 纵向 滑动的 第一个 元素的 下标
    NSInteger _firstNum;
    
    // 纵向 滑动的 最后一个 元素的 下标
    NSInteger _lastNum;
    
    YFBaseVerticalHandle *_handleForLR;
    
    CGFloat _gapYY;
    
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _upHandle = [[YFUpDirectionHandle alloc] init];
        
        _downHandle = [[YFDownDirectionHandle alloc] init];
        
        
        _upHandle.modelArray = [YFShareInstance sharedInstance].modelArray;
        
        _downHandle.modelArray = [YFShareInstance sharedInstance].modelArray;
        
        __weak typeof(self)weakS = self;
        
        
        [[YFShareInstance sharedInstance] setChangeShareViewForVerticalBlock:^(YFBaseCubeView * shareView) {
            weakS.upHandle.shareView = shareView;
            
            weakS.downHandle.shareView = shareView;
            
            // 记录
            weakS.upHandle.firstModel = self.magicView.arrayForCube[_firstNum];
            
            weakS.upHandle.lastModel = self.magicView.arrayForCube[_lastNum];
            
            weakS.downHandle.firstModel = self.magicView.arrayForCube[_firstNum];
            
            weakS.downHandle.lastModel = self.magicView.arrayForCube[_lastNum];
            
        }];
        
        
    }
    return self;
}

-(void)checkBeginPoint:(CGPoint)point
{
    self.lastPoint = point;
    
    
    _upHandle.lastPoint = point;
    
    _upHandle.beginPointFromPan = self.magicView.beginPointFromPan;
    
    _downHandle.lastPoint = point;
    
    _downHandle.beginPointFromPan = self.magicView.beginPointFromPan;
    
    
    
    _columnOfSelect = (NSInteger)point.x / (NSInteger)self.magicView.perCubeWidth;
    
    _beginX = _columnOfSelect * self.magicView.perCubeWidth;
    
    _endX = _beginX + self.magicView.perCubeWidth;
    
    if (_beginX <= point.x  && _endX > point.x)
    {
    }
    else
    {
        // 多算 多行的 情况 没有处理 除非 有很小的 方格 否则一般不会出现多行的情况
        if (point.x < _beginX) // 多算了一列
        {
            //            NSAssert(NO, @"多算了一列");
            
            //            DebugLog(@"多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列多算了一列");
            
            _columnOfSelect --;
            
            _beginX = _columnOfSelect * self.magicView.perCubeHeight;
        }
        else // 少算了一列
        {
            //            NSAssert(NO, @"少算了一列");
            
            //            DebugLog(@"少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列少算了一列");
            
            _columnOfSelect ++;
            
            _beginX = _columnOfSelect * self.magicView.perCubeHeight;
            
        }
        _endX = _beginX + self.magicView.perCubeHeight;
    }
    
    //   计算 第一个 和 最后一个 方块的 下标
    _firstNum = _columnOfSelect ;
    
    _lastNum = _columnOfSelect + self.magicView.rows * (self.magicView.columns - 1);
    
    
    // 记录
    _upHandle.firstModel = self.magicView.arrayForCube[_firstNum];
    
    _upHandle.lastModel = self.magicView.arrayForCube[_lastNum];
    
    _upHandle.firstNum = _firstNum;
    
    _upHandle.LastNum = _lastNum;
    
    
    
    _downHandle.firstModel = self.magicView.arrayForCube[_firstNum];
    
    _downHandle.lastModel = self.magicView.arrayForCube[_lastNum];
    
    _downHandle.firstNum = _firstNum;
    
    _downHandle.LastNum = _lastNum;
    
    
    
    
    
    
    
    
    if (_beginX == point.x)
    {
        //        NSAssert(NO, @"点击的两行中间");
        
        NSLog(@"点击的两行中间");
        
        self.magicView.directionForPan = YFPanGestureBeginDirecionError;
    }
}

-(void)panGest:(UIPanGestureRecognizer *)panGes point:(CGPoint)point
{
    if (point.x <= _beginX || point.x >= _endX)
    {
        self.magicView.directionForPan = YFPanGestureBeginDirecionError;
        
        NSLog(@"移动手指超出选中列");
        
        return;
    }
    
    _gapYY = point.y - self.lastPoint.y;
    
    if (_gapYY > 0 ) // 右 滑
    {
        _handleForLR = _downHandle;
    }
    else // 左滑
    {
        _handleForLR = _upHandle;
    }
    
    
    for (NSInteger i = _columnOfSelect; i < self.magicView.arrayForCube.count; i +=self.magicView.rows ) {
        
        YFMVViewModel * cubeModel = self.magicView.arrayForCube[i];
        
        //        cubeModel.cubeView.backgroundColor = [UIColor purpleColor];
        //
        //        DebugLog(@"纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向:::=====%ld",i);
        
        cubeModel.cubeView.center = CGPointMake(cubeModel.cubeView.center.x, cubeModel.cubeView.center.y + _gapYY);
        
        //        cubeModel.cubeView.frame = CGRectMake(cubeModel.cubeView.frame.origin.x, cubeModel.cubeView.frame.origin.y + gapYY, cubeModel.cubeView.frame.size.width, cubeModel.cubeView.frame.size.height);
        
    }
    [_handleForLR handleWithPoint:point gapY:_gapYY];
    
    self.lastPoint = point;
    
    _upHandle.lastPoint = point;
    
    _downHandle.lastPoint = point;
    
    //    DebugLog(@"纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向纵向");
}

-(void)panGest:(UIPanGestureRecognizer *)panGes endPoint:(CGPoint)point
{
    [_handleForLR panGest:panGes endPoint:point];
}

-(void)setMagicView:(YFMagicGameView *)magicView
{
    [super setMagicView:magicView];
    
    _upHandle.magicView = magicView;
    
    _downHandle.magicView = magicView;
}


@end
