//
//  CustomTabView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-29.
//

import SwiftUI

struct CustomTabView: View {
    
    /// Local Storage Properties
    @AppStorage(UserDefaultsKeys.appColorScheme) private var isDarkMode = false
    
    /// Animation Properties
    @State private var expandSheet: Bool = false
    @Namespace private var animation
    
    /// View State Properties
    @State var showAppleMusicBottomSheet: Bool = false
    

    var body: some View {
        
        TabView {
            Tab(title: "Home",
                icon: Theme.Common.home,
                item: AnimationsView(showAppleMusicBottomSheet: $showAppleMusicBottomSheet))
            
            Tab(title: "Settings",
                icon: Theme.Common.gear,
                item: SettingsView())
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .safeAreaInset(edge: .bottom) {
            
            if showAppleMusicBottomSheet {
                CustomBottomSheetView(expandSheet: $expandSheet,
                                      animation: animation)
                /// Transition For More Fluent Animation
                .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
        .overlay {
            if showAppleMusicBottomSheet && expandSheet {
                ExpandedBottomSheet(expandSheet: $expandSheet,
                                    animation: animation)
            }
        }
    }
    
    @ViewBuilder
    func Tab(title: String, icon: Image, item: some View) -> some View {
        item
            .tabItem {
                icon
                Text(title)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            /// Hide The Tab Bar When Sheet Is Expanded
            .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        CustomTabView()
        .preferredColorScheme(.dark)
    }
}
