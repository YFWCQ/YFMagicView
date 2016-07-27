//
//  YFMVTextView.m
//  YFMagicView
//
//  Created by FYWCQ on 16/7/27.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFMVTextView.h"

@implementation YFMVTextView
{
    UILabel *_label;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.font = [UIFont boldSystemFontOfSize:60];
        _label.textColor = [UIColor brownColor];
        _label.textAlignment = NSTextAlignmentCenter;
        
        self.layer.cornerRadius = 2.;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = UIColor.grayColor.CGColor;
        self.layer.borderWidth = .5;
        
        [self addSubview:_label];
    }
    return self;
}


-(void)setViewWithDataModel:(YFMVDataModel *)dataModel
{
    _label.text = dataModel.dataModel;
}



@end
