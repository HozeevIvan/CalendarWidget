//
//  CalendarView.swift
//  WidgetTest
//
//  Created by Ivan Hozeev on 29.04.21.
//

import SwiftUI


extension Font {
    static func dancingScript(size: CGFloat) -> Font {
        return Font.custom("DancingScript-Regular", size: size)
    }
}

struct CalendarView: View {
    
    let weekDayFontSize: CGFloat
    let paddingBottom: CGFloat
    let paddingBelowTopRow: CGFloat
    let paddingTrailing: CGFloat
    let date = Date()
    var fontSize: CGFloat
    private var font: Font {
        .dancingScript(size: fontSize)
    }
    
    var days: [Date] {
        let firstDay = date.startOfMonth.startOfWeek
        let lastDay = date.endOfMonth.endOfWeek
        let days = firstDay.daysArrayToDate(lastDay)
        return days
    }
    
    var weekdaysStrings: [String] {
        return DateFormatter().veryShortWeekdaySymbols
    }
    
    var weekDaysCount: Int {
        weekdaysStrings.count
    }
    
    var numberOfWeeks: Int {
        return date.numberOfWeeksInMonth
    }
    
    private func getDayIndex(week: Int, day: Int) -> Int {
        return (week * weekDaysCount) + day
    }
    
    var body: some View {
        buildView()
    }
    
    
    func buildView() -> some View {
        HStack {
            ForEach(0 ..< weekdaysStrings.count, content: { value in
                
                VStack(alignment: .leading) {
                    Text("\(weekdaysStrings[value])")
                        .font(.dancingScript(size: weekDayFontSize))
                        .foregroundColor(.pink)
                        .padding(.bottom, paddingBelowTopRow)
                        .padding(.trailing, paddingTrailing)
                    
                    ForEach(0..<numberOfWeeks, content: { value2 in
                        
                        let day = days[getDayIndex(week: value2, day: value)]
                        
                        if Date().isMonthContainsDay(day) {
                            if day.isDateToday {
                                
                                Text("\(day.dayInt)")
                                    .font(font)
                                    .background(
                                        Circle()
                                            .frame(width: 14, height: 14)
                                            .foregroundColor(Color.pink.opacity(0.3))
                                    )
                                    .padding(.bottom, paddingBottom)
                                    .padding(.trailing, paddingTrailing)
                                
                            } else {
                                Text("\(day.dayInt)")
                                    .font(font)
                                    .padding(.bottom, paddingBottom)
                                    .padding(.trailing, paddingTrailing)
                            }
                        } else {
                            Text("\(value2)")
                                .font(font)
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

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(weekDayFontSize: 8, paddingBottom: 10, paddingBelowTopRow: 10, paddingTrailing: 25, fontSize: 8)
    }
}

