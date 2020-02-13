//
//  NSString+attributes.m
//  CloudStudy
//
//  Created by zjk on 2017/5/23.
//  Copyright © 2017年 Gotta. All rights reserved.
//

#import "NSString+attributes.h"

@implementation NSString (attributes)

- (CGFloat)stringWidthWithFont:(UIFont *)font maxHeight:(CGFloat)height {
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return titleSize.width;
}

- (CGFloat)stringHeightWithFont:(UIFont *)font maxWidth:(CGFloat)width {
    CGSize titleSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return titleSize.height;
}

@end
