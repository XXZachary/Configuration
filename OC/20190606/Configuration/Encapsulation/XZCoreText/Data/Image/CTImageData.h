//
//  CTImageData.h
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/14.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTImageData : NSObject

@property (nonatomic, copy) NSString *name; //图片资源名称
@property (nonatomic, copy) NSString *width; //放图片的宽
@property (nonatomic, copy) NSString *height; //放图片的高
@property (nonatomic, assign) CGFloat position; //图片位置的起始点
@property (nonatomic, assign) CGRect imageRect; //图片的尺寸

@end

NS_ASSUME_NONNULL_END
