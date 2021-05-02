//
//  CalendarWidget.swift
//  CalendarWidget
//
//  Created by  apple on 4/29/21.
//

import WidgetKit
import SwiftUI
import EventKit

// MARK: -Template WidgetExtension Code

struct CalendarProvider: TimelineProvider {
    typealias Entry = CalendarEntry
    
    func placeholder(in context: Context) -> Entry {
        return Entry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        let entry = Entry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        
        let events = CalendarManager.shared.loadEvents().map({ EventModel(id: $0.calendarItemIdentifier, title: $0.title, timeString: $0.startDate.hourString) })
        print(events)
        let entry = Entry(date: Date(), events: events)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

// MARK: Entry
struct CalendarEntry: TimelineEntry {
    var date: Date
    var events: [EventModel]?
}


@main
struct CalendarWidget: Widget {
    let kind: String = "CalendarWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: CalendarProvider()) { entry in
            CalendarWidgetRootView(entry: entry)
        }
        .configurationDisplayName("Calendar Widget")
        .description("My Calendar widget for test task")
        .supportedFamilies([.systemLarge, .systemMedium])
    }
    
}

struct CalendarWidget_Previews: PreviewProvider {
    static var previews: some View {
            CalendarWidgetRootView(entry: CalendarEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

// MARK: - Different widget-family implementations

typealias SmallView = CalendarWidgetEntryViewSmall
typealias MediumView = CalendarWidgetEntryViewMedium
typealias LargeView = CalendarWidgetEntryViewLarge

struct CalendarWidgetRootView: View {
    
    @Environment(\.widgetFamily) var family
    
    var entry: CalendarProvider.Entry
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall: SmallView(entry: entry)
        case .systemMedium: MediumView(entry: entry)
        case .systemLarge: LargeView(entry: entry)
        default: Text("Other widget size")
        }
    }
}




// MARK: - Widget's Small View
struct CalendarWidgetEntryViewSmall : View {
    var entry: CalendarProvider.Entry
    
    var dayOfWeek: String {
        entry.date.dayOfWeekString
    }
    var day: Int {
        entry.date.dayInt
    }
    var month: String {
        entry.date.monthString
    }

    var body: some View {
        HStack {
            VStack {
                HStack {
                    // week day string
                    Text(dayOfWeek)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                        .font(.dancingScript(size: 25))
                    Spacer()
                }
                Spacer()
                
                HStack {
                    VStack {
                        //week day int
                        Text(String(day))
                            .font(.dancingScript(size: 35))
                        
                        // month string
                        Text(month)
                            .font(.dancingScript(size: 22))
                    }
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                    Spacer()
                }
            }
            Spacer()
        }
        .background(Image("RectangleSmall"))
    }
}




// MARK: - Widget's Medium View

struct CalendarWidgetEntryViewMedium: View {
    var entry: CalendarProvider.Entry
    
    var month: String {
        entry.date.monthString
    }
    
    var body: some View {
        HStack {
            VStack {
                // month string
                Text(month)
                    .font(.dancingScript(size: 17))
                    .padding(.leading, 5)
                    .padding(.bottom, 0.1)
                    .padding(.top, 5)
                
                HStack {
                    // calendar itself
                    CalendarView(paddingTrailing: 5, paddingBottom: 0.1, fontSize: 8, weekDayFontSize: 8)
                }
                .padding(.leading, 17)
                .padding(.bottom, 25)
            }
            .padding(.top, 20)
            Spacer()
        }
        .background(Image("RectangleMed"))
    }
}




// MARK: - Widget's Large View

struct CalendarWidgetEntryViewLarge: View {
    var entry: CalendarProvider.Entry    
    
    // Properties to abstract some hard-to-read code
    var month: String {
        entry.date.monthString
    }
    var straightSlash: String = "|"
    
    // First event related
    var firstEventTime: String {
        guard let events = entry.events else { return " " }
        return events.first!.timeString
    }
    var firstEventTitle: String {
        guard let events = entry.events else { return "no events for today" }
        return events.first!.title
    }
    
    // Second event related
    var secondEventTime: String {
        guard let events = entry.events else { return " " }
        return events.first == events.last ? " " : events[1].timeString
    }
    var secondEventTitle: String {
        guard let events = entry.events else { return " " }
        return events.first == events.last ? "no more events for today" : events[1].title
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                //text with month string
                Text(month)
                    .padding(.bottom, 1)
                    .padding(.leading, 140)
                    .padding(.top, 20)
                    .font(.dancingScript(size: 20))
                //calendar view itself
                CalendarView(paddingTrailing: 25, paddingBottom: 5, fontSize: 10, weekDayFontSize: 9)
                    .padding(.leading, 20)
                
                //MARK: User events are here
                VStack(alignment: .leading) {
                    // First event
                    HStack {
                        Text(straightSlash)
                            .foregroundColor(.pink).opacity(0.5)
                            .padding(.leading, 30)
                            .padding(.trailing, -5)
                        //Text with time
                        Text(firstEventTime)
                            .font(.dancingScript(size: 12))
                        //Text with title
                        Text(firstEventTitle)
                            .font(.dancingScript(size: 15))
                    }
                    .padding(.bottom, 0.1)
                    .padding(.top, 10)
                    .padding(.trailing, 100)
                    
                    // Second event
                    HStack {
                        Text(straightSlash)
                            .foregroundColor(.pink).opacity(0.5)
                            .padding(.leading, 30)
                            .padding(.trailing, -5)
                        //Text with time
                        Text(secondEventTime)
                            .font(.dancingScript(size: 12))
                        //Text with title
                        Text(secondEventTitle)
                            .font(.dancingScript(size: 15))
                    }
                    Spacer(minLength: 60)
                }
                .background(Color.white.opacity(0.2).cornerRadius(16.0))
                .padding(.top, 5)
                .padding(.leading, -15)
                .padding(.bottom, -10)
            }
        }
        .background(Image("RectangleBig"))
    }
}





