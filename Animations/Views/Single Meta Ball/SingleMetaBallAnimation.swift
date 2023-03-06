//
//  Home.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-05.
//

import SwiftUI

struct SingleMetaBallAnimation: View {
    
    var body: some View {
        
        // MARK: Single MetaBall Animation
        VStack {
            SingleMetaBall()
        }
    }
}

struct SingleMetaBallAnimation_Previews: PreviewProvider {
    static var previews: some View {
        SingleMetaBallAnimation()
            .preferredColorScheme(.dark)
    }
}

// MARK: - SingleMetaBall
struct SingleMetaBall: View {
    
    /// Animation Properties
    @State var dragOffset: CGSize = .zero

    var body: some View {
        
        /// If you need gradient color, then use mask
        Rectangle()
            .fill(Gradients.tealToDarkYellowTopToBottom)
            .mask {
                
                Canvas { context, size in

                    /// Add filters
                    /// Change here to add custome color
                    context.addFilter(.alphaThreshold(min: 0.5, color: .red))
                    
                    /// This blur radius determines the amount of elasticity between two elements
                    context.addFilter(.blur(radius: 35))
                    
                    /// Drawing layer
                    context.drawLayer { ctx in
                        
                        /// Placing symbols
                        for index in 1...2 {
                            
                            if let resolvedView = context.resolveSymbol(id: index) {
                                
                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                    
                    Ball(offset: CGSize.zero)
                        .tag(1)
                    
                    Ball(offset: dragOffset)
                        .tag(2)
                }
            }
            .gesture(
                
                DragGesture()
                    .onChanged({ value in
                        
                        dragOffset = value.translation
                    })
                    .onEnded({ _ in
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            
                            dragOffset = .zero
                        }
                    })
            )
    }
}

// MARK: - Ball
struct Ball: View {
    
    var offset: CGSize
    
    var body: some View {
        
        Circle()
            .fill(.white)
            .frame(width: 150, height: 150)
            .offset(offset)
    }
}
