//
//  CTLinkUnit.h
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/15.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CTData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTLinkUnit : NSObject

/**
 *  检测点击位置是否在链接上
 *
 *  view  点击区域
 *  point 点击坐标
 *  data  数据源
 */
+ (CTLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CTData *)data;

@end

NS_ASSUME_NONNULL_END
