//
//  Date+Extension.swift
//  TestBlakit
//
//  Created by  apple on 5/2/21.
//

import Foundation

extension Date {
    
    // MARK: - Hour related
    var hourString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: self)
    }
    
    // MARK: - Day related
    var dayOfWeekString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self).capitalized
    }
    
    var dayInt: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        return components.day!
    }
    
    var isDateToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    // how much days remains to specified date
    func daysArrayToDate(_ date: Date) -> [Date] {
        if self > date { return [Date]() }
        var tmpDate = self
        var arrayOfDays = [tmpDate]
        while tmpDate < date {
            tmpDate = Calendar.current.date(byAdding: .day, value: 1, to: tmpDate)!
            arrayOfDays.append(tmpDate)
        }
        return arrayOfDays
    }
    
    
    // MARK: - Week related
    var startOfWeek: Date? {
        let calendar = Calendar.current
        let components: DateComponents? = calendar.dateComponents([.weekday, .day], from: self)
        var modifiedComponent = components
        modifiedComponent?.day = (components?.day ?? 0) - ((components?.weekday ?? 0) - 1)
        
        return calendar.date(from: modifiedComponent!)
    }
    
    var endOfWeek: Date? {
        let calendar = Calendar.current
        let components: DateComponents? = calendar.dateComponents([.weekday, .year, .month, .day], from: self)
        var modifiedComponent = components
        modifiedComponent?.day = (components?.day ?? 0) + (7 - (components?.weekday ?? 0))
        modifiedComponent?.hour = 23
        modifiedComponent?.minute = 59
        modifiedComponent?.second = 59
        return calendar.date(from: modifiedComponent!)
    }
    
    // MARK: - Month related
    
    var monthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
    
    func isMonthContainsDay(_ day: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let month = startOfMonth
        return calendar.isDate(day, equalTo: month, toGranularity: .month)
    }
    
    var numberOfWeeksInMonth: Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 1
        let weekRange = calendar.range(of: .weekOfMonth, in: .month, for: self)
        return weekRange!.count
    }
    
    var startOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    var endOfMonth: Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
    }
    
    // MARK: - Year related
    
    var yearInt: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self)
        return components.year!
    }
    
}
