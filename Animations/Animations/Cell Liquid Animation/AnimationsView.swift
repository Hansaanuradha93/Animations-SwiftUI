//
//  PromotionsView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-11.
//

import SwiftUI

struct AnimationsView: View {

    @State var animations = Animation.animations
    
    var body: some View {
       
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 12) {
                    
                    HeaderView()
                        .padding(15)
                    
                    ForEach(animations) { animation in
                        NavigationLink {
                            
                            DestinationView(from: animation)
                            
                        } label: {
                            GooeyCell(animation: animation) {

                                let _ = withAnimation(.easeIn(duration: 0.3)) {
                                
                                    animations.remove(at: indexOf(animation: animation))
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 15)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Theme.Colors.bgGray
                    .ignoresSafeArea()
            )
        }
    }
    
    func indexOf(animation: Animation) -> Int {
        
        if let index = animations.firstIndex(where: { anims in
            animation.id == anims.id
        }) {
            return index
        }
            
        return 0
    }
    
    @ViewBuilder
    func DestinationView(from animation: Animation) -> some View {
        
        switch animation.type {
        case .clubbed:
            ClubbedAnimation()
        case .singleMetaball:
            SingleMetaBallAnimation()
        }
    }
    
    
    @ViewBuilder
    func HeaderView() -> some View {
        
        HStack {
            
            Text("Animations")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Theme.Colors.green)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
            } label: {
                
                Theme.Assets.magnifyingGlass
                    .font(.title2)
                    .foregroundColor(Theme.Colors.green)
                
            }
        }
    }
}

struct AnimationsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsView()
    }
}

// MARK: - Promotion Card View With Gooey Cell Animation
struct GooeyCell: View {
    
    var animation: Animation
    var onDelete: () -> ()
    
    // MARK: Animation Properties
    @State var offsetX: CGFloat = 0
    @State var cardOffset: CGFloat = 0
    @State var finishAnimation: Bool = false
    
    var body: some View {
        let cardWidth = screenSize().width - 35
        let progress = -offsetX * 0.8 / screenSize().width

        ZStack(alignment: .trailing) {
            
            CanvasView()
            
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        
                        Image(animation.logo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                        
                        Text(animation.name)
                            .font(.callout)
                            .fontWeight(.semibold)
                        
                    }
                    
                    Text(animation.title)
                        .foregroundColor(.black.opacity(0.8))
                    
                    Text(animation.subTitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .lineLimit(1)
                
                Text("29 OCT")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Theme.Colors.green.opacity(0.7))
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.white.opacity(0.7))
            }
            .opacity(1.0 - progress)
            .blur(radius: progress * 5.0)
            .padding(.horizontal, 15)
            .contentShape(Rectangle())
            .offset(x: cardOffset)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        print("🟢 Translation: \(value.translation.width)")
                                                
                        /// Only Left Swipe
                        var translation = value.translation.width
                        /// When Left Swift Translation Would Be A NegativeValue
                        translation = (translation > 0 ? 0 : translation)
                        
                        /// Stopping The Card End
                        let absoluteTranslationValue = -translation
                        translation = (absoluteTranslationValue < cardWidth) ? translation : -cardWidth
                        
                        offsetX = translation
                        cardOffset = offsetX
                        
                    }).onEnded({ value in
                        
                        /// Release Animation
                        if -value.translation.width > screenSize().width * 0.6 {
                            
                            /// Haptic Feedback
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            
                            finishAnimation = true
                            
                            /// Moving Card Outside Of The Screen
                            withAnimation(.easeOut(duration: 0.3)) {
                                cardOffset = -screenSize().width
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                
                                onDelete()
                            }
                            
                        } else {
                            
                            withAnimation(.easeInOut(duration: 0.3)) {
                                offsetX = .zero
                                cardOffset = .zero
                            }
                        }
                        
                        
                        
                    })
            )
        }
    }
    
    // MARK: Implementing Gooey Cell Animation
    @ViewBuilder
    func CanvasView() -> some View {
        
        let width = screenSize().width * 0.8
        let circleOffset = offsetX / width
        
        Canvas { ctx, size in
            
            ctx.addFilter(.alphaThreshold(min: 0.5, color: Theme.Colors.green))
            ctx.addFilter(.blur(radius: 5))
            
            ctx.drawLayer { layer in
                
                if let resolvedView = ctx.resolveSymbol(id: 1) {
                    layer.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                }
            }
        } symbols: {
            
            GooeyView()
                .tag(1)
        }
        /// Icon View
        .overlay(alignment: .trailing) {
            
            Theme.Assets.xmark
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 42, height: 42)
                .offset(x: 42)
                .offset(x: (-circleOffset < 1.0 ? circleOffset : -1.0) * 42)
                .offset(x: offsetX * 0.2)
                .offset(x: 8)
                .offset(x: finishAnimation ? -200 : 0)
                .opacity(finishAnimation ? 0 : 1)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 1), value: finishAnimation)
        }
    }
    
    @ViewBuilder
    func GooeyView() -> some View {
        
        let width = screenSize().width * 0.8
        let scale = finishAnimation ? -0.0001 : offsetX / width
        let circleOffset = offsetX / width
        
        Theme.Assets.tailShape
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100)
            .scaleEffect(x: -scale, anchor: .trailing)
            /// Adding Y Scaling
            .scaleEffect(y: 1 + (-scale / 5), anchor: .center)
            /// Adding Icon View
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: finishAnimation)
            .overlay(alignment: .trailing, content: {
                
                Circle()
                    .frame(width: 42, height: 42)
                    /// Moving View Inside
                    .offset(x: 42)
                    .scaleEffect(finishAnimation ? 0.001 : 1, anchor: .leading)
                    .offset(x: (-circleOffset < 1.0 ? circleOffset : -1.0) * 42)
                    .offset(x: offsetX * 0.2)
                    .offset(x: finishAnimation ? -200 : 0)
                    .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 1), value: finishAnimation)
                    
            })
            .frame(maxWidth: .infinity, alignment: .trailing)
            .offset(x: 8)
    }
}

extension View {
    
    func screenSize() -> CGSize {
        
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        return window.screen.bounds.size
    }
}
