//
//  SettingsView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-12.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultsKeys.appColorScheme) private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                darkModeToggle
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

// MARK: - SettingsView
extension SettingsView {
    
    private var darkModeToggle: some View {
        Toggle("Dark Mode", isOn: $isDarkMode)
    }
}
