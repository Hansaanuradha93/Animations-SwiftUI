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
    @State private var emailID: String = ""
    @State private var password: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            IntroView(intro: $activeIntro, size: size) {
                /// User Login / Sign Up View
                VStack(spacing: 10) {
                    /// Custom Text Field
                    CustomTextField(
                        text: $emailID,
                        hint: "Email Address",
                        leadingIcon: Theme.Common.envelope
                    )
                    
                    CustomTextField(
                        text: $password,
                        hint: "Password",
                        leadingIcon: Theme.Common.lock,
                        isPassword: true
                    )
                    
                    Spacer(minLength: 10)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background {
                                Capsule()
                                    .fill(.black)
                            }
                    })
                }
                .padding(.top, 25)
            }
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
struct IntroView<ActionView: View>: View {
    
    @Binding var intro: PageIntro
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<PageIntro>, size: CGSize, actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
    }
    
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
                    actionView
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        /// Back Button
        .overlay(alignment: .topLeading) {
            
            /// Hiding the back button in the first page, since there are not pages before that
            if intro != pageIntros.first {
                Button(action: {
                    changeIntro(toPreviousScreen: true)
                }, label: {
                    Theme.Common.chevronLeft
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                })
                .padding(10)
            }
        }
    }
    
    /// Updating Page Intros
    func changeIntro(toPreviousScreen isPrevious: Bool = false) {
        if let index = pageIntros.firstIndex(of: intro),
           (isPrevious ? index != 0 : index != pageIntros.count - 1) {
            intro = isPrevious ? pageIntros[index - 1] : pageIntros[index + 1]
        } else {
            intro = isPrevious ? pageIntros[0] : pageIntros[pageIntros.count - 1]
        }
    }
    
    var filteredPages: [PageIntro] {
        return pageIntros.filter { !$0.displaysAction }
    }
}
