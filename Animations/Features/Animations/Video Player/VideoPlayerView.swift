//
//  VideoPlayerView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-05-20.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    /// View Properties
    @State private var player: AVPlayer? = {
        if let bundle = Bundle.main.path(forResource: "Sample Video", ofType: "mp4") {
            return .init(url: URL(filePath: bundle))
        }
        
        return nil
    }()
    
    @State private var showPlayerControls: Bool = false
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            let videoPlayerSize = CGSize(width: size.width, height: size.height / 3.5)
            
            /// Custom Video Player
            ZStack {
                if let player {
                    CustomVideoPlayer(player: player)
                        .overlay {
                            Rectangle()
                                .fill(.black.opacity(0.4))
                                .opacity(showPlayerControls ? 1 : 0)
                                .overlay {
                                    PlaybackControls()
                                }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                showPlayerControls.toggle()
                            }
                        }
                }
            }
            .frame(width: videoPlayerSize.width, height: videoPlayerSize.height)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    
                    
                    ForEach(1...3, id: \.self) { index in
                        
                        GeometryReader { proxy in
                            
                            let size = proxy.size
                            
                            Image("Custom Video Player Thumb \(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        }
                        .frame(height: 220)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 30)
                .padding(.bottom, 15 + safeArea.bottom)
            }
        }
        .padding(.top, safeArea.top)
    }
    
    /// Playback Controls View
    @ViewBuilder
    func PlaybackControls() -> some View {
        
        HStack(spacing: 25) {
            
            /// Backward Button
            Button {
                
            } label: {
                Theme.VideoPlayer.backwardEndFill
                    .font(.title2)
                    .fontWeight(.ultraLight)
                    .foregroundColor(.white)
                    .padding(15)
                    .background {
                        Circle()
                            .fill(.black.opacity(0.35))
                    }
            }
            
            
            /// Change Play Icon Based On Video Status
            let playImage = isPlaying ? Theme.VideoPlayer.pauseFill : Theme.VideoPlayer.playFill
            
            /// Play Button
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPlaying.toggle()
                }
                
            } label: {
                playImage
                    .font(.title)
                    .fontWeight(.ultraLight)
                    .foregroundColor(.white)
                    .padding(15)
                    .background {
                        Circle()
                            .fill(.black.opacity(0.35))
                    }
            }
            .scaleEffect(1.1)
            
            /// Forward Button
            Button {
                
            } label: {
                Theme.VideoPlayer.forwardEndFill
                    .font(.title2)
                    .fontWeight(.ultraLight)
                    .foregroundColor(.white)
                    .padding(15)
                    .background {
                        Circle()
                            .fill(.black.opacity(0.35))
                    }
            }

        }
        .opacity(showPlayerControls ? 1 : 0)
        .animation(.easeInOut(duration: 0.2), value: showPlayerControls)
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerHomeView()
    }
}
