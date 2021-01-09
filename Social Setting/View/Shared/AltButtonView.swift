//
//  AltNavigationLinkView.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import SwiftUI

struct AltButtonView<Content: View>: View {
    
    var leftText: String
    
    var rightImage: Image
    
    var destination: Content
    
    var backgroundColor = Color.gray19
    
    var action: () -> ()
    
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
                .background(backgroundColor)
                .cornerRadius(6)
            }
        })
    }
}

struct AltNavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        AltButtonView(leftText: "Sign Up", rightImage: Image(systemName: "chevron.right"), destination: Text("Hellow"), action: {})
    }
}
