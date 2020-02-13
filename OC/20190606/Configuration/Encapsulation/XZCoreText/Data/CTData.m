//
//  CTData.m
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/13.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import "CTData.h"

@implementation CTData

#pragma mark - setter
//CoreFoundation不支持ARC
- (void)setCtFrame:(CTFrameRef)ctFrame{
    if (_ctFrame != ctFrame) {
        if (_ctFrame !=nil) {
            CFRelease(_ctFrame);
        }
    }
    
    CFRetain(ctFrame);
    _ctFrame = ctFrame;
}

#pragma mark - dealloc
- (void)dealloc{
    if (_ctFrame != nil) {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}

#pragma mark - 图片资源
- (void)setImageArray:(NSMutableArray<CTImageData *> *)imageArray {
    _imageArray = imageArray;
    [self fillImagePosition];
    
}

//填充图片及获取图片具体位置
- (void)fillImagePosition{
    if (self.imageArray.count==0) {
        return;
    }
    
    NSArray *lines = (NSArray *)CTFrameGetLines(self.ctFrame);
    NSInteger lineCount = [lines count];
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    int imgIndex = 0;
    CTImageData *imageData = self.imageArray[0];
    for (int i=0; i<lineCount; i++) {
        if (imageData==nil) {
            break;
        }
        
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray *runObjArray = (NSArray *)CTLineGetGlyphRuns(line);
        for (id runObj in runObjArray) {
            CTRunRef run = (__bridge CTRunRef)runObj;
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            
            if (delegate == nil) {
                continue;
            }
            
            CTContent *ctContent = CTRunDelegateGetRefCon(delegate);
            if (![ctContent isKindOfClass:[CTContent class]]) {
                continue;
            }
            
            CGRect runBounds;
            CGFloat ascent; //获取上距
            CGFloat descent; //获取下距
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            
            CGFloat x0ffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + x0ffset;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y -= descent;
            
            CGPathRef pathRef = CTFrameGetPath(self.ctFrame);
            CGRect colRect = CGPathGetBoundingBox(pathRef);
            CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            
            imageData.imageRect = delegateBounds;
            imgIndex ++;
            if (imgIndex == self.imageArray.count) {
                imageData = nil;
                break;
            }
            else{
                imageData = self.imageArray[imgIndex];
            }
        }
    }
}

@end
