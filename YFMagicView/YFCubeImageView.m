//
//  YFCubeImageView.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFCubeImageView.h"
//#import "YFImageModel.h"

@implementation YFCubeImageView
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
        
    }
    return self;
}

//-(void)setTitle:(NSString *)title
//{
//    if([title isEqualToString:self.title] == NO)
//    {
//        [super setTitle:title];
//        _imageView.image = [UIImage imageNamed:title];
//    }
//}

//-(void)setDataModel:(YFImageModel *)dataModel
//{
//    if ([dataModel.keyOfImage isEqualToString:self.dataModel.keyOfImage] == NO)
//    {
//        _imageView.image = dataModel.imageYF;
////        [super setDataModel:dataModel];
//    }
//    
//    //    if ([dataModel isEqual:self.dataModel] == NO)
//    //    {
//    //        _imageView.image = dataModel.imageYF;
//    //        [super setDataModel:dataModel];
//    //    }
//}
//
//-(void)setSelfFeatureFromView:(UIView *)view
//{
//    YFCubeImageView *cubeView = (YFCubeImageView *)view;
//    
//    self.dataModel = cubeView.dataModel;
//    //    if ([self.dataModel.keyOfImage isEqualToString:cubeView.dataModel.keyOfImage] == NO)
//    //    {
//    //        _imageView.image = cubeView.dataModel.imageYF;
//    //        self.dataModel = cubeView.dataModel;
//    //    }
//}



@end
