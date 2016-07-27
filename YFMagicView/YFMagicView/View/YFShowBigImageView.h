//
//  YFShowBigImageView.h
//  YFMagicView
//
//  Created by FYWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFShowBigImageView : UIControl

+(instancetype)defaultShowBigIV;

-(void)showImage:(UIImage *)image imageOriginFrame:(CGRect)originFrame cometion:(void(^)())completion;

-(void)showImage:(UIImage *)image;

-(void)show;

-(void)hide;

@end
