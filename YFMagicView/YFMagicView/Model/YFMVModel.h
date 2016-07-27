//
//  YFMVModel.h
//  YFMagicView
//
//  Created by FYWCQ on 16/7/27.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YFMVModel : NSObject

/**
 *  需要显示的数据 UIImage NSString ...
 */
@property(nonatomic,strong)id dataModel;

/**
 * 唯一标示
 */
@property(nonatomic,copy)NSString *identifierStr;


@end
