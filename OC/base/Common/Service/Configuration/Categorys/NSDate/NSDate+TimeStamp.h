
/*~!
 | @FUNC  时间戳
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <Foundation/Foundation.h>

@interface NSDate (TimeStamp)

//1.0 根据当前时间获取时间戳（10位，精确到秒）
+ (NSString *)currentTimeStamp10;

//1.1 根据当前时间获取时间戳（13位，精确到毫秒）
+ (NSString *)currentTimeStamp13;

//1.2 根据指定时间获取时间戳（10位，精确到秒）
- (NSString *)timeStamp10;

//1.3 根据指定时间获取时间戳（13位，精确到秒）
- (NSString *)timeStamp13;

@end
