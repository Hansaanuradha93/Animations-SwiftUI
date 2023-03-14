//
//  DropDownPickerView.swift
//  Animations
//
//  Created by Hansa Anuradha on 2023-03-14.
//

import SwiftUI

struct DropDownPickerView: View {
    
    let content = ["Easy", "Normal", "Hard", "Expert"]
    @State private var selection: String = "Easy"
    
    var body: some View {
        
        VStack {
            
            DropDown(content: content,
                     selection: $selection,
                     activeTint: .primary.opacity(0.1),
                     inactiveTint: .primary.opacity(0.05),
                     dynamic: true)
            .frame(width: 130)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(
            Theme.Colors.bgGray
                .ignoresSafeArea()
        )
    }
}

struct DropDownPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownPickerView()
    }
}

// MARK: -
struct DropDown: View {
    
    /// Dropdown Properties
    var content: [String]
    @Binding var selection: String
    var activeTint: Color
    var inactiveTint: Color
    var dynamic: Bool = true
    
    /// View Properties
    @State private var expandedView: Bool = false
    var dropdownItemHeight: CGFloat = 55
    
    var body: some View {
        
        GeometryReader { proxy in
            
            let size = proxy.size
            
            VStack(alignment: .leading, spacing: 0) {
                
                if !dynamic {
                    RowView(selection, size)
                }
                
                ForEach(content.filter {
                    dynamic ? true : $0 != selection
                }, id: \.self) { item in
                    RowView(item, size)
                }
            }
            .background {
                Rectangle()
                    .fill(inactiveTint)
            }
            /// Moving View Based On The Selection
            .offset(y: dynamic ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -dropdownItemHeight) : 0)
        }
        .frame(height: dropdownItemHeight)
        .overlay(alignment: .trailing) {
            
            Theme.Assets.chevronUpDown
                .padding(.trailing, 10)
        }
        .mask(alignment: .top) {
            Rectangle()
                .frame(height: expandedView ? (dropdownItemHeight * CGFloat(content.count)) : (dropdownItemHeight))
                /// Move The Mask Base On The Selection So That Every Item Will Be Visible
                /// Visible Only When Dropdown Is Expanded
                .offset(y: dynamic && expandedView ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -dropdownItemHeight) : 0)
        }
    }
    
    /// Row View
    @ViewBuilder
    func RowView(_ item: String, _ size: CGSize) -> some View {
        
        Text(item)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .background {
                if selection == item {
                    Rectangle()
                        .fill(activeTint)
                        .transition(.identity)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    
                    /// If Expanded Then Make the Selection
                    if expandedView {
                        expandedView = false
                        
                        /// Disable Animation For Non-Dynamic Content
                        if dynamic {
                            selection = item
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                selection = item
                            }
                        }
                    } else {
                        /// Disabling Outside Taps
                        if selection == item {
                            expandedView = true
                        }
                    }
                    
                }
            }
    }
}
