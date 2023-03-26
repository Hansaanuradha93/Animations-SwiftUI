//
//  AnimationsApp.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-05.
//

import SwiftUI

@main
struct AnimationsApp: App {

    var body: some Scene {
        
        WindowGroup {
            CustomTabView()
        }
    }
    
    
}

/// Source Code: https://www.patreon.com/kavsoft/posts
/// Youtube: https://www.youtube.com/watch?v=_KohThDWl5Y
struct CustomTabView: View {
    
    /// Local Storage Properties
    @AppStorage(UserDefaultsKeys.appColorScheme) private var isDarkMode = false

    var body: some View {
        
        TabView {
            AnimationsView()
                .tabItem {
                    Theme.Common.home
                    Text("Home")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThinMaterial, for: .tabBar)

            SettingsView()
                .tabItem {
                    Theme.Common.gear
                    Text("Settings")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThinMaterial, for: .tabBar)
        }
//        .preferredColorScheme(isDarkMode ? .dark : .light)
        .safeAreaInset(edge: .bottom) {
            CustomBottomSheetView()
        }
    }
}

struct CustomBottomSheetView: View {
    
    /// Animation Properties
    @State private var expandSheet: Bool = false
    @Namespace private var animation
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay {
                    /// Music Info
                    MusicInfo(expandSheet: $expandSheet,
                              animation: animation)
                }
            
        }
        .frame(height: 70)
        /// Separator Line
        .overlay(alignment: .bottom, content: {
            
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height: 1)
                .offset(y: -5)
        })
        /// 49: Default Tab Bar Height
        .offset(y: -49)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
            .preferredColorScheme(.dark)
        
        ExpandedSheet()
            
    }
}


struct MusicInfo: View {
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            /// Adding Mached Geometry Effect (Hero Animation)
            ZStack {
                
                if !expandSheet {
                    GeometryReader { proxy in
                        
                        let size = proxy.size
                        
                        Theme.AppleMusicBottomSheetAnimation.artwork
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                }
                
            }
            .frame(width: 45, height: 45)
            
            
            
            Text("Look What You Made Me Do")
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, 15)
            
            Spacer(minLength: 0)
            
            /// Pause Button
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
                    .font(.title2)
            }
            
            /// Forward Button
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
                    .font(.title2)
            }
            .padding(.leading, 25)

        }
        .foregroundColor(.primary)
        .padding(.horizontal)
        .padding(.bottom, 5)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            
            /// Expanding Bottom Sheet
            withAnimation(.easeInOut(duration: 0.3)) {
                
                expandSheet = true
            }
        }
    }
}


struct ExpandedSheet: View {
    
    var body: some View {
        
        VStack {
            
            
        }
        
    }
}
