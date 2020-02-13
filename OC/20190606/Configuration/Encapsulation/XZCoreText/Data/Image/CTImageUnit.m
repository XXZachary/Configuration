//
//  CTImageUnit.m
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/15.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import "CTImageUnit.h"

@implementation CTImageUnit

+ (CTImageData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CTData *)data {
    for (CTImageData *imagData in data.imageArray) {
        //翻转坐标系，因为ImageData中的坐标是CoreText的坐标系
        CGRect imageRect = imagData.imageRect;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = view.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        
        //检测点击位置Point是否在rect之内
        if (CGRectContainsPoint(rect, point)) {
            return imagData;
        }
    }
    
    return nil;
}

@end
