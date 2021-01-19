//
//  DynamicBackground.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import SwiftUI

struct DynamicBackground<Content: View>: View {
    
    let content: () -> Content
    
    var edge: Edge.Set
    
    var length: CGFloat?
    
    var alignment: HorizontalAlignment
    
    var spacing: CGFloat?
    
    var color: Color
    
    init(_ edge: Edge.Set = .all, _ length: CGFloat? = nil, alignment: HorizontalAlignment = .center, spacing: CGFloat? = nil, color: Color = Color.tertiarySystemBackground, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.edge = edge
        self.length = length
        self.alignment = alignment
        self.spacing = spacing
        self.color = color
    }
    
    var body: some View {
        ZStack {
            color
                .ignoresSafeArea()
            VStack(alignment: alignment, spacing: spacing) {
                content()
                    .modifier(DismissingKeyboard())
            }
            .padding(edge, length ?? 0)
        }
    }
}

struct DynamicBackground_Previews: PreviewProvider {
    static var previews: some View {
        DynamicBackground {
            Text("Hello")
        }
    }
}
