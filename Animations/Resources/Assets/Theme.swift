//
//  Theme.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-06.
//

import SwiftUI

struct Theme {
    
    struct MetaballAnimation {
        
        /// Colors
        static let teal = Color("Teal")
        static let darkYellow = Color("Dark-Yellow")
        
        /// Gradients
        static let tealToDarkYellowTopToBottom = LinearGradient(colors: [Theme.MetaballAnimation.teal, Theme.MetaballAnimation.darkYellow], startPoint: .top, endPoint: .bottom)
    }
    
    struct CellLiquidAnimation {
        
        /// Colors
        static let bgGray = Color("Bg-Gray")
        static let green = Color("Green")
        static let cellBg = Color("Cell-BG")
    }
    
    struct Assets {
        
        // MARK: Common
        static let home = Image(systemName: "house")
        static let gear = Image(systemName: "gear")
        
        // MARK: Cell Liquid Animation
        static let cellLiquid = Image("cell-liquid")
        static let clubbed = Image("clubbed")
        static let singleMetaball = Image("single-metaball")
        static let tailShape = Image("tail-shape")
        
        static let magnifyingGlass = Image(systemName: "magnifyingglass")
        static let xmark = Image(systemName: "xmark")
        
        // MARK: Dropdown Pricker
        static let dynamicDropDown = Image("dynamic-drop-down")
        static let chevronUpDown = Image(systemName: "chevron.up.chevron.down")
    }
}
