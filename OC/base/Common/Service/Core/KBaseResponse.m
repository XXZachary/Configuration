//
//  KBaseResponse.m
//  KIN
//
//  Created by Zachary on 2018/6/9.
//  Copyright © 2018年 Kinneks. All rights reserved.
//

#import "KBaseResponse.h"

@implementation KBaseResponse

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

//解包原始数据
- (NSDictionary *)decodeData:(NSDictionary *)dic {
    return [dic dictionaryForKeyNotNull:KBaseResponse_Data];
}

//解包原始数据
- (NSArray *)decodeArrayData:(NSDictionary *)dic {
    return [dic arrayForKeyNotNull:KBaseResponse_Data];
}

- (id)initWithResponse:(NSDictionary *)responseDic {
    self = [super init];
    if (self) {
        //TODO:add your code.
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

// 解档
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        unsigned int count = 0;
        
        // 获取类中所有成员变量名
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            // 进行解档取值
            id value = [decoder decodeObjectForKey:strName];
            // 利用KVC对属性赋值
            [self setValue:value forKey:strName];
        }
        
        free(ivar);
    }
    return self;
}
// 归档
- (void)encodeWithCoder:(NSCoder *)encoder {
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        // 利用KVC取值
        id value = [self valueForKey:strName];
        [encoder encodeObject:value forKey:strName];
    }
    
    free(ivar);
}

#pragma mark - setter
- (void)setMessage:(NSString *)message {
    _message = message;
}

- (void)setState:(NSString *)state {
    _state = state;
}

@end
