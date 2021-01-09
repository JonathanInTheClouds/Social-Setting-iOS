//
//  MainNavLinkView.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import SwiftUI

struct MainButtonView<Content: View>: View {
    
    @Binding var shouldPush: Bool
    
    var title: String
    
    var destionation: Content
    
    var action: () -> ()
    
    
    var body: some View {
        Button(action: action, label: {
            NavigationLink(destination: destionation, isActive: $shouldPush) {
                HStack {
                    Spacer()
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(height: 48)
                .background(Color.baseColor)
                .cornerRadius(6)
                .onTapGesture(perform: action)
            }
        })
    }
}

struct StandardMainNavLink_Previews: PreviewProvider {
    static var previews: some View {
        MainButtonView(shouldPush: .constant(true), title: "Login", destionation: Text("Hello World"), action: {})
    }
}
