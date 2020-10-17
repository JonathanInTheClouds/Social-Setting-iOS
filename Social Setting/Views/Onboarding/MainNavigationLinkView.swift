//
//  MainNavigationLinkView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/13/20.
//

import SwiftUI

struct MainNavigationLinkView<Content: View>: View {
    
    var action: () -> ()
    
    var destionation: Content
    
    var title: String
    
    @Binding var shouldPush: Bool
    
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

struct MainNavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        BindingProvider(false) { bind in
            MainNavigationLinkView(action: {
                print("Moving Alone")
            }, destionation: SignInView(), title: "Continue", shouldPush: bind)
        }
    }
}
