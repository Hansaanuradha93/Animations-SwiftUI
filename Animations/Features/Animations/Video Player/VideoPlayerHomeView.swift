//
//  VideoPlayerHomeView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-05-21.
//

import SwiftUI

/**
 The VideoPlayerHomeView class is responsible for playing videos in a custom video player.
 
 - Parameters:
 - Youtube Part 1: https://www.youtube.com/watch?v=BEGPObrbkFU
 - Youtube Part 2: https://www.youtube.com/watch?v=N4LISLVTB20
 - Source Code: https://www.patreon.com/posts/swiftui-custom-2-82196310
**/

// Video Play: Part 1 - 6.30

struct VideoPlayerHomeView: View {
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let safeArea = proxy.safeAreaInsets
            
            VideoPlayerView(size: size,
                            safeArea: safeArea)
            .ignoresSafeArea()
        }
    }
}

struct VideoPlayerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerHomeView()
    }
}
