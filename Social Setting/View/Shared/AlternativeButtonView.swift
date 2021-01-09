//
//  AlternativeButtonView.swift
//  Social Setting
//
//  Created by Mettaworldj on 1/7/21.
//

import SwiftUI

struct AlternativeButtonView<Content: View>: View {
    
    var destination = Text("Hello")
    
    let content: () -> Content
    
    var action: () -> ()
    
    init(_ action: @escaping () -> (), @ViewBuilder _ content: @escaping () -> Content) {
        self.action = action
        self.content = content
    }
    
    var body: some View {
        Button(action: action, label: {
            NavigationLink(destination: destination) {
                content()
            }
        })
        .padding(.horizontal, 15)
    }
}

struct AlternativeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AlternativeButtonView({}, {
            Text("Hello World")
        })
        .frame(height: 30)
        .background(Color.gray79)
        .cornerRadius(6)
    }
}
