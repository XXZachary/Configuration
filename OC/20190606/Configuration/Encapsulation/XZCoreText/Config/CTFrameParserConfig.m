//
//  CTFrameParserConfig.m
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/13.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

//初始化
-(instancetype)init{
    self = [super init];
    if (self) {
        _fontSize = 16.0;
        _fontName = @"ArialMT";
        _lineSpace = 1.0f;
        _width = 200.f;
        _textColor = [UIColor blackColor];
    }
    return self;
}

@end
