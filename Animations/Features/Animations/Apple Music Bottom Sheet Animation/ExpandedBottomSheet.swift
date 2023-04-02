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

    var body: some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            let safeAreaInsets = proxy.safeAreaInsets
            
            ZStack {
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .overlay(content: {
                        Rectangle()
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
                    
                    /// Artwork Hero View
                    GeometryReader { proxy in
                        
                        let size = proxy.size
                        
                        Theme.AppleMusicBottomSheetAnimation.artwork
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.width)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                    /// For Square Artwork Image
                    .frame(width: size.width - 50)
                    
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
                /// For Testing UI
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        expandSheet = false
                        animatedContent = false
                    }
                }
            }
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
                }
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
