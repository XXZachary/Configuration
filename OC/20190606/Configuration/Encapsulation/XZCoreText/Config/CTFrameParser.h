//
//  CTFrameParser.h
//  CoreTextDemo
//
//  Created by Zachary on 2019/2/13.
//  Copyright © 2019 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParserConfig.h"
#import "CTData.h"


NS_ASSUME_NONNULL_BEGIN

@interface CTFrameParser : NSObject

/**图, 文及图文*/
+ (CTData *)parseContents:(NSMutableArray <CTContent *> *)contents config:(CTFrameParserConfig *)config;

/**给富文本设置配置信息*/
+ (CTData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config;
/**配置富文本属性格式化*/
+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;

/**给文本设置配置信息*/
+(CTData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;

@end

NS_ASSUME_NONNULL_END
