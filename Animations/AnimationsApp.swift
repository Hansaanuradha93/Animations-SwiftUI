//
//  AnimationsApp.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-05.
//

import SwiftUI

@main
struct AnimationsApp: App {
    
    @AppStorage(UserDefaultsKeys.appColorScheme) private var isDarkMode = false

    var body: some Scene {
        
        WindowGroup {
            
            TabView {
                AnimationsView()
                    .tabItem {
                        Theme.Common.home
                        Text("Home")
                    }

                SettingsView()
                    .tabItem {
                        Theme.Common.gear
                        Text("Settings")
                    }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
