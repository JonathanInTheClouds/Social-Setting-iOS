//
//  SSTextField.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/22/20.
//

import SwiftUI

struct SSTextField: View {
    
    @State var username = ""
    @State var userEditing = false
    
    @State var password = ""
    @State var passwordEditing = false
    
    var body: some View {
        VStack {
            SSTextView(field: $username, fieldEditing: $userEditing, placeholder: "Username") {
                passwordEditing.toggle()
                userEditing.toggle()
            }
            CustomTextField(text: $password, placeholder: "Password", isSecure: true, isFirstResponder: passwordEditing, onCommit: {
                passwordEditing.toggle()
                userEditing.toggle()
            })
            .frame(height: 21, alignment: .center)
            .padding()
            .background(Color.gray19)
            .cornerRadius(6)
        }
    }
}

struct SSTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SSTextField()
                .environment(\.colorScheme, .light)
                .padding(.horizontal, 30)
            
            SSTextField()
                .environment(\.colorScheme, .dark)
                .padding(.horizontal, 30)
        }
    }
}
