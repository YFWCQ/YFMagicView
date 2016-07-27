//
//  YFBaseVerticalHandle.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseVerticalHandle.h"

#import "YFShareInstance.h"
#import "YFHeader.h"


@implementation YFBaseVerticalHandle
{
    CGFloat _shareViewShowHeight;
    
    CGFloat _shareViewGapWhenEndY;
}

-(void)handleWithPoint:(CGPoint)point gapY:(CGFloat)gapY
{
    YFAssert(NO, @"Need implement in subclass");
}

-(void)panGest:(UIPanGestureRecognizer *)panGes endPoint:(CGPoint)point
{
    if (self.shareView.frame.origin.y < 0) // 共享View 在上边
    {
        // > 0
        _shareViewShowHeight = self.shareView.frame.origin.y + self.magicView.perCubeHeight;
        
        
        // 漏出来的 面价 超过或者等于一半
        if (_shareViewShowHeight >= self.magicView.perCubeHeight / 2)
        {
            _shareViewGapWhenEndY  = -self.shareView.frame.origin.y;
            
            
            
            [self exchangeShareViewWithLastView];
        }
        else
        {
            _shareViewGapWhenEndY = -_shareViewShowHeight;
        }
        
        DebugLog(@"$$$$$$$$$$$$:::%f-----%f",_shareViewShowHeight,_shareViewGapWhenEndY);
        
    }
    else //共享View 在下边
    {
        // > 0
        _shareViewShowHeight = self.magicView.frame.size.height - self.shareView.frame.origin.y;
        
        //        DebugLog(@"******^^^^^%f-----%f",_shareViewShowHeight,_shareViewGapWhenEndY);
        
        
        if (_shareViewShowHeight >= self.magicView.perCubeHeight / 2)
        {
            _shareViewGapWhenEndY  = -self.firstModel.cubeView.frame.origin.y - self.magicView.perCubeHeight;
            
            [self exchangeShareViewWithFirstView];
        }
        else
        {
            _shareViewGapWhenEndY  = _shareViewShowHeight;
        }
    }
    
    self.magicView.userInteractionEnabled = NO;
    
    //    DebugLog(@"----------&&&&&&&1:%@",NSStringFromCGPoint(self.shareView.center));
    //    DebugLog(@"----------&&&&&&&2:%f",_shareViewGapWhenEndY);
    
    
    [UIView animateWithDuration:YFAnimationTimeInterval animations:^{
        self.shareView.center = CGPointMake( self.shareView.center.x, self.shareView.center.y + _shareViewGapWhenEndY);
        
        for (NSInteger i = self.firstNum; i <= self.LastNum; i += self.magicView.rows )
        {
            YFMVViewModel * cubeModel = self.modelArray[i];
            
            
            cubeModel.cubeView.center = CGPointMake(cubeModel.cubeView.center.x  , self.magicView.perCubeHeight *(i / self.magicView.rows + 0.5));
            //        DebugLog(@"水平水平水平水平水平水平水平水平水平水平水平水平:::=====%ld",i);
        }
        
    } completion:^(BOOL finished) {
        //        DebugLog(@"----------&&&&&&&3:%@",NSStringFromCGPoint(self.shareView.center));
        //        DebugLog(@"----------&&&&&&&4:%f",_shareViewGapWhenEndY);
        self.magicView.userInteractionEnabled = YES;
        [self.magicView checkSucceed];
        
    }];
    
}


#pragma mark -- 交换 第一个View
// 把 公用的 shareView 和 lastObject 的view 交换
-(void)exchangeShareViewWithFirstView
{
    // model 的替换
    YFMVViewModel * firstObjec = self.firstModel;
    
    
    for (NSInteger i = self.LastNum ; i > self.firstNum; i -= self.magicView.rows)
    {
        [self.modelArray exchangeObjectAtIndex:i withObjectAtIndex:self.firstNum];
        
        YFMVViewModel * model = self.modelArray[i];
        
        model.indexForArray  = i;
    }
    
    self.firstModel = self.modelArray[self.firstNum];
    
    self.lastModel = self.modelArray[self.LastNum ];
    
    self.firstModel.indexForArray = self.firstNum;
    
    // 交换 View
    
    YFBaseCubeView * view = [YFShareInstance sharedInstance].shareView;
    
    [YFShareInstance sharedInstance].shareView = firstObjec.cubeView;
    
    self.lastModel.cubeView =view;
    
    // 记录 步数
    [[YFShareInstance sharedInstance] addStepsYF];
}

-(void)setShareViewCenterAfterExchangeWithFirstView
{
    self.shareView.center = CGPointMake(self.lastModel.cubeView.center.x , self.lastModel.cubeView.center.y + self.shareView.frame.size.height);
    
}

#pragma mark -- 交换 最后一个View
-(void)exchangeShareViewWithLastView
{
    // model 的替换
    YFMVViewModel * lastObjec = self.lastModel;
    
    //    DebugLog(@"总共%ld个",self.modelArray.count);
    
    //    [self.modelArray removeObjectAtIndex:lastObjec.indexForArray];
    //
    //    [self.modelArray insertObject:lastObjec atIndex:self.firstNum];
    
    //    DebugLog(@"删除第%ld个",lastObjec.indexForArray);
    //    DebugLog(@"增加到%ld个",self.firstNum);
    
    //    DebugLog(@"总共%ld个",self.modelArray.count);
    
    
    
    for (NSInteger i = self.firstNum ; i < self.LastNum; i += self.magicView.rows)
    {
        [self.modelArray exchangeObjectAtIndex:i withObjectAtIndex:self.LastNum];
        
        YFMVViewModel * model = self.modelArray[i];
        
        //        DebugLog(@"i=:%ld",i);
        
        
        model.indexForArray  = i;
    }
    
    self.firstModel = self.modelArray[self.firstNum];
    
    self.lastModel = self.modelArray[self.LastNum ];
    
    self.lastModel.indexForArray = self.LastNum;
    
    // 交换 View
    
    YFBaseCubeView * view = [YFShareInstance sharedInstance].shareView;
    
    [YFShareInstance sharedInstance].shareView = lastObjec.cubeView;
    
    self.firstModel.cubeView = view;
    
    // 记录 步数
    [[YFShareInstance sharedInstance] addStepsYF];
    
}



-(void)setShareViewCenterAfterExchangeWithLastView
{
    self.shareView.center = CGPointMake(self.firstModel.cubeView.center.x, self.firstModel.cubeView.center.y -self.shareView.frame.size.height);
    
}

@end
