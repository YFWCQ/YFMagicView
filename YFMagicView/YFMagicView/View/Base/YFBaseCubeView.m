//
//  YFBaseCubeView.m
//  YFMagicView
//
//  Created by FYWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseCubeView.h"

@implementation YFBaseCubeView

-(void)setDataModel:(YFMVDataModel *)dataModel
{
    if ([dataModel.identifierStr isEqualToString:self.dataModel.identifierStr] == NO)
    {
        [self setViewWithDataModel:dataModel];
        _dataModel = dataModel;
    }
}

-(void)setViewWithDataModel:(YFMVDataModel *)dataModel
{
    
}

-(void)setSelfFeatureFromView:(YFBaseCubeView *)view
{
    self.dataModel = view.dataModel;
}

@end
