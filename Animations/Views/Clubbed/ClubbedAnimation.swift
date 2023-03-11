//
//  BlobAnimation.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-06.
//

import SwiftUI

struct ClubbedAnimation: View {
    
    var body: some View {
        
        // MARK: Clubbed Animation
        VStack {
            ClubbedView()
        }
    }
}

struct ClubbedAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ClubbedAnimation()
            .preferredColorScheme(.dark)
    }
}

// MARK: - ClubbedView
struct ClubbedView: View {
    
    @State var startAnimation: Bool = false
    
    var body: some View {
        
        Rectangle()
            .fill(Gradients.tealToDarkYellowTopToBottom)
            .mask {
                // Time determines for how long the animation needs to be changed
                TimelineView(.animation(minimumInterval: 3.6, paused: false)) { _ in
                    
                    Canvas { context, size in

                        /// Add filters
                        /// Change here to add custome color
                        context.addFilter(.alphaThreshold(min: 0.5, color: .red))
                        
                        /// This blur radius determines the amount of elasticity between two elements
                        context.addFilter(.blur(radius: 30))
                        
                        /// Drawing layer
                        context.drawLayer { ctx in
                            
                            /// Placing symbols
                            for index in 1...15 {
                                
                                if let resolvedView = context.resolveSymbol(id: index) {
                                    
                                    ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                                }
                            }
                        }
                    } symbols: {
                        
                       /// Change the number of rectangles
                        ForEach(1...15, id: \.self) { index in
                            
                            /// Generating custom offset for each time
                            /// Thus it will be at random places and clubbed with each other
                            let size = CGSize(width: .random(in: -180...180), height: .random(in: -240...240))
                            let offset = startAnimation ? size : .zero
                        
                            ClubbedRoundedRectangle(offset: offset)
                                .tag(index)
                        }
                    }
                }

            }
            .contentShape(Rectangle())
            .onTapGesture {
                startAnimation.toggle()
            }
    }
}

// MARK: - ClubbedRoundedRectangle
struct ClubbedRoundedRectangle: View {
    
    var offset: CGSize
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .frame(width: 120, height: 120)
            .offset(offset)
            /// Adding animations
            /// Duration should be less than TimeLineView Refresh Rate
            .animation(.easeInOut(duration: 4), value: offset)
    }
}
