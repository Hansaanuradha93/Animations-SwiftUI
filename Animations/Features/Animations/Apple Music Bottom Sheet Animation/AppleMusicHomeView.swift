//
//  AppleMusicHomeView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-04-10.
//

import SwiftUI

/**
 The AppleMusicHomeView class is responsible to mimic apple music bottom sheet animation while allowing the user to drag the bottom sheet up and down.
 
 - Parameters:
 - Youtube: https://www.youtube.com/watch?v=_KohThDWl5Y
 - Source Code: https://www.patreon.com/kavsoft/posts

**/

struct AppleMusicHomeView: View {
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 20) {
                    
                    Theme.AppleMusicBottomSheetAnimation.card1
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Theme.AppleMusicBottomSheetAnimation.card2
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Theme.AppleMusicBottomSheetAnimation.card1
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Theme.AppleMusicBottomSheetAnimation.card2
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .padding()
            }
        }
    }
}

struct AppleMusicHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppleMusicHomeView()
    }
}
