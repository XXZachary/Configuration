//
//  NSString+TimeStamp.h
//  ipadTemp
//
//  Created by xiaoming on 16/12/15.
//  Copyright © 2016年 Risenb App Department With iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TimeStamp)

///------------------------------------------------------
/// @(自定义时间样式)  mark
///------------------------------------------------------
- (NSString *)timeStamp13ToDateWithFormatter:(NSString *)formmatter;

- (NSString *)timeStamp10ToDateWithFormatter:(NSString *)formmatter;

@end
