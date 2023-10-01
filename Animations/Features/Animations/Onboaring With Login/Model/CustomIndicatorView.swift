//
//  CustomIndicatorView.swift
//  Animations
//
//  Created by Hansa Wickramanayake on 2023-10-01.
//

import SwiftUI

struct CustomIndicatorView: View {
    
    /// View Properties
    var totalPages: Int
    var currentPage: Int
    var activeTint: Color = .black
    var inactiveTint: Color = .gray.opacity(0.5)
    
    var body: some View {
        HStack {
            ForEach(0 ..< totalPages, id: \.self) {
                Circle()
                    .fill(currentPage == $0 ? activeTint : inactiveTint)
                    .frame(width: 4, height: 4)
            }
        }
    }
}

#Preview {
    CustomIndicatorView(totalPages: 5, currentPage: 1)
}
