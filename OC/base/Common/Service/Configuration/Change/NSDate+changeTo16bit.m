//
// Created by witness on 2017/6/13.
// Copyright (c) 2017 dayanlive. All rights reserved.
//

#import "NSDate+changeTo16bit.h"


@implementation NSDate (changeTo16bit)

- (NSString *)changeTo16bit {
	NSInteger  value= @(self.timeIntervalSince1970).integerValue;
    NSString *hexString = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1lx",(long)value]];

	return hexString;
}

@end
