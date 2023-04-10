//
//  ExpandedBottomSheet.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-27.
//

import SwiftUI

struct ExpandedBottomSheet: View {
    
    /// Animation Properties
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    /// View Properties
    @State private var animatedContent: Bool = false
    @State private var offsetY: CGFloat = 0

    var body: some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            let safeAreaInsets = proxy.safeAreaInsets
            
            ZStack {
                /// Making It As Rounded Rectangle With Device Corner Radius
                RoundedRectangle(cornerRadius: (animatedContent ? deviceCornerRadius : 0), style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: (animatedContent ? deviceCornerRadius : 0), style: .continuous)
                            .fill(Theme.AppleMusicBottomSheetAnimation.bg)
                            .opacity(animatedContent ? 1 : 0)
                    })
                    .overlay {
                        MusicInfoView(expandSheet: $expandSheet,
                                  animation: animation)
                        /// Disabling Interaction (Since It's Not Necessary Here)
                        .allowsHitTesting(false)
                        .opacity(animatedContent ? 0 : 1)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
                
                VStack(spacing: 15) {
                    /// Grab Indicator
                    Capsule()
                        .fill(.gray)
                        .frame(width: 40, height: 5)
                        .opacity(animatedContent ? 1 : 0)
                        /// Matching With Slide Animation
                        .offset(y: animatedContent ? 0 : size.height)
                    
                    
                    /// Artwork Hero View
                    GeometryReader { proxy in
                        
                        let size = proxy.size
                        
                        Theme.AppleMusicBottomSheetAnimation.artwork
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.width)
                            .clipShape(RoundedRectangle(cornerRadius: animatedContent ? 15 : 5, style: .continuous))
                        
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                    /// For Square Artwork Image
                    .frame(width: size.width - 50)
                    .padding(.vertical, 10)
                    
                    /// Player View
                    PlayerView(size)
                    /// Moving It From Bottom
                        .offset(y: animatedContent ? 0 : size.height)
                }
                .padding(.top, safeAreaInsets.top + (safeAreaInsets.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeAreaInsets.bottom == 0 ? 10 : safeAreaInsets.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            }
            .contentShape(Rectangle())
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        
                        let transitionY = value.translation.height
                        offsetY = ((transitionY > 0) ? transitionY : 0)
                    }).onEnded({ value in
                        
                        withAnimation(.easeInOut(duration: 0.3)) {
                            
                            if offsetY > size.height * 0.4 {
                                expandSheet = false
                                animatedContent = false
                            } else {
                                offsetY = .zero
                            }
                        }
                    })
            )
            .ignoresSafeArea(.container, edges: .all)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35)) {
                animatedContent = true
            }
        }
    }
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            
            /// Dynamic Heigh Using Available Height
            let spacing = size.height * 0.04
            
            /// Sizing It For More Compact Look
            VStack(spacing: spacing) {
                
                VStack(spacing: spacing) {
                    
                    HStack(alignment: .center, spacing: 15) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text("Look What You Made Me Do")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("Taylor Swift")
                                .foregroundColor(.gray)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .padding(12)
                                .background {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .light)
                                    
                                }
                        }

                    }
                    
                    /// Timing Indicator
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .light)
                        .frame(height: 5)
                        .padding(.top, spacing)
                    
                    /// Timing Label View
                    HStack {
                        Text("0:00")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Text("3:44")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                /// Moving It To Top
                .frame(height: size.height / 2.5, alignment: .top)
                
                /// Playback Controls
                HStack(spacing: size.width * 0.18) {
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "backward.fill")
                        /// Dynamic Sizing For Smaller To Larger Screens
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    
                    /// Making The Play/Pause Button Bigger
                    Button {
                        
                    } label: {
                        Image(systemName: "pause.fill")
                        /// Dynamic Sizing For Smaller To Larger Screens
                            .font(size.height < 300 ? .largeTitle : .system(size: 50))
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.fill")
                        /// Dynamic Sizing For Smaller To Larger Screens
                            .font(size.height < 300 ? .title3 : .title)
                    }

                }
                .foregroundColor(.white)
                .frame(maxHeight: .infinity)
                
                /// Volume & Other Controls
                VStack(spacing: spacing) {
                    
                    HStack(spacing: 15) {
                        
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.gray)
                        
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                            .frame(height: 5)
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(alignment: .top, spacing: size.width * 0.18) {
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "quote.bubble")
                                .font(.title2)
                        }
                        
                        VStack(spacing: 6) {
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "airpods.gen3")
                                    .font(.title2)
                            }
                            
                            Text("Hansa's Airpods")
                                .font(.caption)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "list.bullet")
                                .font(.title2)
                        }

                    }
                    .foregroundColor(.white)
                    .blendMode(.overlay)
                    .padding(.top, spacing)
                    
                }
                /// Moving It To Bottom
                .frame(height: size.height / 2.5, alignment: .bottom)
           }
        }
    }
}

struct ExpandedBottomSheet_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        ExpandedBottomSheet(expandSheet: .constant(true),
                            animation: namespace)
        .preferredColorScheme(.dark)
    }
}

extension View {
    
    var deviceCornerRadius: CGFloat {
        
        let key = "_displayCornerRadius"
        
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
            
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            
            return 0
        }
        
        return 0
    }
}
