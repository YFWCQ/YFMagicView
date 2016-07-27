//
//  YFCubeView.m
//  YFMagicView
//
//  Created by YFWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFCubeView.h"

#import "YFHeader.h"

@implementation YFCubeView
{
    UIColor *_textColor;
    
    UIFont *_textFont;
    
    NSMutableParagraphStyle *_paragraphStyle;
    
    CGRect _placeHolderRect;
}
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    
//    if (self)
//    {
//        _textColor =[UIColor blackColor];
//        
//        
//        _textFont = [UIFont systemFontOfSize:20];
//        
//        _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        _paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
//        _paragraphStyle.alignment = NSTextAlignmentCenter;
//    }
//    return self;
//}
//
///*
// // Only override drawRect: if you perform custom drawing.
// // An empty implementation adversely affects performance during animation.
// */
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//    [super drawRect:rect];
//    
//    [_textColor set];
//    
////    [self.title drawInRect:_placeHolderRect
////            withAttributes:@{ NSFontAttributeName :_textFont,
////                              NSForegroundColorAttributeName : _textColor,
////                              NSParagraphStyleAttributeName : _paragraphStyle }];
//    
//}
//
//
//-(void)setSelfFeatureFromView:(UIView *)view
//{
//    YFCubeView *cubeView = (YFCubeView *)view;
//    
////    self.title = cubeView.title;
//}
//
//-(void)setTitle:(NSString *)title
//{
////    if([title isEqualToString:self.title] == NO)
////    {
////        //        DebugLog(@"%@ -*****************************-> %@",_title,title);
////        
////        
////        [super setTitle:title];
////        
////        CGSize size =  YF_MULTILINE_TEXTSIZE(title, _textFont, self.frame.size, 0);
////        
////        _placeHolderRect = CGRectMake((self.frame.size.width - size.width)/2,(self.frame.size.height - size.height)/2,size.width,size.height);
////        
////        
////        [self setNeedsDisplay];
////    }
//}


@end
