//
//  PPomoTimer1App.swift
//  PPomoTimer1
//
//  Created by Kyungyun Lee on 27/02/2022.
//

import SwiftUI

@main
struct PPomoTimer1App: App {
    
    @StateObject var tm : TimerModel = TimerModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(tm)
        }
    }
}
