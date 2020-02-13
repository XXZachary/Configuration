//
//  XXZDate.swift
//  Author From Xavier Zachary
//
//  Created by Zachary on 2017/7/31.
//  Copyright © 2017年 Zachary. All rights reserved.
//

import UIKit

class XXZDate: NSObject {

//    private override init() {}
    
    //MARK: ------ Zachary - specific ------
    static func dateWithFirstDayOfWeek(_ isFirst:Bool = true, _ date:Date = Date.init()) -> Date {
        //获取指定日期所在周的 周一和周日 的日期
        var calendar = self.returnCurrentCalendar()
        
        let components = self.returnDateComponents(date)
        let weekDay = components.weekday //指定日期是周几
        let day = components.day //指定日期是几日
        
        var first = 0, last = 0
        if weekDay == 1 { //当日就是周日
            first = -6
            last = 0
        }
        else {
            first = calendar.firstWeekday-weekDay!+1
            last = 8-weekDay!
        }
        
        var firstComp = self.returnDateComponents(date)
        firstComp.day = day!+first
        let firstDay = calendar.date(from: firstComp)
        
        var lastComp = self.returnDateComponents(date)
        lastComp.day = day!+last
        let lastDay = calendar.date(from: lastComp)
        
        if isFirst {
            return firstDay!
        }
        else {
            return lastDay!
        }
    }
    
    static func dateWithFirstDayOfMonth(_ isFirst:Bool = true, _ date:Date = Date.init()) -> Date? {
        var interval:TimeInterval = 0 //获取指定日期所在月份的 第一天和最后一天 的日期
        var beginDate = Date.init()
        var endDate = Date.init()
        
        let calendar = self.returnCurrentCalendar()
        let flag = calendar.dateInterval(of: .month, start: &beginDate, interval: &interval, for: date)
        if flag {
            endDate = beginDate.addingTimeInterval(interval-1)
        }
        else {
            XXZLog("获取每月首末日期出错")
            return nil
        }
        
        if isFirst {
            return beginDate
        }
        else {
            return endDate
        }
    }
    
    static func weekWithLastDayOfMonth(_ date:Date = Date.init()) -> String { //指定日期所在的月份的最后一天是周几
        let calendar = self.returnCurrentCalendar()
        
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.day = self.totalDaysOfMonth(date)
        
        let nowDate = calendar.date(from: components)
        let weekdayName = self.weekday(nowDate!)
        
        return weekdayName
    }
    
    static func totalDaysOfMonth(_ date:Date = Date.init()) -> Int { //指定日期所在的月份 共有多少天
        let calendar = self.returnCurrentCalendar()
        let days = calendar.range(of: .day, in: .month, for: date)
        
        return (days?.count)!
    }
    
    static func weekWithFirstDayOfMonth(_ date:Date = Date.init()) -> String { //指定日期所在的月份的第一天是周几
        let calendar = self.returnCurrentCalendar()
        
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.day = 1
        
        let nowDate = calendar.date(from: components)
        let weekdayName = self.weekday(nowDate!)
        
        return weekdayName
    }
    
    static func dateWithComponents(_ year:Int, _ month:Int, _ day:Int, _ hour:Int = 0, _ minute:Int = 0, _ second:Int = 0) -> Date {
        var components = DateComponents.init() //根据指定日期成分, 获取具体日期
        
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        
        var calendar = self.returnCurrentCalendar()
        calendar.timeZone = TimeZone.init(secondsFromGMT: 8)!
        
        let nowDate = calendar.date(from: components)
        
        return nowDate!
    }
    
    //MARK: ------ Zachary - next | last date ------
    static func nextWeekday(_ date: Date = Date.init()) -> Date{ //date 日期的 下周
        let calendar = self.returnCurrentCalendar()
        
        var components = DateComponents.init()
        components.weekday = 7
        let nowDate = calendar.date(byAdding: components, to: date, wrappingComponents: false)
        
        return nowDate!
    }
    
    static func nextDay(_ date: Date = Date.init()) -> Date{ //date 日期的 明天
        let calendar = self.returnCurrentCalendar()
        
        var components = DateComponents.init()
        components.day = 1
        let nowDate = calendar.date(byAdding: components, to: date, wrappingComponents: false)
        
        return nowDate!
    }
    
    static func nextMonth(_ date: Date = Date.init()) -> Date{ //date 日期的 下月
        let calendar = self.returnCurrentCalendar()
        
        var components = DateComponents.init()
        components.month = 1
        let nowDate = calendar.date(byAdding: components, to: date, wrappingComponents: false)
        
        return nowDate!
    }
    
    static func nextYear(_ date: Date = Date.init()) -> Date{ //date 日期的 明年
        let calendar = self.returnCurrentCalendar()
        
        var components = DateComponents.init()
        components.year = 1
        let nowDate = calendar.date(byAdding: components, to: date, wrappingComponents: false)
        
        return nowDate!
    }
    
    static func lastWeekday(_ date: Date = Date.init()) -> Date{ //date 日期的 上周
        let calendar = self.returnCurrentCalendar()
        
        var components = DateComponents.init()
        components.weekday = -7
        let nowDate = calendar.date(byAdding: components, to: date, wrappingComponents: false)
        
        return nowDate!
    }
    
    static func lastDay(_ date: Date = Date.init()) -> Date{ //date 日期的 昨天
        let calendar = self.returnCurrentCalendar()
        
        var components = DateComponents.init()
        components.day = -1
        let nowDate = calendar.date(byAdding: components, to: date, wrappingComponents: false)
        
        return nowDate!
    }
    
    static func lastMonth(_ date: Date = Date.init()) -> Date{ //date 日期的 上月
        let calendar = self.returnCurrentCalendar()
        
        var components = DateComponents.init()
        components.month = -1
        let nowDate = calendar.date(byAdding: components, to: date, wrappingComponents: false)
        
        return nowDate!
    }
    
    static func lastYear(_ date: Date = Date.init()) -> Date{ //date 日期的 去年
        let calendar = self.returnCurrentCalendar()
        
        var components = DateComponents.init()
        components.year = -1
        let nowDate = calendar.date(byAdding: components, to: date, wrappingComponents: false)
        
        return nowDate!
    }
    
    //MARK: ------ Zachary - date components ------
    static func weekday(_ date:Date = Date.init()) -> String { //date 日期的 周
        let components = self.returnDateComponents(date)
        let weekday = components.weekday!
        
        var weekdayName = ""
        switch weekday {
        case 1:
            weekdayName = "星期日"
        case 2:
            weekdayName = "星期一"
        case 3:
            weekdayName = "星期二"
        case 4:
            weekdayName = "星期三"
        case 5:
            weekdayName = "星期四"
        case 6:
            weekdayName = "星期五"
        case 7:
            weekdayName = "星期六"
        default:
            weekdayName = "默认"
        }
        
        return weekdayName
    }
    
    static func second(_ date:Date = Date.init()) -> Int { //date 日期的 秒
        let components = self.returnDateComponents(date)
        let second = components.second!
        
        return second
    }
    
    static func minute(_ date:Date = Date.init()) -> Int { //date 日期的 分
        let components = self.returnDateComponents(date)
        let minute = components.minute!
        
        return minute
    }
    
    static func hour(_ date:Date = Date.init()) -> Int { //date 日期的 时
        let components = self.returnDateComponents(date)
        let hour = components.hour!
        
        return hour
    }
    
    static func day(_ date:Date = Date.init()) -> Int { //date 日期的 天
        let components = self.returnDateComponents(date)
        let day = components.day!
        
        return day
    }
    
    static func month(_ date:Date = Date.init()) -> Int { //date 日期的 月
        let components = self.returnDateComponents(date)
        let month = components.month!
        
        return month
    }
    
    static func year(_ date:Date = Date.init()) -> Int { //date 日期的 年
        let components = self.returnDateComponents(date)
        let year = components.year!
        
        return year
    }
    
    //MARK: ------ Zachary - components ------
    static private func returnDateComponents(_ date:Date = Date.init()) -> DateComponents {
        let calendar = self.returnCurrentCalendar()
        
        let unit:Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second, .weekday]
        let components = calendar.dateComponents(unit, from: date)
        
        return components
    }
    
    static private func returnCurrentCalendar() -> Calendar { //获取当前日历
        let calendar = Calendar.current
        
//        var calendar = Calendar.init(identifier: .chinese)
//        calendar.timeZone = TimeZone.init(secondsFromGMT: 8)! //中国时区: GMT 8
        
        return calendar
    }
    
    //MARK: ------ Zachary - 时间戳转换 ------
    static func dateWithTimeintervalSince1970(_ interval:TimeInterval) -> Date { //时间戳转换成时间
        let nowDate = Date.init(timeIntervalSince1970: interval)
        return nowDate
    }
    
    static func timeintervalSince1970WithDate(_ date:Date = Date.init()) -> TimeInterval { //时间转换成时间戳
        let interval:TimeInterval = date.timeIntervalSince1970
        return interval
    }
    
    //MARK: ------ Zachary - other ------
    static func dateWithFormat(_ date:Date, _ format: String = "yyyy-MM-dd HH:mm:ss") -> String { //格式化日期字符串
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date);
    }
}
