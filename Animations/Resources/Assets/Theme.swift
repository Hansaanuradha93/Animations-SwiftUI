//
//  Theme.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-06.
//

import SwiftUI

struct Theme {
    
    struct Colors {
        
        // MARK: Metaball Animation
        static let teal = Color("Teal")
        static let darkYellow = Color("Dark-Yellow")
        
        // MARK: Cell Liquid Animation
        static let bgGray = Color("Bg-Gray")
        static let green = Color("Green")
    }
    
    struct Gradients {
        
        // MARK: Metaball Animation
        static let tealToDarkYellowTopToBottom = LinearGradient(colors: [Theme.Colors.teal, Theme.Colors.darkYellow], startPoint: .top, endPoint: .bottom)
    }
    
    struct Assets {
        
        // MARK: Cell Liquid Animation
        static let logo1 = Image("Logo-1")
        static let logo2 = Image("Logo-2")
        static let logo3 = Image("Logo-3")
        static let logo4 = Image("Logo-4")
        static let logo5 = Image("Logo-5")
        
        static let magnifyingGlass = Image(systemName: "magnifyingglass")
        
        static let xmark = Image(systemName: "xmark")
    }
    
    struct Shapes {
        
        static let tailShape = Image("tail-shape")
    }
}
