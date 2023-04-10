//
//  AppleMusicHomeView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-04-10.
//

import SwiftUI

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
