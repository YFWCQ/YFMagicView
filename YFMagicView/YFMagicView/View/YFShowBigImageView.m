//
//  YFShowBigImageView.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFShowBigImageView.h"

#define YFAnimationDuration 0.3f

@interface YFShowBigImageView()

@property(nonatomic,strong)UIImageView *bigImageView;

@property(nonatomic,assign)CGRect showFrame;
@property(nonatomic,assign)CGRect imageOriginFrame;

@property(nonatomic,strong)UIView *backGroungView;

@property(nonatomic,copy)void(^completion)();


@end

@implementation YFShowBigImageView


+(instancetype)defaultShowBigIV
{
    YFShowBigImageView *showIV = [[YFShowBigImageView alloc] initWithFrame:CGRectZero];
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:showIV];
    
    return showIV;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.backGroungView];
        [self addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        self.hidden = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer * tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(controlEvent:)];
        
        [self.bigImageView addGestureRecognizer:tapLeft];
    }
    return self;
}

-(void)controlEvent:(id)sender
{
    [self hide];
}

-(void)showImage:(UIImage *)image imageOriginFrame:(CGRect)originFrame cometion:(void(^)())completion
{
    if (self.hidden == NO)
    {
        return;
    }
    
    self.completion = completion;
    _imageOriginFrame = originFrame;
    self.bigImageView.frame = originFrame;
    self.bigImageView.image = image;
    [UIView animateWithDuration:YFAnimationDuration animations:^{
        self.bigImageView.frame = [self maxFrameFromImage:image];
    }];
    
    [self showWithOriginTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
}

-(void)showImage:(UIImage *)image
{
    self.bigImageView.frame = [self maxFrameFromImage:image];
    
    self.bigImageView.image = image;
    
    [self showWithOriginTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
}



-(void)show
{
    [self showWithOriginTransform:CGAffineTransformMakeScale(.01f, .01f)];
}

-(void)showWithOriginTransform:(CGAffineTransform)transform
{
    if (self.hidden == NO)
    {
        return;
    }
    __weak typeof(self)weakSelf = self;
    
    self.frame = self.showFrame;
    
    self.hidden = NO;
    self.backGroungView.alpha = 0.0;
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:YFAnimationDuration delay:0. options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakSelf.backGroungView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        weakSelf.userInteractionEnabled = YES;
    }];
    
}

-(void)hideWithOriginTransform:(CGAffineTransform)transform
{
    if (self.hidden == YES)
    {
        return;
    }
    __weak typeof(self)weakSelf = self;
    
    self.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:YFAnimationDuration delay:0. options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.backGroungView.alpha = 0.0;
        //        weakSelf.transform = transform;
        if (weakSelf.imageOriginFrame.size.width > 0)
        {
            weakSelf.bigImageView.frame = weakSelf.imageOriginFrame;
        }
    } completion:^(BOOL finished) {
        weakSelf.userInteractionEnabled = YES;
        weakSelf.hidden = YES;
        if (weakSelf.completion) {
            weakSelf.completion();
        }
        //        weakSelf.transform = CGAffineTransformMakeScale(1.f, 1.f);
    }];
    
}

-(void)hide
{
    [self hideWithOriginTransform:CGAffineTransformMakeScale(1.0f, 1.0f)];
}



-(UIImageView *)bigImageView
{
    if (_bigImageView == nil) {
        _bigImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_bigImageView];
    }
    return _bigImageView;
}

-(CGRect)showFrame
{
    return [[[UIApplication sharedApplication] delegate] window].bounds;
}

-(UIView *)backGroungView
{
    if (_backGroungView == nil)
    {
        _backGroungView = [[UIView alloc] initWithFrame:self.bounds];
        _backGroungView.backgroundColor = [UIColor whiteColor];
        _backGroungView.userInteractionEnabled = NO;
    }
    return _backGroungView;
}

#pragma Setter
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.backGroungView.frame = self.bounds;
}

#pragma mark  根据 图片 得到 一张最大显示的 图片
-(CGRect)maxFrameFromImage:(UIImage *)image
{
    CGFloat scale = image.size.width / image.size.height;
    
    CGFloat width = self.showFrame.size.width;
    
    CGFloat height = width / scale;
    
    if (height > self.showFrame.size.height)
    {
        height = self.showFrame.size.height;
        
        width = height * scale;
    }
    return CGRectMake((self.showFrame.size.width - width) / 2.0, (self.showFrame.size.height - height) / 2.0, width, height);
}


@end
