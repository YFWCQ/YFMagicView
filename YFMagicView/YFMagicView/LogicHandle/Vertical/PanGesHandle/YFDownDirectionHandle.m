//
//  YFDownDirectionHandle.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFDownDirectionHandle.h"

#import "YFShareInstance.h"

@implementation YFDownDirectionHandle

-(void)handleWithPoint:(CGPoint)point gapY:(CGFloat)gapY
{
    //    DebugLog(@"右滑");
    
    if (self.firstModel.cubeView.frame.origin.y > 0 ) // 上 边界添加View
    {
        [self.shareView setSelfFeatureFromView:self.lastModel.cubeView];
        
        
        self.shareView.center = CGPointMake(self.firstModel.cubeView.center.x , self.firstModel.cubeView.center.y - self.firstModel.cubeView.frame.size.height);
        
        //        DebugLog(@"+++++++++++++++++++++++:%@::%@::%@:--------------",self.shareView.title,self.firstModel.cubeView.title,self.lastModel.cubeView.title);
        
        //        DebugLog(@"+++++++++++++++++++++++:%@::%@::%@:--------------",self.shareView.title,self.firstModel.cubeView.title,self.lastModel.cubeView.title);
        
        //        DebugLog(@"****%@****%@",NSStringFromCGRect(self.shareView.frame),NSStringFromCGRect(self.firstModel.cubeView.frame));
        
        
        // 没有必要
        [self checkUpBoundary];
    }
    else if(self.firstModel.cubeView.frame.origin.y < 0) //     下边添加View
    {
        self.shareView.center = CGPointMake(self.lastModel.cubeView.center.x, self.lastModel.cubeView.center.y + self.lastModel.cubeView.frame.size.height);
        
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

// 上 边界 添加 View
-(void)checkUpBoundary
{
    if (self.shareView.frame.origin.y >= 0)
    {
        //        DebugLog(@"%lf",self.shareView.frame.origin.y);
        
        
        [self exchangeShareViewWithLastView];
        
        [self setShareViewCenterAfterExchangeWithLastView];
        
        [self.shareView setSelfFeatureFromView:self.lastModel.cubeView];
        
        //        DebugLog(@"%lf",self.shareView.frame.origin.y);
        
        if (self.shareView.frame.origin.y > 0)
        {
            [self checkUpBoundary];
        }
    }
}


@end
