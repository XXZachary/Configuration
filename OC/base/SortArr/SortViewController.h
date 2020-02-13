//
//  SortViewController.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 15/12/1.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const xMyNeedContentNotification;

@interface SortViewController : UIViewController

/**
 *  传入数据源,进行排序分组,显示数据
 *
 *  @param sortArray            字符串类型的数据源
 *  @param navigatioinTitle  下一页的标题
 *  @param requrieType        数据源类型, 大于0
 *  @return                             YES 参数信息输入正确, NO 参数信息输入错误
 */
- (BOOL)sortWithArray:(NSArray *)sortArray title:(NSString *)navigatioinTitle type:(NSInteger)requrieType;

@end

/*!
    v 1.2
    1.索引只有一个时,不显示索引,且不显示头视图
    2.数据源类型的判断key值是 type
    3.选择的内容key值是 content
    3.属性改成方法, 含返回值
    4.参数不能为空
 */

NS_ASSUME_NONNULL_END
