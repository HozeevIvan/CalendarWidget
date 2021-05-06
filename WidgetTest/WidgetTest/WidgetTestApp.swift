//
//  WidgetTestApp.swift
//  WidgetTest
//
//  Created by Ivan Hozeev on 29.04.21.
//

import SwiftUI
import EventKit

@main
struct WidgetTestApp: App {
    
    init () {
        requestAccessToCalendar()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func requestAccessToCalendar() {
        EKEventStore().requestAccess(to: .event) { (granted, error) in
            if granted {
                print("succsess")
            } else {
                print(error!)
            }
        }
    }
}
