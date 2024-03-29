//
//  CustomBottomSheetView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-29.
//

import SwiftUI

struct CustomBottomSheetView: View {
    
    /// Animation Properties
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    var body: some View {
        
        /// Animation Sheet Background (To Look Like It's Expanding From The Bottom)
        ZStack {
            
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            } else {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .overlay {
                        /// Music Info
                        MusicInfoView(expandSheet: $expandSheet,
                                  animation: animation)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
            }
        }
        .frame(height: 70)
        /// 49: Default Tab Bar Height
        .offset(y: -49)
    }
}

struct CustomBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
            .preferredColorScheme(.dark)
    }
}
