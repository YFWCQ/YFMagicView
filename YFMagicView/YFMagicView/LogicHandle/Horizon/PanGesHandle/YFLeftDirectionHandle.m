//
//  YFLeftDirectionHandle.m
//  YFMagicView
//
//  Created by FYWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFLeftDirectionHandle.h"

#import "YFShareInstance.h"

#import "YFCubeView.h"

@implementation YFLeftDirectionHandle


-(void)handleWithPoint:(CGPoint)point gapX:(CGFloat)gapX
{
    
    //    DebugLog(@"---*----%@",NSStringFromCGPoint(self.shareView.center));
    //
    //    DebugLog(@"----**---%f",self.lastModel.cubeView.frame.origin.x);
    //
    //    DebugLog(@"----***---%f",self.firstModel.cubeView.frame.origin.x);
    
    
    if (self.firstModel.cubeView.frame.origin.x > 0 ) // 左边界添加View
    {
        
        self.shareView.center = CGPointMake(self.firstModel.cubeView.center.x - self.shareView.frame.size.width, self.firstModel.cubeView.center.y);
        
        
        // 没有必要
        //        [self checkLeftBoundary];
        
    }
    else if(self.firstModel.cubeView.frame.origin.x < 0) // 右边添加View
    {
        
        [self.shareView setSelfFeatureFromView:self.firstModel.cubeView];
        
        self.shareView.center = CGPointMake(self.lastModel.cubeView.center.x + self.shareView.frame.size.width, self.lastModel.cubeView.center.y);
        
        //        self.shareView.backgroundColor = [UIColor greeYFolor];
        //
        //        self.lastModel.cubeView.backgroundColor = [UIColor purpleColor];
        
        //        DebugLog(@"-------%@",NSStringFromCGPoint(self.shareView.center));
        //        DebugLog(@"-------%@",NSStringFromCGPoint(self.lastModel.cubeView.center));
        
        [self checkRightBoundary];
        //
    }
    else
    {
        // warn
        [[YFShareInstance sharedInstance] setFeatureFrom:self.firstModel.cubeView];
        
        //        [self.firstModel.viewForReplace removeFromSuperview];
        //
        //        [self.lastModel.viewForReplace removeFromSuperview];
    }
    //    DebugLog(@"左滑");
}

-(void)checkRightBoundary
{
    
    //    DebugLog(@"-------%f------%f",self.shareView.frame.origin.x,self.shareView.frame.size.width);
    //    DebugLog(@"-----&&&--%f",self.shareView.superview.frame.size.width);
    
    if (self.shareView.frame.origin.x + self.shareView.frame.size.width <= self.shareView.superview.frame.size.width)
    {
        
        //        DebugLog(@"************************************************");
        
        
        [self exchangeShareViewWithFirstView];
        
        [self setShareViewCenterWhenExchangeWithFirstView];
        
        //        DebugLog(@"---************--****--%@",NSStringFromCGPoint(self.shareView.center));
        
        [self.shareView setSelfFeatureFromView:self.firstModel.cubeView];
        
        if (self.shareView.frame.origin.x + self.shareView.frame.size.width < self.shareView.superview.frame.size.width)
        {
            [self checkRightBoundary];
        }
    }
}

#pragma mark ---- 暂时 没有用
// 左边界 添加 View
-(void)checkLeftBoundary
{
    if (self.shareView.frame.origin.x >= 0)
    {
        [self exchangeShareViewWithLastView];
        
        [self setShareViewCenterWhenExchangeWithLastView];
        
        if (self.shareView.frame.origin.x > 0)
        {
            [self checkLeftBoundary];
        }
    }
}


@end
