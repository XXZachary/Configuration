//
//  CTFrameParser.m
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/13.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import "CTFrameParser.h"

@implementation CTFrameParser

#pragma mark - 富文本: 包含文本, 图片, 链接
+ (CTData *)parseContents:(NSMutableArray<CTContent *> *)contents config:(CTFrameParserConfig *)config {
    NSMutableArray *imageDataArr = [NSMutableArray array];
    NSMutableArray *linkDataArr = [NSMutableArray array];
    
    NSAttributedString *content = [self loadTemplateFile:contents config:config imageArray:imageDataArr linkArray:linkDataArr];
    
    CTData *ctData = [self parseAttributedContent:content config:config];
    ctData.imageArray = imageDataArr;
    ctData.linkArray = linkDataArr;
    
    return ctData;
}

//解析内容
+ (NSAttributedString *)loadTemplateFile:(NSMutableArray<CTContent *> *)contents config:(CTFrameParserConfig *)config imageArray:(NSMutableArray *)imageArray linkArray:(NSMutableArray *)linkArray {
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    for (CTContent *ctContent in contents) {
        if (ctContent.type == CTContentTypeTxt) { //文本
            NSAttributedString *tmpAttri = [self parseAttributeContentFromCTContent:ctContent config:config];
            [result appendAttributedString:tmpAttri];
        }
        else if (ctContent.type == CTContentTypeImage) { //图片
            CTImageData *ctImageData = [[CTImageData alloc] init];
            ctImageData.name = ctContent.name;
            ctImageData.width = ctContent.width;
            ctImageData.height = ctContent.height;
            ctImageData.position = [result length];
            
            [imageArray addObject:ctImageData];
            
            //创建空白占位符，并且设置它的CTRunDelegate信息
            NSAttributedString *tmpAttri = [self parseImageDataFromCTContent:ctContent config:config];
            [result appendAttributedString:tmpAttri];
        }
        else if (ctContent.type == CTContentTypeLink) { //链接
            NSUInteger startPoint = result.length;
            NSAttributedString *as = [self parseAttributeContentFromCTContent:ctContent config:config];
            [result appendAttributedString:as];
            
            //创建CTLinkData
            NSUInteger length = result.length - startPoint;
            NSRange linkRange = NSMakeRange(startPoint, length);
            
            CTLinkData *linkData = [[CTLinkData alloc] init];
            linkData.title = ctContent.content;
            linkData.url = ctContent.linkUrl;
            linkData.range = linkRange;
            
            [linkArray addObject:linkData];
        }
    }
    
    return  result;
}

//设置富文本属性
+ (NSAttributedString *)parseAttributeContentFromCTContent:(CTContent *)ctContent config:(CTFrameParserConfig *)config {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesWithConfig:config]];
    
    //颜色
    UIColor *textColor = ctContent.textColor;
    if (textColor) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    }
    
    //背景颜色
    UIColor *backColor = ctContent.backColor;
    if (backColor) {
        attributes[(id)kCTBackgroundColorAttributeName] = (id)backColor.CGColor;
    }
    
    //大小
    CGFloat fontSize = [ctContent.fontSize floatValue];
    if (fontSize>0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    
    //下划线
    BOOL isHaveUnderline = ctContent.isHaveUnderline;
    if (isHaveUnderline) {
        attributes[(id)kCTUnderlineStyleAttributeName] = @(kCTUnderlineStyleSingle);
        attributes[(id)kCTUnderlineColorAttributeName] = (id)textColor.CGColor;
    }
    
    //字间距
    CGFloat kern = ctContent.kern;
    if (kern>0) {
        attributes[(id)kCTKernAttributeName] = @(kern);
    }
    
    //段落
    CGFloat spacing = ctContent.lineSpace; //行间距
    if (spacing>=1) {
        CTParagraphStyleSetting lineBreakMode;
        CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping; //换行模式
        lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
        lineBreakMode.value = &lineBreak;
        lineBreakMode.valueSize = sizeof(CTLineBreakMode);
        
        CTParagraphStyleSetting LineSpacing;
        LineSpacing.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
        LineSpacing.value = &spacing;
        LineSpacing.valueSize = sizeof(CGFloat);
        
        CTParagraphStyleSetting settings[] = {lineBreakMode, LineSpacing};
        CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 2);   //第二个参数为settings的长度
        attributes[(id)kCTParagraphStyleAttributeName] = (__bridge id)paragraphStyle;
    }
    
    NSString *content = ctContent.content;
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}

#pragma mark - 添加设置CTRunDelegate信息的方法
+ (NSAttributedString *)parseImageDataFromCTContent:(CTContent *)ctContent config:(CTFrameParserConfig *)config{
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)ctContent);
    
    //使用0xFFFC作为空白占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    
    return space;
}

static CGFloat ascentCallback(void *ref){
    //    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
    return [((__bridge CTContent *)ref).height floatValue];
}

static CGFloat descentCallback(void *ref){
    return 0;
}

static CGFloat widthCallback(void *ref){
    //    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
    return [((__bridge CTContent *)ref).width floatValue];
}

#pragma mark - 配置富文本
//给富文本设置配置信息
+ (CTData *)parseAttributedContent:(NSAttributedString *)content config:(nonnull CTFrameParserConfig *)config {
    //创建CTFrameStterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    //获得要绘制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    CGFloat textWidth = coreTextSize.width;
    
    //生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    //将生成好的CTFrameRef实例和计算好的绘制高度保存到CTData实例中, 最后返回CTData实例
    CTData *data = [[CTData alloc] init];
    data.ctFrame = frame;
    data.ctHeight = textHeight;
    data.ctWidth = textWidth;
    
    //释放内存
    CFRelease(framesetter);
    CFRelease(frame);
    
    return data;
}

//给文本设置配置信息
+ (CTData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config {
    
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *contextString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
    //1. 创建CTFrameStterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)contextString);
    
    //获得要绘制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    CGFloat textWidth = coreTextSize.width;
    
    //2. 生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    //将生成好的CTFrameRef实例和计算好的绘制高度保存到CTData实例中, 最后返回CTData实例
    CTData *data = [[CTData alloc] init];
    data.ctFrame = frame;
    data.ctHeight = textHeight;
    data.ctWidth = textWidth;
    
    //释放内存
    CFRelease(framesetter);
    CFRelease(frame);
    
    return data;
}

//创建CTFrameRef绘制路径实例
+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter config:(CTFrameParserConfig *)config height:(CGFloat)height{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    
    return frame;
}

//配置富文本属性格式化
+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config{
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)config.fontName, config.fontSize, NULL);
    CGFloat lineSpcing = config.lineSpace;
    
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpcing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpcing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpcing},
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(fontRef);
    CFRelease(theParagraphRef);
    
    return dict;
}

@end
