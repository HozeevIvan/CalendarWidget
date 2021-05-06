//
//  Date+Extension.swift
//  WidgetTest
//
//  Created by  apple on 5/7/21.
//

import Foundation

extension Date {
    
    var isDateToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var yearString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var monthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
    
    var dayInt: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day!
    }
    
    var numberOfWeeksInMonth: Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 1
        let weekRange = calendar.range(of: .weekOfMonth, in: .month, for: self)
        return weekRange!.count
    }
    
    var dayOfWeekString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    var startOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    var endOfMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
    }
    
    var startOfWeek: Date {
        let calendar = Calendar.current
        let components: DateComponents? = calendar.dateComponents([.weekday, .year, .month, .day], from: self)
        var modifiedComponent = components
        modifiedComponent?.day = (components?.day ?? 0) - ((components?.weekday ?? 0) - 1)
        return calendar.date(from: modifiedComponent!)!
    }
    
    var endOfWeek: Date {
        let calendar = Calendar.current
        let components: DateComponents? = calendar.dateComponents([.weekday, .year, .month, .day], from: self)
        var modifiedComponent = components
        modifiedComponent?.day = (components?.day ?? 0) + (7 - (components?.weekday ?? 0))
        modifiedComponent?.hour = 23
        modifiedComponent?.minute = 59
        modifiedComponent?.second = 59
        return calendar.date(from: modifiedComponent!)!
    }
    
    func daysArrayToDate(_ date: Date) -> [Date] {
        if self > date { return [Date]() }
        var tempDate = self
        var array = [tempDate]
        while tempDate < date {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    
    func monthArrayToDate(_ date: Date) -> [Date] {
        if self > date { return [Date]() }
        var tempDate = self
        var array = [tempDate]
        while tempDate < date {
            tempDate = Calendar.current.date(byAdding: .month, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    
    func isMonthContainsDay(_ day: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let month = startOfMonth
        return calendar.isDate(day, equalTo: month, toGranularity: .month)
    }
    
    var startOfYear: Date {
        let components = Calendar.current.dateComponents([.year], from: Date())
        return Calendar.current.date(from: components)!
    }

    var endOfYear: Date {
        var components = Calendar.current.dateComponents([.year], from: Date())
        components.year = 1
        components.day = -1
        return Calendar.current.date(byAdding: components, to: startOfYear)!
    }
    
    var hourString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: self)
    }
    
}
