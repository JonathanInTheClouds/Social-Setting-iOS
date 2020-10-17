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
    
    @State var emailEditing: Bool = true
    
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
                
                TextView(text: $email, isEditing: $emailEditing, placeholder: "Email",
                         textHorizontalPadding: -4, textVerticalPadding: 0,
                         placeholderHorizontalPadding: -1, placeholderVerticalPadding: 1, returnType: UIReturnKeyType.next, shouldChange: { _, character -> Bool in
                            let isEntered = character == "\n"
                            if isEntered {
                                userEditing.toggle()
                                passwordEditing.toggle()
                            }
                            return isEntered ? false : true
                         })
                    .frame(height: 21, alignment: .center)
                    .padding()
                    .background(Color.gray19)
                    .cornerRadius(6)
                    .keyboardType(.default)
                    .padding(.bottom, 5)
                
                
                TextView(text: $username, isEditing: $userEditing, placeholder: "Username",
                         textHorizontalPadding: -4, textVerticalPadding: 0,
                         placeholderHorizontalPadding: -1, placeholderVerticalPadding: 1, returnType: UIReturnKeyType.next, shouldChange: { _, character -> Bool in
                            let isEntered = character == "\n"
                            if isEntered {
                                userEditing.toggle()
                                passwordEditing.toggle()
                            }
                            return isEntered ? false : true
                         })
                    .frame(height: 21, alignment: .center)
                    .padding()
                    .background(Color.gray19)
                    .cornerRadius(6)
                    .keyboardType(.default)
                    .padding(.bottom, 5)
                
                TextView(text: $password, isEditing: $passwordEditing, placeholder: "Password",
                         textHorizontalPadding: -4, textVerticalPadding: 0,
                         placeholderHorizontalPadding: -1, placeholderVerticalPadding: 1, returnType: UIReturnKeyType.next, shouldChange: { _, character -> Bool in
                            let isEntered = character == "\n"
                            if isEntered {
                                passwordEditing.toggle()
                                confirmPasswordEditing.toggle()
                            }
                            return isEntered ? false : true
                         })
                    .frame(height: 21, alignment: .center)
                    .padding()
                    .background(Color.gray19)
                    .cornerRadius(6)
                    .keyboardType(.default)
                    .padding(.bottom, 5)
                
                TextView(text: $confirmPassword, isEditing: $confirmPasswordEditing, placeholder: "Confirm Password",
                         textHorizontalPadding: -4, textVerticalPadding: 0,
                         placeholderHorizontalPadding: -1, placeholderVerticalPadding: 1, returnType: UIReturnKeyType.done, shouldChange: { _, character -> Bool in
                            let isEntered = character == "\n"
                            if isEntered {
                                confirmPasswordEditing.toggle()
                            }
                            return isEntered ? false : true
                         })
                    .frame(height: 21, alignment: .center)
                    .padding()
                    .background(Color.gray19)
                    .cornerRadius(6)
                    .keyboardType(.default)
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

