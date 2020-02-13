//
//  XXZUILabel.m
//  RuntimeDemo
//
//  Created by Jiayu_Zachary on 2017/1/11.
//  Copyright © 2017年 Zachary. All rights reserved.
//

#import "XXZLabel.h"

@implementation XXZLabel

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignmentType = XXZTextAlignmentTypeDefault; //默认 居中对齐
    }
    return self;
}

- (void)setTextAlignmentType:(XXZTextAlignment)textAlignmentType {
    _textAlignmentType = textAlignmentType;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.textAlignmentType) {
        case XXZTextAlignmentTypeMiddleCenterTop:
            textRect.origin = CGPointMake((CGRectGetWidth(bounds) - CGRectGetWidth(textRect)) / 2, textRect.origin.y);
            break;
        case XXZTextAlignmentTypeMiddleCenter: //默认 上下左右居中
            textRect.origin = CGPointMake((CGRectGetWidth(bounds) - CGRectGetWidth(textRect)) / 2, (CGRectGetHeight(bounds) - CGRectGetHeight(textRect)) / 2);
            break;
        case XXZTextAlignmentTypeMiddleCenterBottom:
            textRect.origin = CGPointMake((CGRectGetWidth(bounds) - CGRectGetWidth(textRect)) / 2, CGRectGetMaxY(bounds) - textRect.size.height);
            break;
            
        case XXZTextAlignmentTypeLeftTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case XXZTextAlignmentTypeLeftCenter:
            textRect.origin.y = (CGRectGetMaxY(bounds) - textRect.size.height) / 2;
            break;
        case XXZTextAlignmentTypeLeftBottom:
            textRect.origin.y = CGRectGetMaxY(bounds) - textRect.size.height;
            break;
            
        case XXZTextAlignmentTypeRightTop:
            textRect.origin.x = CGRectGetMaxX(bounds) - textRect.size.width;
            break;
        case XXZTextAlignmentTypeRightCenter:
            textRect.origin = CGPointMake(CGRectGetMaxX(bounds)-textRect.size.width, (CGRectGetMaxY(bounds) - textRect.size.height) / 2);
            break;
        case XXZTextAlignmentTypeRightBottom:
            textRect.origin = CGPointMake(CGRectGetMaxX(bounds) - textRect.size.width, CGRectGetMaxY(bounds) - textRect.size.height);
            break;
            
        default:
            XXZLog(@"请检查...");
    }
    
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

#pragma mark - 计算UILabel上某段文字的frame
- (CGRect)boundingRectForCharacterRange:(NSRange)range {
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[self attributedText]];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[self bounds].size];
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
