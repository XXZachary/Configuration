//
//  CancelKeyboardProtocol.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol CancelKeyboardProtocol <NSObject>

@required
/**
 *  收回键盘
 *
 *  @param textField 参数
 */
- (void)cancelCustomKeyboard:(nonnull UITextField *)textField;

//车牌号键盘删除
- (void)deleteWithContent;

@end
