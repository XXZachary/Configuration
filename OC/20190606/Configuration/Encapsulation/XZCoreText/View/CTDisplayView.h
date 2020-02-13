//
//  CTDisplayView.h
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/13.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTFrameParser.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTDisplayView : UIView

@property(nonatomic, strong) CTData *ctData; //数据源

@property (nonatomic, assign) CGFloat height; //绘制后, 文本占据的高
@property (nonatomic, assign) CGFloat width; //绘制后, 文本占据的宽

/**点击图片 回调*/
@property (nonatomic, copy) void (^clickImageBlock) (CTImageData *imageData);
/**点击链接 回调*/
@property (nonatomic, copy) void (^clickLinkBlock) (CTLinkData *linkData);

@end

NS_ASSUME_NONNULL_END

/* guide code
 
 - (void)loadDisplayView {
 CTDisplayView *display = [[CTDisplayView alloc] initWithFrame:CGRectMake(10, 44, 0, 0)];
 display.backgroundColor = [UIColor cyanColor];
 [self.view addSubview:display];
 
 //配置信息
 CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
 config.width = self.view.frame.size.width-10*2;
 
 //内容
 NSString *content = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿";
 
 #if 0
 CTData *ctData = [CTFrameParser parseContent:content config:config];
 #endif
 
 #if 0
 NSDictionary *dict = [CTFrameParser attributesWithConfig:config];
 NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:content attributes:dict];
 [attri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30.0] range:NSMakeRange(0, 5)]; //字体大小
 [attri addAttribute:(__bridge NSString *)kCTForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(5, 5)]; //字体颜色
 [attri addAttribute:NSBackgroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(10, 5)]; //背景颜色
 
 //没效果
 //    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(15, 5)]; //删除线格式
 //    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(15, 5)]; //删除线颜色
 //    [attri addAttribute:NSObliquenessAttributeName value:@(0.8) range:NSMakeRange(35, 5)]; //字体倾斜
 
 [attri addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:30.0] range:NSMakeRange(20, 5)]; //字体大小
 [attri addAttribute:NSStrokeColorAttributeName value:[UIColor redColor] range:NSMakeRange(20, 5)]; //描绘边颜色
 [attri addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithInt:2] range:NSMakeRange(20, 5)]; //描绘边宽度
 [attri addAttribute:NSKernAttributeName value:[NSNumber numberWithInt:10] range:NSMakeRange(25, 5)]; //字间距
 [attri addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(30, 5)]; //下划线格式
 [attri addAttribute:NSUnderlineColorAttributeName value:[UIColor magentaColor] range:NSMakeRange(30, 5)]; //下划线颜色
 
 [attri addAttribute:(__bridge NSString *)kCTVerticalFormsAttributeName value:@(true) range:NSMakeRange(36, 5)];
 [attri addAttribute:(__bridge NSString *)kCTHorizontalInVerticalFormsAttributeName value:@(4) range:NSMakeRange(45, 5)];
 
 CTData *ctData = [CTFrameParser parseAttributedContent:attri config:config];
 #endif
 
 #if 1
 CTContent *ctContent = [[CTContent alloc] init];
 ctContent.type = CTContentTypeTxt;
 ctContent.content = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈😤😤😤😤😤😤😤";
 ctContent.textColor = [UIColor redColor];
 ctContent.fontSize = @"16.0";
 ctContent.kern = 20.0;
 ctContent.lineSpace = 100;
 
 CTContent *ctImageContent = [[CTContent alloc] init];
 ctImageContent.type = CTContentTypeImage;
 ctImageContent.name = @"2222.png";
 ctImageContent.width = @"251.0";
 ctImageContent.height = @"117.67";
 
 CTContent *ctLinkContent = [[CTContent alloc] init];
 ctLinkContent.type = CTContentTypeLink;
 ctLinkContent.content = @"这😤里😤是😤链😤接";
 ctLinkContent.textColor = [UIColor blueColor];
 ctLinkContent.backColor = [UIColor whiteColor];
 ctLinkContent.fontSize = @"16.0";
 ctLinkContent.linkUrl = @"https://www.baidu.com";
 ctLinkContent.isHaveUnderline = YES;
 
 CTContent *ctContent1 = [[CTContent alloc] init];
 ctContent1.type = CTContentTypeTxt;
 ctContent1.content = @"嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿";
 ctContent1.textColor = [UIColor purpleColor];
 ctContent1.fontSize = @"20.0";
 
 CTContent *ctImageContent1 = [[CTContent alloc] init];
 ctImageContent1.type = CTContentTypeImage;
 ctImageContent1.name = @"1111.png";
 ctImageContent1.width = @"102.4";
 ctImageContent1.height = @"102.4";
 
 NSMutableArray *tmpArr = [NSMutableArray arrayWithObjects:ctContent, ctImageContent, ctLinkContent, ctContent1, ctImageContent1, nil];
 
 CTData *ctData = [CTFrameParser parseContents:tmpArr config:config];
 #endif
 
 display.ctData = ctData;
 display.height = ctData.ctHeight;
 display.width = ctData.ctWidth;
 }
 
 */
