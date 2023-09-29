//
//  ReckKey.swift
//  Animations
//
//  Created by Hansa Wickramanayake on 2023-09-28.
//

import SwiftUI

struct ReckKey: PreferenceKey {
    static let defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
