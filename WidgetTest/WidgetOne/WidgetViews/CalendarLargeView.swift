//
//  CalendarLargeView.swift
//  WidgetOneExtension
//
//  Created by Ivan Hozeev on 29.04.21.
//

import SwiftUI

struct CalendarLargeView: View {
    
    var entry: CalendarProvider.Entry
    
    // Properties to abstract some hard-to-read code
    
    var month: String {
        entry.date.monthString
    }
    var straightSlash: String = "|"
    
    // First event related
    var firstEventTime: String {
        guard let events = entry.events else { return " " }
        guard let singleEvent = events.first else { return " " }
        return singleEvent.timeString
    }
    
    var firstEventTitle: String {
        guard let events = entry.events else { return "no events for today" }
        guard let singleEvent = events.first else { return "no events for today" }
        return singleEvent.title
    }
    
    // Second event related
    var secondEventTime: String {
        guard let events = entry.events else { return " " }
        guard let firstEvent = events.first else { return " " }
        return firstEvent == events.last ? " " : events[1].timeString
    }
    
    var secondEventTitle: String {
        guard let events = entry.events else { return " " }
        guard let firstEvent = events.first else { return " " }
        return firstEvent == events.last ? "no more events for today" : events[1].title
    }
    
    var body: some View {
        buildView()
    }
    
    
    private func buildView() -> some View {
        HStack {
            VStack(alignment: .leading) {
                //text with month string
                Text(month)
                    .padding(.bottom, 1)
                    .padding(.leading, 140)
                    .padding(.top, 20)
                    .font(.dancingScript(size: 20))
                //calendar view itself
                
                CalendarView(weekDayFontSize: 8, paddingBottom: 10, paddingBelowTopRow: 10, paddingTrailing: 25, fontSize: 9)
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
        
        .background(Image("widgetBackgroundLarge"))
    }
}

