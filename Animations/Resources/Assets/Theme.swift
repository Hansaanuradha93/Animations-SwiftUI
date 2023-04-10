//
//  Theme.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-06.
//

import SwiftUI

struct Theme {
    
    // MARK: MetaballAnimation
    struct MetaballAnimation {
        
        /// Colors
        static let teal = Color("Teal")
        static let darkYellow = Color("Dark-Yellow")
        
        /// Gradients
        static let tealToDarkYellowTopToBottom = LinearGradient(colors: [Theme.MetaballAnimation.teal, Theme.MetaballAnimation.darkYellow], startPoint: .top, endPoint: .bottom)
    }
    
    // MARK: CellLiquidAnimation
    struct CellLiquidAnimation {
        
        /// Colors
        static let bgGray = Color("Bg-Gray")
        static let green = Color("Green")
        static let cellBg = Color("Cell-BG")
        
        /// Assets
        static let cellLiquid = Image("cell-liquid")
        static let clubbed = Image("clubbed")
        static let singleMetaball = Image("single-metaball")
        static let tailShape = Image("tail-shape")
    }
    
    // MARK: DropDownPickerAnimation
    struct DropDownPickerAnimation {
        
        /// Assets
        static let dynamicDropDown = Image("dynamic-drop-down")
        static let chevronUpDown = Image(systemName: "chevron.up.chevron.down")
    }
    
    // MARK: - AppleMusicBottomSheetAnimation
    struct AppleMusicBottomSheetAnimation {
        
        /// Colors
        static let bg = Color("BG")
        
        /// Assets
        static let card1 = Image("Card-1")
        static let card2 = Image("Card-2")
        static let artwork = Image("Artwork")
        static let appleMusic = Image("apple-music")
    }
    
    // MARK: Common
    struct Common {
        
        /// Assets
        static let home = Image(systemName: "house")
        static let gear = Image(systemName: "gear")
        static let magnifyingGlass = Image(systemName: "magnifyingglass")
        static let xmark = Image(systemName: "xmark")
    }
}
