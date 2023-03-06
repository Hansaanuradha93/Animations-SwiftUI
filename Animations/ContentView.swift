//
//  ContentView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SingleMetaBallAnimation()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
