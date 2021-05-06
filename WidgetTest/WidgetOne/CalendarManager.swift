//
//  CalendarManager.swift
//  WidgetOneExtension
//
//  Created by Ivan Hozeev on 1.05.21.
//

import Foundation
import EventKit

class CalendarManager {
    
    static func loadEvents() -> [EKEvent] {
        let dataBase = EKEventStore()
        let calendars: [EKCalendar] = dataBase.calendars(for: .event)
        let cal = Calendar(identifier: .gregorian)
        let date = Date()
        let d1 = cal.date(byAdding: DateComponents(day: -1), to: date)!
        let d2 = cal.date(byAdding: DateComponents(day: 1), to: date)!
        let pred = dataBase.predicateForEvents(withStart: d1, end: d2, calendars: calendars)
        var calevents = dataBase.events(matching: pred)
        calevents.sort {$0.compareStartDate(with: $1) == .orderedAscending}
        return calevents
    }
    
}
