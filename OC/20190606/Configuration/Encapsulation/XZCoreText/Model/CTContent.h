//
//  CTContent.h
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/14.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CTContentType) {
    CTContentTypeTxt, //文本
    CTContentTypeImage, //图片
    CTContentTypeLink //链接
};

@interface CTContent : NSObject

//类型, 必填
@property (nonatomic) CTContentType type;

//文本
@property (nonatomic, copy) NSString *content; //文本
@property (nonatomic, copy) NSString *fontSize; //字体大小

@property (nonatomic, strong) UIColor *textColor; //文本颜色
@property (nonatomic, strong) UIColor *backColor; //文本背景颜色

@property (nonatomic, assign) BOOL isHaveUnderline; //是否有下划线

@property (nonatomic, assign) CGFloat kern; //字间距
@property (nonatomic, assign) CGFloat lineSpace; //行间距

//图片
@property (nonatomic, copy) NSString *width; //图片显示的宽度
@property (nonatomic, copy) NSString *height; //图片显示的高度
@property (nonatomic, copy) NSString *name; //图片的名称

//链接
//@property (nonatomic, copy) NSString *linkContent; //赋值给content
//@property (nonatomic, copy) NSString *linkFontSize; //赋值给fontSize
@property (nonatomic, copy) NSString *linkUrl;
//@property (nonatomic, strong) UIColor *linkColor; //赋值给color

@end

NS_ASSUME_NONNULL_END
