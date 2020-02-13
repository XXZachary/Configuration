//
//  XXZShowAlert.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 15/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//extern NSString *const xAlertViewNotification;
//extern NSString *const xSheetActionNotification;

@protocol XXZShowAlertDelegate <NSObject>

- (void)alertViewWithAction:(UIAlertAction *)action index:(NSInteger)index tag:(NSInteger)tag;
- (void)actionSheetWithAction:(UIAlertAction *)action index:(NSInteger)index tag:(NSInteger)tag;

@end

//type
typedef NS_ENUM(NSInteger, XXZAlertControllerStyle) {
    XXZStyleActionSheet = 1,
    XXZStyleAlert
}NS_ENUM_AVAILABLE_IOS(8_0);

//alert view button index
typedef NS_ENUM(NSInteger, XXZButtonIndex) {
    XXZButtonIndexCancel = -1,//cancel
    XXZButtonIndexZero = 0,     //ok0
    XXZButtonIndexOne             //ok1
    //....                                          //ok...
}NS_ENUM_AVAILABLE_IOS(8_0);

//sheet action button index

NS_CLASS_AVAILABLE_IOS(8_0) @interface XXZShowAlert : NSObject

//@property (nonatomic, assign) XXZButtonIndex buttonIndex;
//@property (nonatomic, assign) XXZAlertControllerStyle style;
@property (nonatomic, weak) id<XXZShowAlertDelegate>delegate;

@property (nonatomic, assign) NSInteger tag;

/**
 *  alert view
 *
 *  @param vc     控制器
 *  @param title  标题
 *  @param msg    信息
 *  @param okName 确定按钮
 */
- (void)alertWithAlertView:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)msg okAction:(nullable NSString *)okName;

/**
 *  remove alert view
 *
 *  @param vc 控制器
 */
- (void)removeAlertWithViewController:(UIViewController *)vc;

/**
 *  action sheet
 *
 *  @param vc          控制器
 *  @param title       标题
 *  @param msg         信息
 *  @param actionArray 按钮数组
 */
- (void)alertWithActionSheet:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)msg action:(NSArray *)actionArray;

/*!auto cancel alert view*/


@end

NS_ASSUME_NONNULL_END

/*
 添加响应事件的通知,获取对应的响应事件
 
 //1 - 注册alertView点击响应的通知
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertViewAction1:) name:xAlertViewNotification object:nil];
 
 //2 - 注册sheetAction点击响应的通知
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sheetAction1:) name:xSheetActionNotification object:nil];
 
 //-1 是取消, >=0 是其他按钮
 //click sheet action
 - (void)sheetAction1:(NSNotification *)noti {
    NSInteger buttonIndex = [[noti object] integerValue];
    XXZLog(@"buttonIndex = %ld", buttonIndex);
 }
 
 //click alert action
 - (void)alertViewAction1:(NSNotification *)noti {
    NSInteger buttonIndex = [[noti object] integerValue];
    XXZLog(@"buttonIndex = %ld", buttonIndex);
 }
 
 */
