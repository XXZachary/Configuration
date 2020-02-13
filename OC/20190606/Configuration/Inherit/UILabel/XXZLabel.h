//
//  XXZUILabel.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XXZTextAlignment ) {
    XXZTextAlignmentTypeMiddleCenterTop = 0, //水平居中 上对齐
    XXZTextAlignmentTypeMiddleCenter, //居中对齐
    XXZTextAlignmentTypeMiddleCenterBottom, //水平居中 下对齐
    
    XXZTextAlignmentTypeLeftTop, //左上对齐
    XXZTextAlignmentTypeLeftCenter, //垂直居中 左对齐
    XXZTextAlignmentTypeLeftBottom, //左下对齐
    
    XXZTextAlignmentTypeRightTop, //右上对齐
    XXZTextAlignmentTypeRightCenter, //垂直居中 右对齐
    XXZTextAlignmentTypeRightBottom, //右下对齐
    
    XXZTextAlignmentTypeDefault = XXZTextAlignmentTypeMiddleCenter //默认居中对齐
};

@interface XXZLabel : UILabel

@property (nonatomic) XXZTextAlignment textAlignmentType;

@end
