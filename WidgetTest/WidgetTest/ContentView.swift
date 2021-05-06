//
//  ContentView.swift
//  WidgetTest
//
//  Created by Ivan Hozeev on 29.04.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CalendarView(weekDayFontSize: 8, paddingBottom: 10, paddingBelowTopRow: 8, paddingTrailing: 10, fontSize: 8)
                .padding(.top, 20)
                .frame(height: 300)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
