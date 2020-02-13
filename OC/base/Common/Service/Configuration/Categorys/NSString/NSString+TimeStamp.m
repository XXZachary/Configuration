//
//  NSString+TimeStamp.m
//  ipadTemp
//
//  Created by xiaoming on 16/12/15.
//  Copyright © 2016年 Risenb App Department With iOS. All rights reserved.
//

#import "NSString+TimeStamp.h"

@implementation NSString (TimeStamp)

- (NSString *)timeStamp13ToDateWithFormatter:(NSString *)formmatter {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self integerValue] / 1000];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = formmatter;
    return [f stringFromDate:date];
}

- (NSString *)timeStamp10ToDateWithFormatter:(NSString *)formmatter {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.integerValue];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = formmatter;
    return [f stringFromDate:date];
}

@end
