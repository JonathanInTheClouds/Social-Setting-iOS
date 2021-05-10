//
//  SocialButton.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 4/28/21.
//

import SwiftUI

struct SocialButton<Content: View>: View {
    
    let action: () -> ()
    
    let bodyContent: () -> Content
    
    
    var body: some View {
        Button(action: action, label: {
            bodyContent()
            .padding(.vertical, 11)
            .padding(.horizontal, 16)
        })
        .background(Color.fillQuarternary)
        .cornerRadius(10)
    }
}

struct SocialButton_Preview: PreviewProvider {
    static var previews: some View {
        SocialButton {
            
        } bodyContent: {
            Image("Google Logo")
        }
    }
}
