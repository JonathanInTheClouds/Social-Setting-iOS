//
//  SignUp.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/13/20.
//

import SwiftUI
import TextView

struct SignInView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var username: String = ""
    
    @State var password: String = ""
    
    @State var userEditing: Bool = true
    
    @State var passwordEditing: Bool = false
    
    @State var signInComplete: Bool = false
    
    @State var opacity: Double = 1
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.tertiarySystemBackground
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HeadView()
                        .padding(.bottom, 30)
                        .modifier(DismissingKeyboard())
                    
                    SSTextView(field: $username, fieldEditing: $userEditing,
                               placeholder: "Username",
                               returnType: .continue, keyboardType: .default, enterAction: {
                                userEditing.toggle()
                                passwordEditing.toggle()
                               })
                        .padding(.bottom, 5)
                    
                    
                    SSTextView(field: $password, fieldEditing: $passwordEditing,
                               placeholder: "Password",
                               returnType: .done,
                               keyboardType: .default, isSecure: true, enterAction: {
                                passwordEditing.toggle()
                               })
                        .padding(.bottom, 15)
                    
                    HStack(spacing: 10) {
                        MainNavigationLinkView(action: signIn, destionation: SignUpView(), title: "Sign In", shouldPush: $signInComplete)
                        
                        AltNavigationLinkView(action: {
                            
                        }, destination: SignUpView(), leftText: "Sign Up", rightImage: Image(systemName: "chevron.right"))
                    }
                    
                }
                .padding(.all, 30)
                .navigationBarHidden(true)
                .modifier(DismissingKeyboard())
                .opacity(opacity).onAnimationCompleted(for: opacity) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        self.authViewModel.validationConfirmed = true
                    }
                }
            }
        }
    }
    
    func signIn() {
        let signInRequest = SignInRequestModel(username: username, password: password)
        authViewModel.signIn(signInRequest: signInRequest) { (result) in
            switch result {
            case .success(_):
                withAnimation {
                    opacity = 0
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    
    @State static var field = ""
    
    static var previews: some View {
        Group {
            SignInView()
                .environment(\.colorScheme, .light)
            
            SignInView()
                .environment(\.colorScheme, .dark)
        }
    }
}

private struct HeadView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("Welcome to\nSocial Setting")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray99)
                    .bold()
                
                Spacer()
                
                Image("large-logo")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .aspectRatio(contentMode: .fit)
            }
            
            Text("In a world of mixed sentiment \ndo you stand out")
                .foregroundColor(Color.gray99)
                .fixedSize()
                .padding(.bottom, 20)
        }
    }
}
