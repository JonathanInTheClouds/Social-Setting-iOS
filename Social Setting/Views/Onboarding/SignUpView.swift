//
//  SignUp.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/14/20.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var email: String = ""
    
    @State var username: String = ""
    
    @State var fullname: String = ""
    
    @State var password: String = ""
    
    @State var emailEditing: Bool = false
    
    @State var userEditing: Bool = false
    
    @State var fullnameEditing: Bool = false
    
    @State var passwordEditing: Bool = false
    
    @State var signUpComplete: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.tertiarySystemBackground
                .ignoresSafeArea()
            VStack {
                AltNavigationLinkView(action: {
                    
                }, destination: SignUpView(), leftText: "Sign Up With Facebook", rightImage: Image(systemName: "chevron.right"))
                .padding(.bottom, 5)
                
                Text("or sign up with Email")
                    .font(.footnote)
                    .foregroundColor(Color.gray79)
                    .padding(.bottom, 5)
                
                SSTextView(field: $fullname, fieldEditing: $fullnameEditing, placeholder: "Full name", enterAction: {
                    fullnameEditing.toggle()
                    userEditing.toggle()
                })
                .padding(.bottom, 5)
                
                SSTextView(field: $username, fieldEditing: $userEditing, placeholder: "Username", enterAction: {
                    userEditing.toggle()
                    emailEditing.toggle()
                })
                .padding(.bottom, 5)
                
                SSTextView(field: $email, fieldEditing: $emailEditing, placeholder: "Email Address", keyboardType: .emailAddress, enterAction: {
                    emailEditing.toggle()
                    passwordEditing.toggle()
                })
                .padding(.bottom, 5)
                
                SSTextView(field: $password, fieldEditing: $passwordEditing, placeholder: "Password", returnType: .done, isSecure: true, enterAction: {
                    passwordEditing = false
                })
                .padding(.bottom, 15)
                
                MainNavigationLinkView(action: signUp, destionation: SecureCodeView(), title: "Continue", shouldPush: $signUpComplete)
                    .padding(.bottom, 50)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 30)
            .modifier(DismissingKeyboard())
        }
    }
    
    private func signUp() {
        let signUpRequestModel = SignUpRequestModel(email: email, username: username, password: password, profileName: fullname)
        authViewModel.signUp(signUpRequest: signUpRequestModel) { (result) in
            switch (result) {
            case .success():
                signUpComplete = true
            case .failure(let authError):
                print(authError)
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignUpView()
                .environment(\.colorScheme, .light)
            
            SignUpView()
                .environment(\.colorScheme, .dark)
        }
    }
}

