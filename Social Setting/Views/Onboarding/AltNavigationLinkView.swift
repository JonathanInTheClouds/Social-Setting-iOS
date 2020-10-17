//
//  AltNavigationLinkView.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/14/20.
//

import SwiftUI

struct AltNavigationLinkView<Content: View>: View {
    
    var action: () -> ()
    
    var destination: Content
    
    var leftText: String
    
    var rightImage: Image
    
    var body: some View {
        Button(action: action, label: {
            NavigationLink(destination: destination) {
                HStack {
                    Text(leftText)
                        .foregroundColor(Color.gray99)
                        .font(.headline)
                    Spacer()
                    rightImage
                        .foregroundColor(Color.gray79)
                }
                .padding(.horizontal, 15)
                .frame(height: 48)
                .background(Color.gray19)
                .cornerRadius(6)
            }
        })
    }
}

struct AltNavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        AltNavigationLinkView(action: {}, destination: SignInView(), leftText: "Sign Up", rightImage: Image(systemName: "chevron.right"))
    }
}
