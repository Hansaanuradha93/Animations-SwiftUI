//
//  Animation.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-12.
//

import Foundation

// MARK: Promotion Model
struct Animation: Identifiable {
    
    enum AnimationType {
        case clubbed
        case singleMetaball
    }
    
    var id: String = UUID().uuidString
    var name: String
    var title: String
    var subTitle: String
    var logo: String
    var type: AnimationType
}

// MARK: - Data
extension Animation {
    
    static let animations: [Animation] = [
        Animation(name: "Clubbed", title: "Several rectangular shapes animation", subTitle: "We have got several rectangular shapes moving on random directions while overlapping eachother", logo: "clubbed", type: .clubbed),
        
        Animation(name: "Single Metaball", title: "Two cicle shapes animation", subTitle: "We have two circular shapes moving with touch gestures", logo: "single-metaball", type: .singleMetaball),
    ]
}