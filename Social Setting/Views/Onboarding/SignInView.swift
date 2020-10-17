//
//  SignUp.swift
//  Social Setting
//
//  Created by Jonathan Dowdell on 10/13/20.
//

import SwiftUI
import TextView

struct SignInView: View {
    
    @State var username: String = ""
    
    @State var password: String = ""
    
    @State var userEditing: Bool = true
    
    @State var passwordEditing: Bool = false
    
    @State var signInComplete: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.tertiarySystemBackground
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HeadView()
                        .padding(.bottom, 30)
                        .modifier(DismissingKeyboard())

                    SSTextView(field: $username, fieldEditing: $userEditing, placeholder: "Username", returnType: .continue, keyboardType: .default, enterAction: {
                        userEditing.toggle()
                        passwordEditing.toggle()
                    })
                        .padding(.bottom, 5)
                    
                    
                    SSTextView(field: $password, fieldEditing: $passwordEditing, placeholder: "Password", returnType: .done, keyboardType: .default, enterAction: {
                        passwordEditing.toggle()
                    })
                        .padding(.bottom, 15)
                    
                    HStack(spacing: 10) {
                        MainNavigationLinkView(action: {
                            signInComplete = true
                        }, destionation: SignUpView(), title: "Sign In", shouldPush: $signInComplete)
                    
                        AltNavigationLinkView(action: {
                            
                        }, destination: SignUpView(), leftText: "Sign Up", rightImage: Image(systemName: "chevron.right"))
                    }
                    
                }
                .padding(.all, 30)
                .navigationBarHidden(true)
                .modifier(DismissingKeyboard())
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
