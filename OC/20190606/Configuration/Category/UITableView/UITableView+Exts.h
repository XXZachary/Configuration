//
//  UITableView+Exts.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 2018/10/16.
//  Copyright © 2018年 com.xxzing.future. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXZEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Exts)

- (void)showNoData:(BOOL)isNoData type:(XXZNoDataType)type;

@end

NS_ASSUME_NONNULL_END
