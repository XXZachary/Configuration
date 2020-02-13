//
//  CTFrameParserConfig.h
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/13.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTFrameParserConfig : NSObject

/**配置属性*/
@property (nonatomic, assign) CGFloat width; //内容宽度
@property (nonatomic, assign) CGFloat lineSpace; //行间距
@property (nonatomic, assign) CGFloat fontSize; //字体号
@property (nonatomic, copy) NSString *fontName; //字体名称
@property (nonatomic, strong) UIColor *textColor; //字体颜色

@end

NS_ASSUME_NONNULL_END
