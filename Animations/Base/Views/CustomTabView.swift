//
//  CustomTabView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-29.
//

import SwiftUI

struct CustomTabView: View {
    
    /// Animation Properties
    @State private var expandSheet: Bool = false
    @Namespace private var animation
    
    /// View State Properties
    @State var showAppleMusicBottomSheet: Bool = false
    
    /// Helpers
    private var shouldShowExpandedSheet: Bool {
        return showAppleMusicBottomSheet && expandSheet
    }

    var body: some View {
        
        TabView {
            Tab(title: "Home",
                icon: Theme.Common.home,
                item: AnimationsView(showAppleMusicBottomSheet: $showAppleMusicBottomSheet))
            
            Tab(title: "Settings",
                icon: Theme.Common.gear,
                item: SettingsView())
        }
        .safeAreaInset(edge: .bottom) {
            
            if showAppleMusicBottomSheet {
                CustomBottomSheetView(expandSheet: $expandSheet,
                                      animation: animation)
                /// Transition For More Fluent Animation
                .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
        .overlay {
            if shouldShowExpandedSheet {
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
