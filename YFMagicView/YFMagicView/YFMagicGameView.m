//
//  YFMagicGameView.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFMagicGameView.h"

#import "YFHorizonHandle.h"

#import "YFVerticalHandle.h"

#import "YFMVViewModel.h"

#import "YFShareInstance.h"

#import "YFMVTextView.h"

#import "YFMVImageView.h"

#import "UIImage+YFCategory.h"


#import "YFHeader.h"

@implementation YFMagicGameView
{
    YFHorizonHandle *_horizonHandle;// 水平滑动处理基类
    
    YFVerticalHandle *_verticalHandle; // 纵向滑动处理基类
    
    
    UIPanGestureRecognizer * _panGes;
    CGPoint _tempPoint;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [YFShareInstance setEmpty];

        
        self.layer.cornerRadius = 2.0;
        self.layer.borderColor = UIColor.grayColor.CGColor;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5;
        
        // 初始化 数据
        _directionForPan = YFPanGestureBeginDirecionNone;
        
        _rows = 6;
        
        _columns = 6;
        
        
        // 滑动 手势
        _panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGes:)];
        
        [self addGestureRecognizer:_panGes];
        
    }
    
    return self;
}

-(void)loadPlayGameView
{
    _perCubeWidth = self.frame.size.width / _rows;
    
    _perCubeHeight = self.frame.size.height / _columns;
    
    self.clipsToBounds = YES;
    
    self.arrayForCube = [YFShareInstance sharedInstance].modelArray;
    
    _horizonHandle = [[YFHorizonHandle alloc] init];
    
    _verticalHandle = [[YFVerticalHandle alloc] init];
    
    // 公用View
    [YFShareInstance sharedInstance].shareView = [self creatViewWithFrame:CGRectMake( - _perCubeWidth, 0, _perCubeWidth, _perCubeHeight)];;
    
    [self addSubview:[[YFShareInstance sharedInstance] shareView]];
    
    _horizonHandle.magicView = self;
    
    _verticalHandle.magicView  = self;
    
    if (self.textArray.count)
    {
        [self loadSubViesOfPlayGameView:self.textArray];

    }else if(_gameImage)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *imagesArray = [_gameImage imageCutRow:_columns column:_rows];
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self loadSubViesOfPlayGameView:imagesArray];
            });
        });
    }
}

-(void)loadSubViesOfPlayGameView:(NSMutableArray *)dataArray
{
    // 创建一个 01 开始 到 最大个数的  字符串 数组
    NSMutableArray *correctIndexArray = [NSMutableArray array];
    for (NSInteger i = 0; i  < _columns * _rows; i ++)
    {
        NSString *str = [NSString stringWithFormat:@"%.2ld",(long)i + 1];
        [correctIndexArray addObject:str];
    }
    
    
    
    for (NSInteger i = 0; i < _columns; i ++)
    {
        for (NSInteger j = 0; j < _rows; j ++)
        {
            YFMVViewModel * cubeModel = [[YFMVViewModel alloc] init];
            cubeModel.indexForArray = _arrayForCube.count;
            
            cubeModel.cubeView = [self creatViewWithFrame:CGRectMake(_perCubeWidth * j , _perCubeHeight * i, _perCubeWidth, _perCubeHeight)];
            
            
            cubeModel.cubeView.userInteractionEnabled = NO;
            // 随机取出来一个字符串
            NSUInteger arcIndex;
            //            if (i == 0 && j == 0)// 保证第一个 是后三个中得一个，这样永远不会有一开始就 拼好的情况
            //            {
            //                arcIndex = correctIndexArray.count - arc4random()%3 - 1;
            //
            //            }else if(i == 1 && j == 0 && correctIndexArray.count > 3)
            //            {
            //                arcIndex = correctIndexArray.count - arc4random()%3 - 1;
            //            }
            //            else
            //            {
            //                arcIndex = arc4random()%correctIndexArray.count;
            //            }
            
            if (correctIndexArray.count > 3)// 数组大于3，就从 最后三个 随机抽一个
            {
                if ((_columns * _rows - correctIndexArray.count) % 2 == 0)// 偶数 从最后3个 随机取一个
                {
                    arcIndex = correctIndexArray.count - arc4random()%3 - 1;
                    //                    NSLog(@"%ld---%ld",i,j);
                }else // 奇数 从最开始3个 随机取一个
                {
                    arcIndex =arc4random()%3;
                }
            }else if (correctIndexArray.count == 3)
            {
                arcIndex = correctIndexArray.count - arc4random()%2 - 1;
            }else if (correctIndexArray.count == 2)
            {
                arcIndex = correctIndexArray.count - 1;
            }
            else{// 数组个数小于3，就随机
                
                arcIndex = arc4random()%correctIndexArray.count;
            }
            
            
            
            
            NSString *strrr = [correctIndexArray objectAtIndex:arcIndex];
            [correctIndexArray removeObjectAtIndex:arcIndex];
            
            
            
            
            YFMVDataModel *imageModel = [[YFMVDataModel alloc] init];
            imageModel.dataModel = [dataArray objectAtIndex:arcIndex];
            [dataArray removeObjectAtIndex:arcIndex];
            imageModel.identifierStr =strrr;
            cubeModel.cubeView.dataModel = imageModel;
            
            cubeModel.correctIndex = [strrr integerValue]  - 1;
            
            [self addSubview:cubeModel.cubeView];
            
            [_arrayForCube addObject:cubeModel];
            
        }
    }
    
}

//-(id)modelFromShowDataModel:(id)model
//{
//    
//}



-(void)tapGes:(UITapGestureRecognizer *)tapGes
{
    //    DebugLog(@"sdfafsfssfsfsdfsfd");
}

-(void)panGes:(UIPanGestureRecognizer *)panGes
{
    if (self.directionForPan == YFPanGestureBeginDirecionFailPass )
    {
        return;
    }
    CGPoint point = [panGes locationInView:self];
    
    if (self.directionForPan == YFPanGestureBeginDirecionCheckIfIsSuccess)
    {
        self.userInteractionEnabled = NO;
        [_logicHandle panGest:panGes endPoint:point];
        if (self.playWhenStepCompleted)
        {
            self.playWhenStepCompleted();
        }
//        [[YFAppService shareInstance] playWhenStepCompleted];
        return;
    }
    DebugLog(@"--------********^^^^^^%ld",self.directionForPan);
    _tempPoint = point;
    DebugLog(@"%@",NSStringFromCGPoint(point));
    
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        // 方向为None
        _directionForPan = YFPanGestureBeginDirecionNone;
        
        _beginPointFromPan = point;
        
        [_horizonHandle checkBeginPoint:point];
        
        [_verticalHandle checkBeginPoint:point];
        
        
        
        DebugLog(@"开始");
    }
    else if (panGes.state == UIGestureRecognizerStateChanged)
    {
        if (_directionForPan == YFPanGestureBeginDirecionNone)
        {
            [self checkDirectionWithPoint:point];
        }
        else if(_directionForPan == YFPanGestureBeginDirecionHorizontal || _directionForPan == YFPanGestureBeginDirecionVertical)
        {
            [_logicHandle panGest:panGes point:point];
            
        }else if (_directionForPan == YFPanGestureBeginDirecionCheckIfIsSuccess)
        {
            // 策略模式，最后一步，走完，去检查是否成功
            self.userInteractionEnabled = NO;
            [self panGestEndStateGes:panGes endPoint:point];
            DebugLog(@"怎么办");
        }
    }
    else if(panGes.state == UIGestureRecognizerStateEnded)
    {
        if (_directionForPan == YFPanGestureBeginDirecionFailPass)
        {
            //            __weak typeof(self)weakS = self;
            //            [self setWhenBeginAfterFailBlock:^{
            //                weakS.directionForPan = YFPanGestureBeginDirecionNone;
            //                [weakS.logicHandle panGest:panGes endPoint:point];
            //            }];
            
        }else
        {
            [self panGestEndStateGes:panGes endPoint:point];
        }
        
        DebugLog(@"结束");
    }
    else
    {
        DebugLog(@"未知 状态:%ld",panGes.state);
    }
}

-(void)panGestEndStateGes:(UIPanGestureRecognizer *)panGes endPoint:(CGPoint)point
{
    _directionForPan = YFPanGestureBeginDirecionNone;
    
    [_logicHandle panGest:panGes endPoint:point];
    
    if (self.playWhenStepCompleted)
    {
        self.playWhenStepCompleted();
    }
    
//    [[YFAppService shareInstance] playWhenStepCompleted];
}



-(void)whenBeginAfterFail
{
    _directionForPan = YFPanGestureBeginDirecionNone;
    
    [_logicHandle panGest:_panGes endPoint:_tempPoint];
}



-(void)buttonAction:(UIButton *)button
{
    
}

#pragma mark check pan direction on the beginning

-(void)checkDirectionWithPoint:(CGPoint)point
{
    CGFloat gapX = point.x  - _beginPointFromPan.x;
    
    CGFloat gapY = point.y - _beginPointFromPan.y;
    
    if (gapY == 0 || ABS(gapX) > ABS(gapY))
    {
        _directionForPan = YFPanGestureBeginDirecionHorizontal;
        
        
        _logicHandle = _horizonHandle;
        
        DebugLog(@"水平滑动");
    }
    else if (gapX == 0 || ABS(gapY) > ABS(gapX))
    {
        _directionForPan = YFPanGestureBeginDirecionVertical;
        
        _logicHandle = _verticalHandle;
        
        
        DebugLog(@"纵向");
    }
    else
    {
        _directionForPan = YFPanGestureBeginDirecionNoHandle;
        
        DebugLog(@"不做处理的滑动");
    }
}


-(YFBaseCubeView *)creatViewWithFrame:(CGRect)frame
{
    //    YFMVImageView //图片
    //    YFMVTextView // 文字
    YFBaseCubeView * cubeObjectView = [[YFMVImageView alloc] initWithFrame:frame];
    
    if (_gameImage)
    {
        cubeObjectView = [[YFMVImageView alloc] initWithFrame:frame];
    }else if(self.textArray)
    {
        cubeObjectView = [[YFMVTextView alloc] initWithFrame:frame];
    }
    
    return cubeObjectView;
}

-(void)checkSucceed
{
    self.userInteractionEnabled = NO;
    
    for (YFMVViewModel *model in _arrayForCube)
    {
        if (model.indexForArray != model.correctIndex)
        {
            self.userInteractionEnabled = YES;
            
            if (self.directionForPan  == YFPanGestureBeginDirecionCheckIfIsSuccess)
            {
                if (self.failBlock) // 策略模式，最后一步 失败
                {
                    self.failBlock();
                }
                DebugLog(@"失败11");
            }
            DebugLog(@"失败00");
            return;
        }
    }
    self.userInteractionEnabled = YES;
    
    
    if (self.successBlock)
    {
        self.successBlock();
    }
    
    
    
}


-(void)showImageFromImageArray:(NSArray *)array
{
    
    for (NSInteger i = 0; i < array.count; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30 * i, 30, 30)];
        
        imageView.image = array[i];
        imageView.backgroundColor = [UIColor redColor];
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        imageView.layer.borderWidth = 0.5;
        [self addSubview:imageView];
    }
    
}


@end
