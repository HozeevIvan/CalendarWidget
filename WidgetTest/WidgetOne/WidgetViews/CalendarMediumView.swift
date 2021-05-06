//
//  CalendarMediumView.swift
//  WidgetOneExtension
//
//  Created by Ivan Hozeev on 29.04.21.
//

import SwiftUI

struct CalendarMediumView: View {
    
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
                    //.padding(.top, 5)
                
                HStack {
                    // calendar itself
                    CalendarView(weekDayFontSize: 7, paddingBottom: 2, paddingBelowTopRow: 0.1, paddingTrailing: 10, fontSize: 7)
                }
                .padding(.leading, 17)
                .padding(.bottom, 25)
            }
            .padding(.top, 20)
            Spacer()
        }
        .background(Image("widgetBackgroundMedium")
                        .resizable()
                        .scaledToFill())
    }
}
