//
//  View+Extensions.swift
//  Animations
//
//  Created by Hansa Wickramanayake on 2023-09-28.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func rect(value: @escaping (CGRect) -> ()) -> some View {
        self.overlay {
            GeometryReader { geometry in
                let rect = geometry.frame(in: .global)
                
                Color.clear
                    .preference(key: ReckKey.self, value: rect)
                    .onPreferenceChange(ReckKey.self) { rect in
                        value(rect)
                    }
            }
        }
    }
    
    @MainActor
    @ViewBuilder
    func createImages(
        toggleDarkMode: Bool,
        currentImage: Binding<UIImage?>,
        previousImage: Binding<UIImage?>,
        activateDarkMode: Binding<Bool>
    ) -> some View {
        self.onChange(of: toggleDarkMode) { oldValue, newValue in
            Task {
                if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
                    .windows
                    .first(where: { $0.isKeyWindow }) {
                    let imageView = UIImageView()
                    imageView.frame = window.frame
                    imageView.image = window.rootViewController?.view.image(window.frame.size)
                    imageView.contentMode = .scaleAspectFit
                    window.addSubview(imageView)
                    
                    if let rootView = window.rootViewController?.view {
                        let frameSize = rootView.frame.size
                        /// Create Snapshots
                        /// Old Snapshot
                        activateDarkMode.wrappedValue = !newValue
                        previousImage.wrappedValue = rootView.image(frameSize)
                
                        /// New Snapshot with Updated Trait State
                        activateDarkMode.wrappedValue = newValue
                        /// Give some time to complete the transition
                        try await Task.sleep(for: .seconds(0.01))
                        currentImage.wrappedValue = rootView.image(frameSize)
                        
                        /// Remove once all the snapshots has taken
                        try await Task.sleep(for: .seconds(0.01))
                        imageView.removeFromSuperview()
                    }
                }
            }
        }
    }
}

// MARK: - Converting UIView to UIImage
extension UIView {
    
    func image(_ size: CGSize) -> UIImage {
        let render = UIGraphicsImageRenderer(size: size)
        return render.image { _ in
            drawHierarchy(in: CGRect(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
}
