//
//  YFBaseHandle.h
//  YFMagicView
//
//  Created by FYWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFMagicGameView.h"

@class YFMagicGameView;
@interface YFBaseHandle : NSObject

@property(nonatomic,weak)YFMagicGameView *magicView;

@property(nonatomic,assign)CGPoint lastPoint;

@property(nonatomic,copy)void(^animationEndBlock)();

//@property(nonatomic,strong)NSMutableArray *arrayOfSelectObjects;

-(void)checkBeginPoint:(CGPoint)point;

-(void)panGest:(UIPanGestureRecognizer *)panGes point:(CGPoint)point;

-(void)panGest:(UIPanGestureRecognizer *)panGes endPoint:(CGPoint)point;

@end
