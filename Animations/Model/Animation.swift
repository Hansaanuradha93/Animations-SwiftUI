//
//  Animation.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-12.
//

import SwiftUI

// MARK: Promotion Model
struct Animation: Identifiable {
    
    enum AnimationType {
        case dynamicDropDown
        case clubbed
        case singleMetaball
    }
    
    var id: String = UUID().uuidString
    var name: String
    var title: String
    var subTitle: String
    var logo: Image
    var type: AnimationType
}

// MARK: - Data
extension Animation {
    
    static let animations: [Animation] = [
        Animation(name: "Dynamic Drop Down", title: "Drop down picker with dynamic selection", subTitle: "We have got multiple items drop down picker with dynamic selection", logo: Theme.Assets.dynamicDropDown, type: .dynamicDropDown),
        
        Animation(name: "Clubbed", title: "Several rectangular shapes animation", subTitle: "We have got several rectangular shapes moving on random directions while overlapping eachother", logo: Theme.Assets.clubbed, type: .clubbed),
        
        Animation(name: "Single Metaball", title: "Two cicle shapes animation", subTitle: "We have got two circular shapes moving with touch gestures", logo: Theme.Assets.singleMetaball, type: .singleMetaball),
    ]
}
