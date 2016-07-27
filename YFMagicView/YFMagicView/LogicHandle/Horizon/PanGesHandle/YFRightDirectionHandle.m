//
//  YFRightDirectionHandle.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFRightDirectionHandle.h"

#import "YFShareInstance.h"


@implementation YFRightDirectionHandle



-(void)handleWithPoint:(CGPoint)point gapX:(CGFloat)gapX
{
    //    DebugLog(@"右滑");
    
    if (self.firstModel.cubeView.frame.origin.x > 0 ) // 左边界添加View
    {
        self.shareView.center = CGPointMake(self.firstModel.cubeView.center.x - self.shareView.frame.size.width, self.firstModel.cubeView.center.y);
        
        //        DebugLog(@"+++++++++++++++++++++++:%@::%@::%@:--------------",self.shareView.title,self.firstModel.cubeView.title,self.lastModel.cubeView.title);
        
        
        [self.shareView setSelfFeatureFromView:self.lastModel.cubeView];
        
        //        DebugLog(@"+++++++++++++++++++++++:%@::%@::%@:--------------",self.shareView.title,self.firstModel.cubeView.title,self.lastModel.cubeView.title);
        
        // 没有必要
        [self checkLeftBoundary];
    }
    else if(self.firstModel.cubeView.frame.origin.x < 0) // 右边添加View
    {
        self.shareView.center = CGPointMake(self.lastModel.cubeView.center.x + self.shareView.frame.size.width, self.lastModel.cubeView.center.y);
        
        //        self.shareView.backgroundColor = [UIColor greenColor];
        //
        //        self.lastModel.cubeView.backgroundColor = [UIColor purpleColor];
        
        //        DebugLog(@"-------%@",NSStringFromCGPoint(self.shareView.center));
        //        DebugLog(@"-------%@",NSStringFromCGPoint(self.lastModel.cubeView.center));
        
        // 没有必要
        //        [self checkRightBoundary];
    }
    else
    {
        // warn
        [[YFShareInstance sharedInstance] setFeatureFrom:self.lastModel.cubeView];
        
        //        [self.firstModel.viewForReplace removeFromSuperview];
        //
        //        [self.lastModel.viewForReplace removeFromSuperview];
    }
}

// 左边界 添加 View
-(void)checkLeftBoundary
{
    if (self.shareView.frame.origin.x >= 0)
    {
        [self exchangeShareViewWithLastView];
        
        [self setShareViewCenterWhenExchangeWithLastView];
        
        [self.shareView setSelfFeatureFromView:self.lastModel.cubeView];
        
        if (self.shareView.frame.origin.x > 0)
        {
            [self checkLeftBoundary];
        }
    }
}


@end
