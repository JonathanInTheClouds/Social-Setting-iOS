//
//  SignUp.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/14/20.
//

import SwiftUI
import TextView

struct SignUpView: View {
    
    @State var email: String = ""
    
    @State var username: String = ""
    
    @State var password: String = ""
    
    @State var confirmPassword: String = ""
    
    @State var emailEditing: Bool = false
    
    @State var userEditing: Bool = false
    
    @State var passwordEditing: Bool = false
    
    @State var confirmPasswordEditing: Bool = false
    
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
                
                SSTextView(field: $email, fieldEditing: $emailEditing, placeholder: "Email", enterAction: {
                    emailEditing.toggle()
                    userEditing.toggle()
                })
                    .padding(.bottom, 5)
                
                
                SSTextView(field: $username, fieldEditing: $userEditing, placeholder: "Username", enterAction: {
                    userEditing.toggle()
                    passwordEditing.toggle()
                })
                    .padding(.bottom, 5)
                
                SSTextView(field: $password, fieldEditing: $passwordEditing, placeholder: "Password", enterAction: {
                    passwordEditing.toggle()
                    confirmPasswordEditing.toggle()
                })
                    .padding(.bottom, 5)
                
                SSTextView(field: $confirmPassword, fieldEditing: $confirmPasswordEditing, placeholder: "Confirm Password", enterAction: {
                    confirmPasswordEditing.toggle()
                })
                    .padding(.bottom, 15)
                
                MainNavigationLinkView(action: {
                    signUpComplete = true
                }, destionation: SecureCodeView(), title: "Continue", shouldPush: $signUpComplete)
                .padding(.bottom, 50)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 30)
            .modifier(DismissingKeyboard())
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

