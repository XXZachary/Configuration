//
//  DigitalKeyboard.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XXZKeyboardType) {
    XXZKeyboardTypeDefault, //默认键盘, 即数字键盘
    XXZKeyboardTypeNumberPad = XXZKeyboardTypeDefault, //数字键盘
    XXZKeyboardTypeDecimalPad //有小数点的数字键盘
};

@interface DigitalKeyboard : UIView

/**
 * 输入数字的个数
 */
@property (nonatomic) NSInteger digitalCount;

/**
 * 键盘的类型
 */
@property (nonatomic) XXZKeyboardType keyBoardType;

/**
 *  自定义数字键盘
 *
 *  @param textFiled 选择键盘上的内容发送到指定的位置
 */
-(void)setCustomKeyboard:(id<UITextInput>)textFiled;

@end

NS_ASSUME_NONNULL_END

/**
 //数字键盘
 - (void)loadDigitalKeyboard:(id<UITextInput>)textField keyboardType:(XXZKeyboardType)keyboardType{
        DigitalKeyboard *digitalKeyboard = [[DigitalKeyboard alloc] initWithFrame:CGRectZero];
        digitalKeyboard.keyBoardType = keyboardType;
        [digitalKeyboard setCustomKeyboard:textField];
 }
 */