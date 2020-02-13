//
//  XXZDateModel.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import "XXZDateModel.h"

@implementation XXZDateModel

#pragma mark - input date
+ (NSInteger)returnYearWithDate:(NSDate *)nowDate {
    NSDateComponents *dateComponent = [self returnInputDateComponentsWithDate:nowDate];
    NSInteger year = [dateComponent year];
    
    return year;
}

+ (NSInteger)returnMonthWithDate:(NSDate *)nowDate {
    NSDateComponents *dateComponent = [self returnInputDateComponentsWithDate:nowDate];
    NSInteger month = [dateComponent month];
    
    return month;
}

+ (NSInteger)returnDayWithDate:(NSDate *)nowDate {
    NSDateComponents *dateComponent = [self returnInputDateComponentsWithDate:nowDate];
    NSInteger day = [dateComponent day];
    
    return day;
}

+ (NSInteger)returnHourWithDate:(NSDate *)nowDate {
    NSDateComponents *dateComponent = [self returnInputDateComponentsWithDate:nowDate];
    NSInteger hour = [dateComponent hour];
    
    return hour;
}

+ (NSInteger)returnMinuteWithDate:(NSDate *)nowDate {
    NSDateComponents *dateComponent = [self returnInputDateComponentsWithDate:nowDate];
    NSInteger minute = [dateComponent minute];
    
    return minute;
}

+ (NSInteger)returnSecondWithDate:(NSDate *)nowDate {
    NSDateComponents *dateComponent = [self returnInputDateComponentsWithDate:nowDate];
    NSInteger second = [dateComponent second];
    
    return second;
}

+ (NSString *)returnWeekdayWithDate:(NSDate *)nowDate {
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSDateComponents *dateComponent = [self returnInputDateComponentsWithDate:nowDate];
    NSInteger weekday = [dateComponent weekday];
    // 1 周日, 2 周一, 3 周二, 4 周三, 5 周四, 6 周五, 7 周六
    
    return [arrWeek objectAtIndex:(weekday-1)];
}

#pragma mark - current date
+ (NSString *)returnCurrentWeekday {
//    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDateComponents *dateComponent = [self returnCurrentDateComponents];
    NSInteger weekday = [dateComponent weekday];
    // 1 周日, 2 周一, 3 周二, 4 周三, 5 周四, 6 周五, 7 周六
//    XXZLog(@"weekday = %d", weekday);
    
    return [arrWeek objectAtIndex:(weekday-1)];
}

+ (NSInteger)returnCurrentWeekdayDigital {
    //    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
//    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDateComponents *dateComponent = [self returnCurrentDateComponents];
    NSInteger weekday = [dateComponent weekday];
    // 1 周日, 2 周一, 3 周二, 4 周三, 5 周四, 6 周五, 7 周六
    //    XXZLog(@"weekday = %d", weekday);
    
//    return [arrWeek objectAtIndex:(weekday-1)];
    return weekday-1;
}

//秒
+ (NSInteger)returnCurrentSecond {
    NSDateComponents *dateComponent = [self returnCurrentDateComponents];
    NSInteger second = [dateComponent second];
    
    return second;
}

//分
+ (NSInteger)returnCurrentMinute {
    NSDateComponents *dateComponent = [self returnCurrentDateComponents];
    NSInteger minute = [dateComponent minute];
    
    return minute;
}

//时
+ (NSInteger)returnCurrentHour {
    NSDateComponents *dateComponent = [self returnCurrentDateComponents];
    NSInteger hour = [dateComponent hour];
    
    return hour;
}

//日
+ (NSInteger)returnCurrentDay {
    NSDateComponents *dateComponent = [self returnCurrentDateComponents];
    NSInteger day = [dateComponent day];
    
    return day;
}

//月
+ (NSInteger)returnCurrentMonth {
    NSDateComponents *dateComponent = [self returnCurrentDateComponents];
    NSInteger month = [dateComponent month];
    
    return month;
}

//年
+ (NSInteger)returnCurrentYear {
    NSDateComponents *dateComponent = [self returnCurrentDateComponents];
    NSInteger year = [dateComponent year];
    
    return year;
}

#pragma mark - components
//返回当前时间成分
+ (NSDateComponents *)returnCurrentDateComponents {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSDate *now = [NSDate date];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    return dateComponent;
}

//返回指定时间成分
+ (NSDateComponents *)returnInputDateComponentsWithDate:(NSDate *)inputDate {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:inputDate];
    
    return dateComponent;
}

+ (NSCalendar *)returnCurrentCalendar {
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
//    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]]; //中国时区
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return calendar;
}

#pragma mark - last | next date
//上个年日期
+ (NSDate *)lastYear:(NSDate *)date {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = -1;
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}
//上个月日期
+ (NSDate *)lastMonth:(NSDate *)date {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}

//上个周日期
+ (NSDate *)lastWeekday:(NSDate *)date {
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.weekday = -7;
    
    NSCalendar *calendar = [self returnCurrentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}

//上个日日期
+ (NSDate *)lastDay:(NSDate *)date {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -1;
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}

//下个年日期
+ (NSDate *)nextYear:(NSDate *)date {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = +1;
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}
//下个月日期
+ (NSDate*)nextMonth:(NSDate *)date {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}

//下个周的日期
+ (NSDate *)nextWeekday:(NSDate *)date {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.weekday = +7;
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}

//下个日 日期
+ (NSDate *)nextDay:(NSDate *)date {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = +1;
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    
    return newDate;
}

#pragma mark - specific
//每个月的第一天是周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

//指定日期月份 有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date {
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    NSRange daysInLastMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return daysInLastMonth.length;
}

//指定年月日 => 日期
+ (NSDate *)customDateWithYear:(NSInteger)year m:(NSInteger)month d:(NSInteger)day h:(NSInteger)hour m:(NSInteger)minute s:(NSInteger)second {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    [comps setHour:hour];
    [comps setMinute:minute];
    [comps setSecond:second];
    
    NSCalendar *calendar = [self returnCurrentCalendar];
    NSDate *date = [calendar dateFromComponents:comps];
    
    return date;
}

// type = 0 获取每月第一天的日期, 1 获取每月最后一天的日期
+ (NSDate *)getMonthDateWithType:(NSInteger)type date:(NSDate *)newDate {
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [self returnCurrentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        XXZLog(@"获取每月首末日期出错");
        return nil;
    }
    
    if (type == 0) {
        return beginDate;
    }
    else {
        return endDate;
    }
}

// type = 0 指定日期 周一 的日期, 1 指定日期 周日 的日期
+ (NSDate *)getWeekTimeWithNowDate:(NSDate *)nowDate type:(NSInteger)type {
    NSCalendar *calendar = [self returnCurrentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff, lastDiff;
    if (weekDay == 1) { //当日就是周一
        firstDiff = -6;
        lastDiff = 0;
    }
    else {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    if (type == 0) {
        return firstDayOfWeek;
    }
    else {
        return lastDayOfWeek;
    }
}

//时间转换成时间戳
+ (NSTimeInterval)timeIntervalSince1970WithDate:(NSDate *)date {
    NSTimeInterval interval = [date timeIntervalSince1970];
    return interval;
}

//时间戳转换成时间
+ (NSDate *)dateWithTimeIntervalSince1970WithInterval:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return date;
}

#pragma mark - other
//12 => 24
+ (NSString *)twelveToTwentyfourWithValue:(NSInteger)value {
    if (value < 0) {
        return [NSString stringWithFormat:@"%ld", value];
    }
    
    if (value < 10) {
        return [NSString stringWithFormat:@"%02ld", value];
    }
    
    return [NSString stringWithFormat:@"%ld", value];
}

// 格式化日期字符串
+ (NSString *)dateFormatterWithString:(NSString *)dateStr {
    if (IS_BLANK_STRING(dateStr)) {
        dateStr = @"yyyy-MM-dd HH:mm:ss";
    }
    
    //当前日期
    NSDate *date = [NSDate date];
    //格式化日期字符串
    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    // 设置时间和日期的格式
    selectDateFormatter.dateFormat = dateStr;
    //把date类型转为设置好格式的string类型
    NSString *dateAndTime = [selectDateFormatter stringFromDate:date];
    
    return dateAndTime;
}

/**
 YYYY-mm-dd HH:MM:SS部分解释
 
 d               月中的某一天。一位数的日期没有前导零。
 dd             月中的某一天。一位数的日期有一个前导零。
 ddd           周中某天的缩写名称，在   AbbreviatedDayNames   中定义。
 dddd         周中某天的完整名称，在   DayNames   中定义。
 M               月份数字。一位数的月份没有前导零。
 MM             月份数字。一位数的月份有一个前导零。
 MMM           月份的缩写名称，在   AbbreviatedMonthNames   中定义。
 MMMM         月份的完整名称，在   MonthNames   中定义。
 y               不包含纪元的年份。不具有前导零。
 yy             不包含纪元的年份。具有前导零。
 yyyy         包括纪元的四位数的年份。
 gg             时期或纪元。
 h               12   小时制的小时。一位数的小时数没有前导零。
 hh             12   小时制的小时。一位数的小时数有前导零。
 H               24   小时制的小时。一位数的小时数没有前导零。
 HH             24   小时制的小时。一位数的小时数有前导零。
 m               分钟。一位数的分钟数没有前导零。
 mm             分钟。一位数的分钟数有一个前导零。
 s               秒。一位数的秒数没有前导零。
 ss             秒。一位数的秒数有一个前导零。
 f               秒的小数精度为一位。其余数字被截断。
 
 如果时间为2013-05-20 14:02:30       yyyy-MM-dd HH:mm:ss
 如果格式为yyyy-MM-dd hh:mm:ss       则显示为2013-05-20 02:02:30
 */

@end
