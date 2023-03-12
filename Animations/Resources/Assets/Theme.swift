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
        static let cellBg = Color("Cell-BG")
    }
    
    struct Gradients {
        
        // MARK: Metaball Animation
        static let tealToDarkYellowTopToBottom = LinearGradient(colors: [Theme.Colors.teal, Theme.Colors.darkYellow], startPoint: .top, endPoint: .bottom)
    }
    
    struct Assets {
        
        // MARK: Cell Liquid Animation
        static let cellLiquid = Image("cell-liquid")
        static let clubbed = Image("clubbed")
        static let singleMetaball = Image("single-metaball")
        static let tailShape = Image("tail-shape")
        
        static let magnifyingGlass = Image(systemName: "magnifyingglass")
        static let xmark = Image(systemName: "xmark")
    }
}

//141617
