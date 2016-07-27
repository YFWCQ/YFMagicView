//
//  YFBaseHorizonHandle.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseHorizonHandle.h"

#import "YFShareInstance.h"
#import "YFHeader.h"

@implementation YFBaseHorizonHandle
{
    CGFloat _shareViewGapWhenEndX;
    
    CGFloat _shareViewShowWidth;
}


-(void)handleWithPoint:(CGPoint)point gapX:(CGFloat)gapX
{
    YFAssert(NO, @"Need implement in subclass");
}

-(void)panGest:(UIPanGestureRecognizer *)panGes endPoint:(CGPoint)point
{
    if (self.shareView.frame.origin.x < 0) // 共享View 在左边
    {
        // > 0
        _shareViewShowWidth = self.shareView.frame.origin.x + self.magicView.perCubeWidth;
        
        //        DebugLog(@"%f-----%f",_shareViewShowWidth,_shareViewGapWhenEndX);
        
        // 漏出来的 面价 超过或者等于一半
        if (_shareViewShowWidth >= self.magicView.perCubeWidth / 2)
        {
            _shareViewGapWhenEndX  = -self.shareView.frame.origin.x;
            
            //            DebugLog(@"%f-----%f",_shareViewShowWidth,_shareViewGapWhenEndX);
            
            
            [self exchangeShareViewWithLastView];
        }
        else
        {
            _shareViewGapWhenEndX = -_shareViewShowWidth;
        }
        
        //        DebugLog(@"%f-----%f",_shareViewShowWidth,_shareViewGapWhenEndX);
        
    }
    else //共享View 在右边
    {
        // > 0
        _shareViewShowWidth = self.magicView.frame.size.width - self.shareView.frame.origin.x;
        
        if (_shareViewShowWidth >= self.magicView.perCubeWidth / 2)
        {
            _shareViewGapWhenEndX  = -self.firstModel.cubeView.frame.origin.x - self.magicView.perCubeWidth;
            
            [self exchangeShareViewWithFirstView];
        }
        else
        {
            _shareViewGapWhenEndX  = _shareViewShowWidth;
        }
    }
    
    
    self.magicView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:YFAnimationTimeInterval animations:^{
        self.shareView.center = CGPointMake( self.shareView.center.x + _shareViewGapWhenEndX, self.shareView.center.y);
        
        for (NSInteger i = self.firstNum; i <= self.LastNum; i ++ )
        {
            YFMVViewModel * cubeModel = self.modelArray[i];
            
            
            cubeModel.cubeView.center = CGPointMake(self.magicView.perCubeWidth *(i % self.magicView.rows + 0.5)  , cubeModel.cubeView.center.y);
            //        DebugLog(@"水平水平水平水平水平水平水平水平水平水平水平水平:::=====%ld",i);
        }
        
    } completion:^(BOOL finished) {
        
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
    
    //    DebugLog(@"总共%ld个",self.modelArray.count);
    
    [self.modelArray removeObjectAtIndex:firstObjec.indexForArray];
    
    [self.modelArray insertObject:firstObjec atIndex:self.LastNum];
    
    //    DebugLog(@"删除第%ld个",firstObjec.indexForArray);
    //    DebugLog(@"增加到%ld个",self.LastNum);
    
    //    DebugLog(@"总共%ld个",self.modelArray.count);
    
    self.lastModel = firstObjec;
    
    self.firstModel = self.modelArray[self.firstNum ];
    
    for (NSInteger i = self.firstNum ; i <= self.LastNum; i ++)
    {
        YFMVViewModel * model = self.modelArray[i];
        
        model.indexForArray  = i;
    }
    
    // 交换 View
    
    YFBaseCubeView * view = [YFShareInstance sharedInstance].shareView;
    
    [YFShareInstance sharedInstance].shareView = firstObjec.cubeView;
    
    self.lastModel.cubeView =view;
    
    
    // 记录 步数
    [[YFShareInstance sharedInstance] addStepsYF];
    
}


-(void)setShareViewCenterWhenExchangeWithFirstView
{
    self.shareView.center = CGPointMake(self.lastModel.cubeView.center.x + self.shareView.frame.size.width, self.lastModel.cubeView.center.y);
    
}



#pragma mark -- 交换 最后一个View
-(void)exchangeShareViewWithLastView
{
    // model 的替换
    YFMVViewModel * lastObjec = self.lastModel;
    
    //    DebugLog(@"总共%ld个",self.modelArray.count);
    
    [self.modelArray removeObjectAtIndex:lastObjec.indexForArray];
    
    [self.modelArray insertObject:lastObjec atIndex:self.firstNum];
    
    //    DebugLog(@"删除第%ld个",lastObjec.indexForArray);
    //    DebugLog(@"增加到%ld个",self.firstNum);
    
    //    DebugLog(@"总共%ld个",self.modelArray.count);
    
    self.firstModel = lastObjec;
    
    self.lastModel = self.modelArray[self.LastNum ];
    
    for (NSInteger i = self.firstNum ; i <= self.LastNum; i ++)
    {
        YFMVViewModel * model = self.modelArray[i];
        
        model.indexForArray  = i;
    }
    
    // 交换 View
    
    YFBaseCubeView * view = [YFShareInstance sharedInstance].shareView;
    
    [YFShareInstance sharedInstance].shareView = lastObjec.cubeView;
    
    self.firstModel.cubeView = view;
    
    // 记录 步数
    [[YFShareInstance sharedInstance] addStepsYF];
    
}

-(void)setShareViewCenterWhenExchangeWithLastView
{
    self.shareView.center = CGPointMake(self.firstModel.cubeView.center.x - self.shareView.frame.size.width, self.firstModel.cubeView.center.y);
    
}

@end
