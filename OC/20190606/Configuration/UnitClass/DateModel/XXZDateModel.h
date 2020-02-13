//
//  XXZDateModel.h
//  Author From Xavier Zachary
//
//  Created by Zachary on 14/10/29.
//  Copyright © 2015年 com.xxzing.future. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXZDateModel : NSObject

#pragma mark - input date
+ (NSString *)returnWeekdayWithDate:(NSDate *)nowDate; //指定那天周几
+ (NSInteger)returnSecondWithDate:(NSDate *)nowDate; //指定那天 秒
+ (NSInteger)returnMinuteWithDate:(NSDate *)nowDate; //指定那天 分
+ (NSInteger)returnHourWithDate:(NSDate *)nowDate; //指定那天 时
+ (NSInteger)returnDayWithDate:(NSDate *)nowDate; //指定那天 日
+ (NSInteger)returnMonthWithDate:(NSDate *)nowDate; //指定那天 月
+ (NSInteger)returnYearWithDate:(NSDate *)nowDate; //指定那天 年

#pragma mark - current date
+ (NSString *)returnCurrentWeekday; //当前周几
+ (NSInteger)returnCurrentWeekdayDigital; //当前周几数字
+ (NSInteger)returnCurrentSecond; //秒
+ (NSInteger)returnCurrentMinute; //分
+ (NSInteger)returnCurrentHour; //时
+ (NSInteger)returnCurrentDay; //日
+ (NSInteger)returnCurrentMonth; //月
+ (NSInteger)returnCurrentYear; //年

#pragma mark - last | next
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date; //每个月的第一天是周几
+ (NSInteger)totaldaysInMonth:(NSDate *)date; //指定日期月份 有多少天

+ (NSDate *)lastYear:(NSDate *)date; //上个年日期
+ (NSDate *)lastMonth:(NSDate *)date; //上个月日期
+ (NSDate *)lastWeekday:(NSDate *)date; //上个周日期
+ (NSDate *)lastDay:(NSDate *)date; //上个日日期

+ (NSDate*)nextYear:(NSDate *)date; //下个年日期
+ (NSDate*)nextMonth:(NSDate *)date; //下个月日期
+ (NSDate *)nextWeekday:(NSDate *)date; //下个周日期
+ (NSDate*)nextDay:(NSDate *)date; //下个日日期

#pragma mark - specific
//设置指定日期
//type = 0 年月日, 1 年月日时分秒
+ (NSDate *)customDateWithYear:(NSInteger)year m:(NSInteger)month d:(NSInteger)day h:(NSInteger)hour m:(NSInteger)minute s:(NSInteger)second;
//时间转换成时间戳
+ (NSTimeInterval)timeIntervalSince1970WithDate:(NSDate *)date;
//时间戳转换成时间
+ (NSDate *)dateWithTimeIntervalSince1970WithInterval:(NSTimeInterval)timeInterval;
// type = 0 指定日期 周一 的日期, 1 指定日期 周日 的日期
//获取指定日期的周一或周日日期
+ (NSDate *)getWeekTimeWithNowDate:(NSDate *)nowDate type:(NSInteger)type;
// type = 0 获取每月第一天的日期, 1 获取每月最后一天的日期
//获取指定日期的月初或月底日期
+ (NSDate *)getMonthDateWithType:(NSInteger)type date:(NSDate *)newDate;

#pragma mark - other
//12进制 => 24进制
+ (NSString *)twelveToTwentyfourWithValue:(NSInteger)value;

@end
