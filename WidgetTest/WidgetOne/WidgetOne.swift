//
//  WidgetOne.swift
//  WidgetOne
//
//  Created by Ivan Hozeev on 29.04.21.
//

import WidgetKit
import SwiftUI

struct EventModel: Equatable {
    let id: String
    let title: String
    let timeString: String
}

struct CalendarEntry: TimelineEntry {
    let date: Date
    
    let events: [EventModel]?
}

struct CalendarProvider: TimelineProvider {
    
    func placeholder(in context: Context) -> CalendarEntry {
        CalendarEntry(date: Date(), events: [])
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CalendarEntry) -> Void) {
        let entry = CalendarEntry(date: Date(), events: [])
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CalendarEntry>) -> Void) {
        let events = CalendarManager.loadEvents().map({ EventModel(id: $0.calendarItemIdentifier, title: $0.title, timeString: $0.startDate.hourString) })
        let entry = CalendarEntry(date: Date(), events: events)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

@main
struct CalendarWidget: Widget {
    
    private let kind = "id_widget_one"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: CalendarProvider(),
                            content: { entry in
                                CalendarRootView(entry: entry)
                            })
            .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}





struct CalendarRootView: View {
    
    @Environment(\.widgetFamily) var family
    let entry: CalendarProvider.Entry
    
    var body: some View {
        switch family {
        case .systemSmall:
            CalendarSmallView(entry: entry)
        case .systemMedium:
            CalendarMediumView(entry: entry)
        case .systemLarge:
            CalendarLargeView(entry: entry)
        default:
            Text("Some other WidgetFamily in the future.")
        }
    }

}
