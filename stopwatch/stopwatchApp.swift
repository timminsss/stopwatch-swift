//
//  stopwatchApp.swift
//  stopwatch
//
//  Created by Shelley Timmins on 15/06/2023.
//

import SwiftUI

@main
struct stopwatchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .sheet(isPresented: .constant(false)) {
                    TimerView()
                }
        }
    }
}
