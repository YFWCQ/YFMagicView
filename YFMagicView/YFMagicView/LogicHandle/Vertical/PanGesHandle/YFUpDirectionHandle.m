//
//  YFUpDirectionHandle.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFUpDirectionHandle.h"

#import "YFShareInstance.h"

@implementation YFUpDirectionHandle


-(void)handleWithPoint:(CGPoint)point gapY:(CGFloat)gapY
{
    //    DebugLog(@"---*----%@",NSStringFromCGPoint(self.shareView.center));
    
    //    DebugLog(@"----**---%f",self.lastModel.cubeView.frame.origin.y);
    //
    //    DebugLog(@"----***---%f",self.firstModel.cubeView.frame.origin.y);
    
    if (self.firstModel.cubeView.frame.origin.y > 0 ) // 上 边界添加View
    {
        self.shareView.center = CGPointMake(self.firstModel.cubeView.center.x , self.firstModel.cubeView.center.y - self.firstModel.cubeView.frame.size.height);
        
        //        DebugLog(@"<<<<<<<<<<<<<");
        
        // 没有必要
        //        [self checkLeftBoundary];
    }
    else if(self.firstModel.cubeView.frame.origin.y < 0) // 下 边界添加View
    {
        //                DebugLog(@">>>>>>>>>>>>");
        
        [self.shareView setSelfFeatureFromView:self.firstModel.cubeView];
        
        self.shareView.center = CGPointMake(self.lastModel.cubeView.center.x, self.lastModel.cubeView.center.y + self.lastModel.cubeView.frame.size.height);
        
        //        self.shareView.backgroundColor = [UIColor greenColor];
        //
        //        self.lastModel.cubeView.backgroundColor = [UIColor purpleColor];
        
        //        DebugLog(@"-------%@",NSStringFromCGPoint(self.shareView.center));
        //        DebugLog(@"-------%@",NSStringFromCGPoint(self.lastModel.cubeView.center));
        
        [self checkDownBoundary];
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
    //    DebugLog(@"上滑");
    
}

// 检查下面的界限 该不该 替换 公共View
-(void)checkDownBoundary
{
    
    //    DebugLog(@"---yy----%f------%f",self.shareView.frame.origin.y,self.shareView.frame.size.width);
    //    DebugLog(@"-----&&&--%f",self.shareView.superview.frame.size.height);
    
    if (self.shareView.frame.origin.y + self.shareView.frame.size.height <= self.shareView.superview.frame.size.height)
    {
        
        //        DebugLog(@"************************************************");
        
        
        [self exchangeShareViewWithFirstView];
        
        [self setShareViewCenterAfterExchangeWithFirstView];
        
        //        DebugLog(@"---************--****--%@",NSStringFromCGPoint(self.shareView.center));
        
        [self.shareView setSelfFeatureFromView:self.firstModel.cubeView];
        
        if (self.shareView.frame.origin.y + self.shareView.frame.size.height < self.shareView.superview.frame.size.height)
        {
            [self checkDownBoundary];
        }
    }
}




@end
