//
//  UIImage+YFCategory.m
//  YFMagicView
//
//  Created by FYWCQ on 16/7/26.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "UIImage+YFCategory.h"

typedef void (*FilterCallback)(UInt8 *pixelBuf, UInt32 offset, void *context);
#define SAFECOLOR(color) MIN(255,MAX(0,color))

@implementation UIImage (YFCategory)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageNaviWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, .5, .5);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(NSMutableArray *)imageCutRow:(NSUInteger)row column:(NSUInteger)column
{
    NSMutableArray *imagesArray = [NSMutableArray array];
    CGSize totalSize = CGSizeMake(self.size.width , self.size.height);
    //    NSLog(@"-----:%@",NSStringFromCGSize(totalSize));
    
    
    CGFloat imageWidht = (NSInteger)(totalSize.width / (CGFloat)column);
    CGFloat imageHeight = (NSInteger)(totalSize.height / (CGFloat)row);
    
    UIImage *sourceImage = [UIImage resizeImage:self size:self.size];
    
    for (NSInteger i = 0; i < row * column; i ++)
    {
        CGRect imageRect = CGRectMake(imageWidht * (i % column), imageHeight * (i / column), imageWidht, imageHeight);;
        
        CGImageRef ref = CGImageCreateWithImageInRect(sourceImage.CGImage, imageRect);
        UIImage *newImage = [UIImage imageWithCGImage:ref];
        
        if (newImage) {
            [imagesArray addObject:newImage];
        }
        else
        {
            //            if (ref == nil)
            //            {
            //                NSLog(@"空空8888888空空空");
            //
            //            }
            //
            //            if (sourceImage.CGImage) {
            //                NSLog(@"afadfafsafsdfsafadsfdsfddsaf");
            //            }
            //
            //            NSLog(@"空空空空空空空空空空空");
        }
        //        NSLog(@"个数:::%ld",imagesArray.count);
        CGImageRelease(ref);
        
    }
    return imagesArray;
}

// resize the original image and return a new UIImage object
+ (UIImage *) resizeImage:(UIImage *)image size:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
