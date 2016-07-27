//
//  YFMVImageView.m
//  YFMagicView
//
//  Created by FYWCQ on 16/7/27.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFMVImageView.h"

@implementation YFMVImageView
{
    UIImageView *_imageView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 2.;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = UIColor.grayColor.CGColor;
        self.layer.borderWidth = .5;
    }
    return self;
}

-(void)setViewWithDataModel:(YFMVDataModel *)dataModel
{
    _imageView.image = dataModel.dataModel;
}

@end