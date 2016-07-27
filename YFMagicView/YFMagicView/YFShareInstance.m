//
//  YFShareInstance.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFShareInstance.h"

#import "YFBaseCubeView.h"

#import "YFShowBigImageView.h"

static YFShareInstance *shareInstance = nil;

@interface YFShareInstance ()

@property(nonatomic,strong)YFShowBigImageView *showBigIV;


@end

@implementation YFShareInstance


+ (instancetype)sharedInstance
{
    if (shareInstance == nil) {
        shareInstance = [[YFShareInstance alloc] init];
        
        shareInstance.modelArray = [NSMutableArray array];
        
        shareInstance.showBigIV = [YFShowBigImageView defaultShowBigIV];
        
        shareInstance.steps = 0;
    }
    //    static dispatch_once_t onceTokenn;
    
    //    dispatch_once(&onceTokenn, ^{
    //           });
    
    return shareInstance;
}

-(void)setShareView:(YFBaseCubeView *)shareView
{
    if ([_shareView isEqual:shareView] == NO)
    {
        // 未做 为空判断 必须保证必须实现
        _changeShareViewForHorizonBlock(shareView);
        
        _changeShareViewForVerticalBlock(shareView);
        
        _shareView = shareView;
    }
}

-(void)setFeatureFrom:(YFBaseCubeView *)view
{
    [self.shareView setSelfFeatureFromView:view];
}


+(void)setEmpty
{
    shareInstance = nil;
}


-(void)showImage:(UIImage *)image originFrame:(CGRect)originFrame
{
    [self.showBigIV showImage:image imageOriginFrame:originFrame cometion:nil];
}

-(void)showImage:(UIImage *)image originFrame:(CGRect)originFrame cometion:(void(^)())completion
{
    [self.showBigIV showImage:image imageOriginFrame:originFrame cometion:completion];
}

-(void)showImage:(UIImage *)image
{
    [self.showBigIV showImage:image];
}

-(void)addStepsYF
{
    _steps ++;
    if (self.magicGameView.whenStepsAddedBlock)
    {
        self.magicGameView.whenStepsAddedBlock(_steps);
    }
}


@end
