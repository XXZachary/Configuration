//
//  NSString+attributes.h
//  CloudStudy
//
//  Created by zjk on 2017/5/23.
//  Copyright © 2017年 Gotta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (attributes)

- (CGFloat)stringWidthWithFont:(UIFont *)font maxHeight:(CGFloat)height;

- (CGFloat)stringHeightWithFont:(UIFont *)font maxWidth:(CGFloat)width;

@end
