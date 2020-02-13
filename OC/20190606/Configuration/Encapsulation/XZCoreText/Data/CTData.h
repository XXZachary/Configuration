//
//  CTData.h
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/13.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

#import "CTContent.h"
#import "CTImageData.h"
#import "CTLinkData.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTData : NSObject

@property (assign, nonatomic) CTFrameRef ctFrame; //绘制内容的区域
@property (assign, nonatomic) CGFloat ctHeight; //内容高
@property (assign, nonatomic) CGFloat ctWidth; //内容宽

@property (nonatomic, strong) NSMutableArray <CTImageData *> *imageArray; //图片资源
@property (strong, nonatomic) NSMutableArray <CTLinkData *> *linkArray; //链接资源

@end

NS_ASSUME_NONNULL_END
