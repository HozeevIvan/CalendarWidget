//
//  CalendarManager.swift
//  TestBlakit
//
//  Created by  apple on 4/30/21.
//

import Foundation
import EventKit

class CalendarManager {
    
    static let shared = CalendarManager()
    private init() {}
    private let dataBase = EKEventStore()
    
    private let date = Date()
    
    private var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
    private var endOfDay: Date {
        Calendar.current.date(byAdding: DateComponents(hour: 24), to: startOfDay)!
    }
    
     func loadEvents() -> [EKEvent] {
        let calendars: [EKCalendar] = dataBase.calendars(for: .event)
        let d1 = startOfDay
        let d2 = endOfDay
        print("start of day - \(d1), end of day - \(d2)")
        let pred = dataBase.predicateForEvents(withStart: d1, end: d2, calendars: calendars)
        var calEvents = dataBase.events(matching: pred)
        print(calEvents)
        calEvents.sort {$0.compareStartDate(with: $1) == .orderedAscending}
        return calEvents
    }
    
}
