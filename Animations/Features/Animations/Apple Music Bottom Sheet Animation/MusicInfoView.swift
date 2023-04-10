//
//  MusicInfoView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-29.
//

import SwiftUI

struct MusicInfoView: View {
    
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

struct MusicInfoView_Previews: PreviewProvider {
    
    @Namespace static var namespace

    static var previews: some View {
        MusicInfoView(expandSheet: .constant(false),
                      animation: namespace)
        .preferredColorScheme(.dark)
    }
}
