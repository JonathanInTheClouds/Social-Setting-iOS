//
//  SignInView.swift
//  Social Setting
//
//  Created by Mettaworldj on 12/31/20.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        NavigationView {
            DynamicBackground(.horizontal, 30) {
                HeadingView()
                    .padding(.bottom, 30)
                
                TextInputViews()
            }
            .navigationBarHidden(true)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignInView()
            
            SignInView()
                .environment(\.colorScheme, .dark)
        }
    }
}

private struct HeadingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(alignment: .top) {
                Text("Welcome \nto Social Setting")
                    .font(.largeTitle)
                    .foregroundColor(.labelColor)
                    .bold()
                
                Spacer()
                
                Image("large-logo")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
            }
            
            Text("Talk about random things \nto random people on the intenet")
                .foregroundColor(Color.labelColor)
                .fixedSize()
                .padding(.bottom, 20)
        }
    }
}

private struct TextInputViews: View {
    
    @State private var username: String = ""
    @State private var usernameEditing: Bool = true
    
    @State private var password: String = ""
    @State private var passwordEditing: Bool = false
    
    @State private var sucessfullySignedIn: Bool = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            StandardInputView(field: $username, fieldEditing: $usernameEditing,
                              placeholder: "Username", returnType: .next) {
                usernameEditing.toggle()
                passwordEditing.toggle()
            }
            
            StandardInputView(field: $password, fieldEditing: $passwordEditing,
                              placeholder: "Password", returnType: .go,
                              keyboardType: .default, isSecure: true) {
                passwordEditing = false
            }
            
            HStack(spacing: 10) {
                MainButtonView(shouldPush: $sucessfullySignedIn, title: "Sign In", destionation: Text("Hello World")) {
                    let request = SignInRequest(username: username, password: password)
                    authViewModel.signIn(signinRequest: request)
                }
                
                AltButtonView(leftText: "Sign Up", rightImage: Image(systemName: "chevron.right"), destination: SignUpView()) {
                    
                }
            }
            .padding(.vertical, 5)
        }
    }
}
