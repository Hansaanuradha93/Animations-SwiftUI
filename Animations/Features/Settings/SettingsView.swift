//
//  SettingsView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-12.
//

import SwiftUI

/**
 The SettingsView class is responsible for allowing the user to change app settings with a specific dark mode switch which shows an animation while app is switching from different modes.
 
 - Parameters:
 - Youtube: https://www.youtube.com/watch?v=4dbnfyXILc4
 - Source Code: https://www.patreon.com/posts/swiftui-telegram-89940643

**/

struct SettingsView: View {
    
    /// Sample Toggle States
    @State private var toggles: [Bool] = Array(repeating: false, count: 10)
    
    /// Dark Mode Properties
    @AppStorage(UserDefaultsKeys.toggleDarkMode) private var toggleDarkMode: Bool = false
    @AppStorage(UserDefaultsKeys.activateDarkMode) private var activateDarkMode: Bool = false
    @State private var darkModeButtonRect: CGRect = .zero
    
    /// Current and Previous State Images
    @State private var currentImage: UIImage?
    @State private var previousImage: UIImage?
    @State private var maskAnimation: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Text Section") {
                    Toggle("Large Display", isOn: $toggles[0])
                    Toggle("Bold Text", isOn: $toggles[1])
                }
                
                Section {
                    Toggle("Night Light", isOn: $toggles[2])
                    Toggle("True Tone", isOn: $toggles[3])
                } header: {
                    Text("Display Section")
                } footer: {
                    Text("This is a Sample Footer.")
                }
            }
            .navigationTitle("Settings")
        }
        .createImages(
            toggleDarkMode: toggleDarkMode,
            currentImage: $currentImage,
            previousImage: $previousImage, 
            activateDarkMode: $activateDarkMode
        )
        .overlay {
            GeometryReader(content: { geometry in
                let size = geometry.size
                
                if let previousImage,
                   let currentImage {
                    ZStack {
                        Image(uiImage: previousImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                        
                        Image(uiImage: currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                            .mask(alignment: .topLeading) {
                                Circle()
                                    .frame(
                                        width: darkModeButtonRect.width * (maskAnimation ? 80 : 1),
                                        height: darkModeButtonRect.height * (maskAnimation ? 80 : 1),
                                        alignment: .bottomLeading
                                    )
                                    .frame(width: darkModeButtonRect.width, height: darkModeButtonRect.height)
                                    .offset(x: darkModeButtonRect.minX, y: darkModeButtonRect.minY)
                                    .ignoresSafeArea()
                            }
                    }
                    .task {
                        guard !maskAnimation else { return }
                        
                        withAnimation(.easeInOut(duration: 0.9), completionCriteria: .logicallyComplete) {
                            maskAnimation = true
                        } completion: {
                            /// Remove all snapshots
                            self.previousImage = nil
                            self.currentImage = nil
                            maskAnimation = false
                        }
                    }
                }
            })
            /// Reverse Masking
            .mask({
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        Circle()
                            .frame(width: darkModeButtonRect.width, height: darkModeButtonRect.height)
                            .offset(x: darkModeButtonRect.minX, y: darkModeButtonRect.minY)
                            .blendMode(.destinationOut)
                    }
            })
            .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing) {
            darkModeImage
        }
        .preferredColorScheme(activateDarkMode ? .dark : .light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

// MARK: - SettingsView
extension SettingsView {
    
    private var darkModeImage: some View {
        let image = toggleDarkMode ? Theme.Common.sunMaxFill : Theme.Common.moonFill
        return Button(action: {
            toggleDarkMode.toggle()
        }) {
            image
                .font(.title2)
                .foregroundStyle(.primary)
                .symbolEffect(.bounce, value: toggleDarkMode)
                .frame(width: 40, height: 40)
        }
        .rect { rect in
            darkModeButtonRect = rect
        }
        .padding(10)
        .disabled(currentImage != nil || previousImage != nil || maskAnimation )
    }
}
