//
//  SignUpView.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import SwiftUI

struct SignUpView: View {
    
    @State var fullName: String = ""
    @State var fullNameEditing: Bool = true
    
    @State var username: String = ""
    @State var usernameEditing: Bool = false
    
    @State var email: String = ""
    @State var emailEditing: Bool = false
    
    @State var password: String = ""
    @State var passwordEditing: Bool = false
    
    @State var sucessfullySignedUp: Bool = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        DynamicBackground(.horizontal, 30, alignment: .center) {
            VStack(spacing: 10) {
                
                StandardInputView(field: $fullName, fieldEditing: $fullNameEditing, placeholder: "Full Name") {
                    fullNameEditing.toggle()
                    usernameEditing.toggle()
                }
                
                StandardInputView(field: $username, fieldEditing: $usernameEditing, placeholder: "Username") {
                    usernameEditing.toggle()
                    emailEditing.toggle()
                }
                
                StandardInputView(field: $email, fieldEditing: $emailEditing, placeholder: "Email Address", keyboardType: .emailAddress) {
                    emailEditing.toggle()
                    passwordEditing.toggle()
                }
                
                StandardInputView(field: $password, fieldEditing: $passwordEditing, placeholder: "Password", isSecure: true) {
                    passwordEditing = false
                }
                
                HStack(spacing: 10) {
                    MainButtonView(shouldPush: $authViewModel.sucessfullySignedUp, title: "Sign Up", destionation: VerifyCodeView()) {
                        let signUpRequest = SignUpRequest(email: email, username: username, profileName: fullName, password: password)
                        authViewModel.signUp(signUpRequest: signUpRequest)
                    }
                    
                    AltButtonView(leftText: "Apple", rightImage: Image(systemName: "chevron.right"), destination: SignUpView()) {
                        
                    }
                }
                .padding(.top, 3)
                
            }
            .padding(.bottom, 55)
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("large-logo")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView()
            
            SignUpView()
                .environment(\.colorScheme, .dark)
        }
    }
}
