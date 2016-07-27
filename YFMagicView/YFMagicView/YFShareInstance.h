//
//  YFShareInstance.h
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFBaseCubeView.h"
#import "YFMagicGameView.h"
#import <UIKit/UIKit.h>

@interface YFShareInstance : NSObject


@property(nonatomic,strong)NSMutableArray *modelArray;

@property(nonatomic,strong)YFBaseCubeView *shareView;

/**
 * 游戏View
 */
@property(nonatomic,weak)YFMagicGameView *magicGameView;

/**
 * 步数
 */
@property(nonatomic,assign)NSUInteger steps;

@property(nonatomic,strong)void (^changeShareViewForHorizonBlock)(YFBaseCubeView *);

@property(nonatomic,strong)void (^changeShareViewForVerticalBlock)(YFBaseCubeView *);

+ (instancetype)sharedInstance;

-(void)setFeatureFrom:(YFBaseCubeView *)view;

+(void)setEmpty;


-(void)showImage:(UIImage *)image originFrame:(CGRect)originFrame;
-(void)showImage:(UIImage *)image originFrame:(CGRect)originFrame cometion:(void(^)())completion;

-(void)showImage:(UIImage *)image;

/**
 * 增加一步
 */
-(void)addStepsYF;


@end
