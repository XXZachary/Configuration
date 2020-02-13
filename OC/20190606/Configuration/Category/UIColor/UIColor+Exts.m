//
//  UIColor+Exts.m
//  Author From Xavier Zachary
//
//  Created by Zachary on 2019/6/6.
//  Copyright © 2019 www.xxzachary.com. All rights reserved.
//

#import "UIColor+Exts.h"

@implementation UIColor (Exts)

+ (UIColor *)colorWithHexString:(NSString *)colorStr {
    if (colorStr.length == 6) {
        colorStr = [NSString stringWithFormat:@"#%@", colorStr];
    }
    
    return UICOLOR_FROM(colorStr);
}

@end
