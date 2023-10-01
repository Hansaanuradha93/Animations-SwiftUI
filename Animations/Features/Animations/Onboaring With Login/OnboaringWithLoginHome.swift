//
//  OnboaringWithLoginHome.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-04-13.
//

import SwiftUI

/**
 The OnboaringWithLoginHome class is responsible for showing onboading screen animation while allowing the user to input login credentials.
 
 - Parameters:
 - Youtube: https://www.youtube.com/watch?v=9Ztm5ePwY4k&list=WL&index=20
 - Source Code: https://www.patreon.com/posts/swiftui-app-page-80777273
**/
// 5:53
struct OnboaringWithLoginHome: View {
    
    /// View Properties
    @State private var activeIntro: PageIntro = pageIntros[0]
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            IntroView(intro: $activeIntro, size: size)
        }
        .padding(15)
    }
}

struct OnboaringWithLoginHome_Previews: PreviewProvider {
    static var previews: some View {
        OnboaringWithLoginHome()
    }
}

/// Intro View
struct IntroView: View {
    
    @Binding var intro: PageIntro
    var size: CGSize
    
    var body: some View {
        VStack {
            /// Image View
            GeometryReader { geometry in
                let size = geometry.size
                
                Image(intro.introAssetImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
            }
            
            /// Tile & Action's
            VStack(alignment: .leading, spacing: 10) {
                Spacer(minLength: 0)
                
                Text(intro.title)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                
                Text(intro.subTitle)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.top, 15)
                
                if !intro.displaysAction {
                    Group {
                        Spacer(minLength: 25)
                        
                        /// Custom Indicator View
                        CustomIndicatorView(totalPages: filteredPages.count, currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        
                        Button(action: {
                            changeIntro()
                        }, label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: size.width * 0.4)
                                .padding(.vertical, 15)
                                .background {
                                    Capsule()
                                        .fill(.black)
                                }
                        })
                        .frame(maxWidth: .infinity)
                    }
                } else {
                    /// Action View
                    
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    /// Updating Page Intros
    func changeIntro() {
        if let index = pageIntros.firstIndex(of: intro),
           index != pageIntros.count - 1 {
            intro = pageIntros[index + 1]
        } else {
            intro = pageIntros[pageIntros.count - 1]
        }
    }
    
    var filteredPages: [PageIntro] {
        return pageIntros.filter { !$0.displaysAction }
    }
}
