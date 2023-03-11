//
//  Theme.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-06.
//

import SwiftUI

struct Theme {
    
    // MARK: Metaball Animation
    static let teal = Color("Teal")
    static let darkYellow = Color("Dark-Yellow")
}

struct Gradients {
    
    // MARK: Metaball Animation
    static let tealToDarkYellowTopToBottom = LinearGradient(colors: [Theme.teal, Theme.darkYellow], startPoint: .top, endPoint: .bottom)
}
