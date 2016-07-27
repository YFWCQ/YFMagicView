//
//  YFBaseCubeView.h
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YFMVDataModel.h"


@interface YFBaseCubeView : UIView

//@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)YFMVDataModel *dataModel;

// 复制 本类的 特性 到 View 上
-(void)setSelfFeatureFromView:(YFBaseCubeView *)view;

// 子类 实现这个方法
-(void)setViewWithDataModel:(YFMVDataModel *)dataModel;


@end
