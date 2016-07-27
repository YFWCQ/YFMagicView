//
//  YFSampleViewController.m
//  YFMagicView
//
//  Created by FYWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFSampleViewController.h"

#import "YFMagicGameView.h"
#import "YFHeader.h"

// 根据 现有的图片的宽高，在一个size的范围内，把他最大限度的显示
static CGSize CGSizeMax_YF(CGFloat maxWidth, CGFloat maxHeight,CGFloat scale)
{
    CGFloat width = maxWidth;
    CGFloat height = width / scale;
    
    if (height > maxHeight)
    {
        height = maxHeight;
        
        width = height * scale;
    }
    return CGSizeMake(width, height);
}

@interface YFSampleViewController ()

@property(nonatomic,strong)YFMagicGameView *mcMagicView;


@end

@implementation YFSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (self.gameImage == nil && self.textArray.count == 0)
    {
        return;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    _mcMagicView = [[YFMagicGameView alloc] initWithFrame:[self gameViewFrame]];
    _mcMagicView.rows = _rows;
    _mcMagicView.columns = _columns;
    _mcMagicView.gameImage = _gameImage;
    
    _mcMagicView.textArray = self.textArray;
    _mcMagicView.gameImage = self.gameImage;
    
    [_mcMagicView loadPlayGameView];
    [self.view addSubview:_mcMagicView];
}

-(CGRect )gameViewFrame
{
   CGFloat  maxWidth = self.view.frame.size.width - self.view.frame.size.width * 0.2;
    
   CGFloat  maxHeight = SH_YF  - 64.0;

   CGSize size = CGSizeMax_YF(maxWidth, maxHeight, self.gameViewScale);
    
    CGFloat xx = (self.view.frame.size.width  - size.width) / 2.0;

    CGFloat yy = 64.0 +  40  + (maxHeight + 10 * 2  - size.height) / 2.0;

    return CGRectMake(xx, yy, size.width, size.height);
}

-(CGFloat)gameViewScale
{
    if (_gameViewScale <=0 && _gameImage)
    {
        _gameViewScale = _gameImage.size.width / _gameImage.size.height;
    }else if (_gameViewScale <= 0.3)
    {
        _gameViewScale = 0.3;
    }else if(_gameViewScale >= 3)
    {
        _gameViewScale = 3;
    }
    return _gameViewScale;
}




@end
