//
//  KService.h
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
//

#import "KBaseService.h"

#import "KBaseModel.h"
#import "KBaseResponse.h"

@interface KService : KBaseService

+ (instancetype)SELF;

/**核心POST处理方法*/
+ (void)coreProcess:(NSString *)responseStr  model:(KBaseModel *)model Completion:(completion)completion;
/**核心GET处理方法*/
+ (void)coreGetProcess:(NSString *)responseStr  model:(KBaseModel *)model Completion:(completion)completion;

@end
