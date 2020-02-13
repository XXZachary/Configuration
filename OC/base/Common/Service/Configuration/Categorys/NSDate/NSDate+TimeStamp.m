

#import "NSDate+TimeStamp.h"

@implementation NSDate (TimeStamp)

//1.0 根据当前时间获取时间戳（10位，精确到秒）
+ (NSString *)currentTimeStamp10 {
    return [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate date] timeIntervalSince1970]];
}

//1.1 根据当前时间获取时间戳（13位，精确到毫秒）
+ (NSString *)currentTimeStamp13 {
    return [NSString stringWithFormat:@"%ld", (NSInteger)([[NSDate date] timeIntervalSince1970] * 1000)];
}

//1.2 根据指定时间获取时间戳（10位，精确到秒）
- (NSString *)timeStamp10 {
    return [NSString stringWithFormat:@"%ld", (NSInteger)[self timeIntervalSince1970]];
}

//1.3 根据指定时间获取时间戳（13位，精确到秒）
- (NSString *)timeStamp13 {
    return [NSString stringWithFormat:@"%ld", (NSInteger)([self timeIntervalSince1970] * 1000)];
}

@end
