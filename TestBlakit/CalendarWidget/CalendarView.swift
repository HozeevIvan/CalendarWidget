//
//  CalendarView.swift
//  TestBlakit
//
//  Created by  apple on 4/30/21.
//

import SwiftUI


struct CalendarView: View {
    
    var paddingTrailing: CGFloat
    var paddingBottom: CGFloat
    var fontSize: CGFloat = 8
    var weekDayFontSize: CGFloat
    
    var days: [Date] {
        return Date().startOfMonth.startOfWeek!.daysArrayToDate(Date().endOfMonth.endOfWeek!)
    }
    
    var weekdaysStrings: [String] {
        return DateFormatter().veryShortWeekdaySymbols
    }
    
    var numberOfWeeks: Int {
       return Date().numberOfWeeksInMonth
    }
    
    private func getDayIndex(week: Int, day: Int) -> Int {
        return (week * weekdaysStrings.count) + day
    }
    
    var body: some View {
        HStack {
            ForEach(0 ..< weekdaysStrings.count, content: { value in
                
                VStack {
                    Text("\(weekdaysStrings[value])")
                        .font(.dancingScript(size: weekDayFontSize))
                        .foregroundColor(.pink)
                        .padding(.bottom, paddingBottom)
                        .padding(.trailing, paddingTrailing)
                    
                    ForEach(0..<numberOfWeeks, content: { value2 in
                        
                        let day = days[getDayIndex(week: value2, day: value)]
                        
                        if Date().isMonthContainsDay(day) {
                            if day.isDateToday {
                                
                                Text("\(day.dayInt)")
                                    .font(.dancingScript(size: fontSize))
                                    .background(
                                        Circle()
                                            .frame(width: 14, height: 14)
                                            .foregroundColor(Color.pink.opacity(0.3))
                                    )
                                    .padding(.bottom, paddingBottom)
                                    .padding(.trailing, paddingTrailing)
                                
                            } else {
                                Text("\(day.dayInt)")
                                    .font(.dancingScript(size: fontSize))
                                    .padding(.bottom, paddingBottom)
                                    .padding(.trailing, paddingTrailing)
                            }
                        } else {
                            Text("\(value2)")
                                .font(.dancingScript(size: fontSize))
                                .padding(.bottom, paddingBottom)
                                .padding(.trailing, paddingTrailing)
                                .hidden()
                        }
                    })
                }
            })
        }
    }
}



extension Font {
    static func dancingScript(size: CGFloat) -> Font {
        return Font.custom("DancingScript-Regular", size: size)
    }
}
