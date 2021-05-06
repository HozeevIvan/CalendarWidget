//
//  CalendarSmallView.swift
//  WidgetOneExtension
//
//  Created by Ivan Hozeev on 29.04.21.
//

import SwiftUI

struct CalendarSmallView: View {
    
    let entry: CalendarProvider.Entry
    
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
        .background(Image("widgetBackgroundSmall"))
    }
}
