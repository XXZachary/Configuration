//
//  NSDictionary+stringForKey.m
//

#import "NSDictionary+stringForKey.h"

@implementation NSDictionary (stringForKey)

- (NSString *)stringForKey:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value isKindOfClass:[NSString class]]) {
        return value;
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%d",[value intValue]];
    }
    return nil;
}

- (NSString *)stringForKeyNotNull:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value isKindOfClass:[NSString class]]) {
        return value;
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%d",[value intValue]];
    }
    
    return @"";
}

- (int) intForKey:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value respondsToSelector:@selector(intValue)]) {
        return [value intValue];
    }
    
    return 0;
}

- (double) doubleForKey:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    
    return 0.0;
}

- (BOOL) boolForKey:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    
    return NO;
}

- (CGRect) rectForKey:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value isKindOfClass:[NSDictionary class]]) {
        __weak NSDictionary *rectDic = value;
        double x = [rectDic doubleForKey:@"x"];
        double y = [rectDic doubleForKey:@"y"];
        double width = [rectDic doubleForKey:@"width"];
        double height = [rectDic doubleForKey:@"height"];
        return CGRectMake(x, y, width, height);
    }
    return CGRectZero;
}

- (NSArray *)arrayForKey:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

- (NSArray *)arrayForKeyNotNull:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return [NSArray array];
}

- (NSDictionary *)dictionaryForKey:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

- (NSDictionary *)dictionaryForKeyNotNull:(id)aKey {
    __weak NSDictionary *dic = self;
    id value = [dic objectForKey:aKey];
    if([value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return [NSDictionary dictionary];
}

@end
